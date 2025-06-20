# Security & Compliance: BIG Live Portal

## Executive Summary

The BIG Live Portal security architecture implements a comprehensive defense-in-depth strategy to protect sensitive artist data, financial information, and contractual documents within the performing arts ecosystem. The platform handles critical data including tax identifiers, personal information, financial records, and confidential contracts while ensuring compliance with GDPR, CCPA, and contractor regulations. Key security measures include JWT-based authentication with optional Azure AD SSO, field-level encryption for sensitive data, role-based access control with multi-company isolation, comprehensive audit logging, and secure integrations with SharePoint, Xero, and e-signature providers. The architecture prioritizes data privacy, secure mobile access, and regulatory compliance while maintaining the flexibility needed for performing arts organizations.

## Security Architecture

### Defense-in-Depth Layers
```
┌─────────────────────────────────────────────────┐
│            External Attack Surface               │
├─────────────────────────────────────────────────┤
│  1. Network Security (WAF, DDoS Protection)     │
├─────────────────────────────────────────────────┤
│  2. Application Security (Auth, Input Valid)    │
├─────────────────────────────────────────────────┤
│  3. Data Security (Encryption, Access Control)  │
├─────────────────────────────────────────────────┤
│  4. Infrastructure Security (Hardening, Patch)  │
├─────────────────────────────────────────────────┤
│  5. Physical Security (Data Center Controls)    │
└─────────────────────────────────────────────────┘
```

### Security Principles
1. **Least Privilege**: Users and systems have minimum required access
2. **Defense in Depth**: Multiple layers of security controls
3. **Zero Trust**: Verify everything, trust nothing
4. **Secure by Default**: Security enabled without configuration
5. **Fail Secure**: System fails to a secure state

## Authentication & Identity Management

### Authentication Methods

#### Primary Authentication
```yaml
Method: JWT-based authentication
Token Type: Access Token + Refresh Token
Access Token TTL: 24 hours
Refresh Token TTL: 30 days
Algorithm: RS256 (RSA Signature with SHA-256)
Token Storage: HttpOnly secure cookies
```

#### Multi-Factor Authentication (MFA)
```yaml
Required For:
  - Admin users: Always
  - Finance/Accountant users: Always
  - Regular artists: Optional (strongly recommended)
  - API access: Required for sensitive operations

Supported Methods:
  - TOTP (Google Authenticator, Authy)
  - SMS (with fallback)
  - Email codes
  - WebAuthn/FIDO2
  - Backup codes (10 one-time use)
  - Azure AD MFA (when SSO enabled)
```

### Password Policy
```yaml
Minimum Length: 12 characters
Complexity Requirements:
  - At least 1 uppercase letter
  - At least 1 lowercase letter
  - At least 1 number
  - At least 1 special character

Additional Controls:
  - Password history: Last 12 passwords
  - Password age: Maximum 90 days
  - Account lockout: 5 failed attempts
  - Lockout duration: 30 minutes
  - Password strength meter: zxcvbn library
  - Argon2id hashing with 250ms computation time
```

### Session Management
```yaml
Session Controls:
  - Absolute timeout: 8 hours
  - Idle timeout: 30 minutes
  - Concurrent sessions: 3 per user
  - Session binding: IP and User-Agent
  - Secure cookie flags: HttpOnly, Secure, SameSite=Strict
  - Redis-backed sessions with automatic cleanup
  - Device tracking and management
```

## Authorization & Access Control

### Role-Based Access Control (RBAC)

#### Role Hierarchy
```
System Admin
    ├── Company Admin
    │   ├── Accountant
    │   ├── Production Manager
    │   └── Artist
    └── Auditor (Read-Only)
```

#### Permission Matrix
| Resource | Artist | Production Manager | Accountant | Admin | Auditor |
|----------|--------|-------------------|------------|-------|---------|
| Own Profile | CRUD | R | R | RU | R |
| Own Contracts | R | - | - | CRUD | R |
| Own Expenses | CRU | - | RU | CRUD | R |
| All Contracts | - | R | R | CRUD | R |
| All Expenses | - | - | RU | CRUD | R |
| Schedules | R (assigned) | CRUD | R | CRUD | R |
| Financial Reports | - | - | R | RU | R |
| User Management | - | - | - | CRUD | - |
| Audit Logs | - | - | - | R | R |

### Attribute-Based Access Control (ABAC)
```javascript
// Multi-company data isolation policy
{
  "resource": "artist_data",
  "action": "read",
  "conditions": {
    "user.company_id": "${resource.company_id}",
    "user.role": ["admin", "accountant", "production_manager"],
    "resource.status": "active"
  }
}

// Artist self-service policy
{
  "resource": "expense",
  "action": "create",
  "conditions": {
    "user.id": "${resource.artist_id}",
    "user.role": "artist",
    "user.profile_complete": true,
    "resource.amount": { "$lte": 1000 }
  }
}
```

## Data Security

### Encryption Standards

#### Data at Rest
```yaml
Database Encryption:
  Method: AES-256-GCM
  Key Management: AWS KMS / Azure Key Vault
  Key Rotation: Quarterly
  Field-Level Encryption:
    - tax_id_encrypted
    - bank_account_details
    - emergency_contact
  
File Storage:
  Method: AES-256-CBC
  Key per file: Yes
  SharePoint: Native encryption
  Temp Storage: S3 server-side encryption

Backup Encryption:
  Method: AES-256-GCM
  Separate keys: Yes
  Offline key storage: Yes
  Point-in-time recovery: 7 days
```

#### Data in Transit
```yaml
TLS Configuration:
  Minimum Version: TLS 1.2
  Preferred Version: TLS 1.3
  Cipher Suites:
    - TLS_AES_256_GCM_SHA384
    - TLS_CHACHA20_POLY1305_SHA256
    - TLS_AES_128_GCM_SHA256
  
Certificate Management:
  Provider: Let's Encrypt / DigiCert
  Renewal: Automated 30 days before expiry
  Pinning: HPKP headers for mobile apps
  OCSP Stapling: Enabled
```

### Data Classification
| Classification | Description | Security Controls |
|----------------|-------------|-------------------|
| **Critical** | Tax IDs, bank details, SSNs | Field encryption, access logging, audit trail |
| **Confidential** | Contracts, financial data, PII | Encryption, RBAC, audit logging |
| **Internal** | Schedules, production data | Access control, retention limits |
| **Public** | Artist bios, production info | Integrity protection only |

### Data Loss Prevention (DLP)
```yaml
Monitoring:
  - API response filtering for SSN/TIN patterns
  - Outbound email scanning for sensitive data
  - File upload/download monitoring
  - Database query result filtering
  - SharePoint access tracking

Actions:
  - Block: Prevent tax ID exposure
  - Alert: Notify security team
  - Redact: Mask sensitive data (show last 4 digits)
  - Log: Audit trail for compliance
  
Patterns:
  - SSN: XXX-XX-#### display format
  - Credit Card: Not stored, tokenized if needed
  - Tax ID: Encrypted immediately upon entry
```

## Application Security

### Input Validation & Sanitization
```yaml
Validation Rules:
  - Whitelist acceptable inputs using Joi schemas
  - Length limits on all fields (max 50MB files)
  - Type checking with TypeScript strict mode
  - Encoding validation (UTF-8 only)
  - SQL injection prevention (Prisma parameterized queries)
  - XSS prevention (React auto-escaping + DOMPurify)
  - XXE prevention (disable external entities)
  - Path traversal prevention
  - File type validation (magic numbers)
  - Virus scanning (ClamAV) for uploads
  
API Rate Limiting:
  - Per user: 100 requests/minute
  - Per IP: 1000 requests/hour
  - Upload endpoints: 10 requests/minute
  - Burst protection: 100 requests/minute max
  - Response headers indicate limits
```

### Security Headers
```nginx
# Nginx configuration
add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload";
add_header X-Frame-Options "DENY";
add_header X-Content-Type-Options "nosniff";
add_header X-XSS-Protection "1; mode=block";
add_header Referrer-Policy "strict-origin-when-cross-origin";
add_header Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; font-src 'self'; connect-src 'self' wss://portal.biglive.com https://api.sharepoint.com https://api.xero.com https://api.docusign.com; frame-ancestors 'none';";
add_header Permissions-Policy "geolocation=(), microphone=(), camera=(self)";
```

### API Security
```yaml
Authentication:
  - Bearer token required (JWT)
  - API key + secret for service accounts
  - Request signing (HMAC-SHA256) for webhooks
  - CSRF protection (double-submit cookies)

Authorization:
  - Scope-based permissions
  - Resource-level access control
  - Company isolation enforcement
  - Rate limiting per endpoint

Validation:
  - JSON schema validation
  - Request size limits (10MB)
  - Timeout protection (30s)
  - Content-Type enforcement
```

## Infrastructure Security

### Network Security
```yaml
Firewall Rules:
  - Default: Deny all
  - Inbound: 
    - 443/tcp (HTTPS) from anywhere
    - 80/tcp (HTTP) redirect to HTTPS
    - 22/tcp (SSH) from bastion only
  - Outbound:
    - 443/tcp (HTTPS) to approved APIs
    - 587/tcp (SMTP) to SendGrid
    - 53/udp (DNS)

Network Segmentation:
  - Public subnet: Load balancers only
  - Private subnet: Application servers
  - Data subnet: Databases (no internet access)
  - Management subnet: Admin bastion access

VPN Access:
  - Required for: Production SSH access
  - Protocol: OpenVPN / WireGuard
  - MFA: Always required
  - IP allowlist: Admin locations only
```

### Container Security
```dockerfile
# Dockerfile security practices
FROM node:20-alpine AS builder
# Security updates
RUN apk update && apk upgrade
# Run as non-root user
RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001
# Copy only necessary files
COPY --chown=nodejs:nodejs package*.json ./
RUN npm ci --only=production && npm cache clean --force
# Minimal final image
FROM node:20-alpine
RUN apk add --no-cache dumb-init
# Copy from builder
COPY --from=builder --chown=nodejs:nodejs /app /app
# Security hardening
RUN chmod -R 550 /app
USER nodejs
EXPOSE 3000
ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "server.js"]
```

### Secrets Management
```yaml
Storage:
  - Provider: AWS Secrets Manager / Azure Key Vault
  - Encryption: AES-256-GCM
  - Access: Role-based with audit logging
  - No secrets in code or environment variables

Rotation:
  - Database passwords: 90 days
  - API keys: 180 days
  - JWT signing keys: 365 days
  - SSL certificates: Before expiry
  - Service account credentials: 90 days

Usage:
  - Runtime retrieval only
  - Cached for 5 minutes
  - Audit all access
  - Alert on failures
```

## Monitoring & Logging

### Security Monitoring
```yaml
SIEM Integration:
  - Provider: DataDog Security Monitoring / AWS CloudWatch
  - Log retention: 1 year
  - Real-time alerts: Yes
  - Correlation rules: Custom

Monitored Events:
  - Authentication (success/failure)
  - Authorization failures
  - Tax ID access attempts
  - Contract view/download
  - Expense approval actions
  - Configuration changes
  - Privilege escalations
  - API rate limit violations
  - File upload/download
  - SharePoint access
```

### Audit Logging
```json
{
  "timestamp": "2024-01-20T10:30:45.123Z",
  "event_type": "sensitive_data_access",
  "user_id": "123e4567-e89b-12d3-a456-426614174000",
  "user_role": "accountant",
  "company_id": "comp_789",
  "session_id": "sess_abc123",
  "ip_address": "192.168.1.100",
  "user_agent": "Mozilla/5.0...",
  "resource": {
    "type": "artist_tax_id",
    "id": "artist_456",
    "classification": "critical"
  },
  "action": "view",
  "result": "success",
  "metadata": {
    "reason": "1099_preparation",
    "fields_accessed": ["tax_id_last_four"]
  }
}
```

### Alerting Rules
| Alert | Condition | Response |
|-------|-----------|----------|
| Brute Force | 10 failed logins/5 min | Block IP, notify admin |
| Tax ID Access | Any access to full tax ID | Log and notify finance |
| Mass Data Export | >100 records/hour | Suspend account, investigate |
| Privilege Escalation | Role change to admin | Manual review required |
| After-Hours Access | Financial data outside 8-6 | Alert and monitor |
| Failed Azure AD Sync | 3 consecutive failures | IT team notification |

## Incident Response

### Incident Response Plan

#### 1. Detection & Analysis
```yaml
Detection Sources:
  - Automated security alerts
  - User reports via security@biglive.com
  - Third-party vulnerability notifications
  - Regular penetration testing
  - Compliance audits

Initial Analysis:
  - Severity classification (P1-P4)
  - Data exposure assessment
  - Evidence preservation
  - Legal notification requirements
```

#### 2. Containment
```yaml
Immediate Actions:
  - Isolate affected systems
  - Disable compromised accounts
  - Block malicious IPs
  - Preserve audit logs
  - Stop data exfiltration

Short-term Containment:
  - Reset affected credentials
  - Apply emergency patches
  - Increase monitoring
  - Notify affected users
```

#### 3. Eradication & Recovery
```yaml
Eradication:
  - Remove malicious code
  - Patch vulnerabilities
  - Update security controls
  - Reset MFA tokens

Recovery:
  - Restore from encrypted backups
  - Rebuild compromised systems
  - Verify data integrity
  - Gradual service restoration
  - User communication
```

#### 4. Post-Incident
```yaml
Activities:
  - Root cause analysis
  - Timeline reconstruction
  - Lessons learned meeting
  - Control improvements
  - Compliance reporting
  - User notification (within 72 hours for GDPR)
```

### Contact Information
| Role | Contact | Escalation |
|------|---------|------------|
| Security Lead | security@biglive.com | On-call rotation |
| Data Protection Officer | dpo@biglive.com | 24/7 hotline |
| Legal Counsel | legal@biglive.com | Business hours |
| Infrastructure Team | devops@biglive.com | PagerDuty |

## Compliance

### GDPR Compliance
```yaml
Data Subject Rights:
  - Right to Access: Export profile + all data
  - Right to Rectification: Direct profile editing
  - Right to Erasure: Account deletion (except tax records)
  - Right to Portability: JSON/CSV export
  - Right to Object: Marketing opt-out

Technical Measures:
  - Privacy by Design in all features
  - Data minimization (collect only required)
  - Purpose limitation (documented uses)
  - Consent management system
  - 30-day deletion for non-financial data
  - 7-year retention for tax records

Implementation:
  - Privacy settings in user profile
  - Consent checkboxes on registration
  - Cookie consent banner
  - Data export API endpoint
  - Automated deletion workflows
```

### CCPA Compliance
```yaml
California Resident Rights:
  - Right to Know: What data collected
  - Right to Delete: Remove personal info
  - Right to Opt-Out: No data selling
  - Right to Non-Discrimination

Implementation:
  - "Do Not Sell" link in footer
  - Privacy rights request form
  - 45-day response deadline
  - Annual privacy training
  - Vendor data processing agreements
```

### SOC 2 Type II Controls
| Control Family | Implementation |
|----------------|----------------|
| **CC1: Control Environment** | Security policies, annual training, board oversight |
| **CC2: Communication** | Security awareness program, incident reporting |
| **CC3: Risk Assessment** | Annual assessment, threat modeling, vendor reviews |
| **CC4: Monitoring** | SIEM, continuous monitoring, quarterly audits |
| **CC5: Control Activities** | Change control, segregation of duties |
| **CC6: Logical Access** | MFA, RBAC, privileged access management |
| **CC7: System Operations** | Monitoring, incident response, backup testing |
| **CC8: Change Management** | Code reviews, testing, deployment approvals |
| **CC9: Risk Mitigation** | Insurance, vendor assessments, BCP testing |

### Tax Compliance
```yaml
1099 Reporting Requirements:
  - Secure collection of tax IDs
  - Encrypted storage of TINs
  - Annual 1099-NEC generation
  - IRS submission via FIRE system
  - 7-year retention policy

Security Measures:
  - TIN masking (show last 4 only)
  - Audit trail for all access
  - Restricted to finance role
  - Backup withholding alerts
  - State tax compliance tracking
```

## Security Testing

### Vulnerability Assessment
```yaml
Frequency:
  - Automated scans: Weekly (OWASP ZAP)
  - Dependency checks: Daily (Snyk)
  - Manual assessment: Quarterly
  - Third-party pentest: Annually

Tools:
  - SAST: SonarQube, ESLint security plugin
  - DAST: OWASP ZAP, Burp Suite Pro
  - Dependencies: Snyk, npm audit, Dependabot
  - Infrastructure: AWS Inspector, Azure Security Center
  - Container scanning: Trivy, Clair
```

### Penetration Testing
```yaml
Scope:
  - External network penetration
  - Web application testing (OWASP Top 10)
  - API security testing
  - Mobile PWA testing
  - Social engineering (with approval)
  - SharePoint integration security

Methodology:
  - OWASP Testing Guide v4
  - PTES (Penetration Testing Execution Standard)
  - Focus on multi-company isolation
  - Tax ID protection verification
  - Session management testing
```

### Security Metrics
| Metric | Target | Measurement |
|--------|--------|-------------|
| Patch Time | <30 days (critical: <7) | Time to apply security patches |
| Vulnerability Resolution | <7 days (critical) | Time to fix after discovery |
| Security Training | 100% annually | Employee completion rate |
| Incident Response | <1 hour | Time to initial response |
| MFA Adoption | >80% artists | Percentage with MFA enabled |
| Audit Compliance | 100% | Clean audit findings |

## Secure Development

### SDLC Security
```yaml
Planning:
  - Threat modeling for new features
  - Security requirements gathering
  - Privacy impact assessments
  - Compliance requirement review

Development:
  - Secure coding standards (OWASP)
  - Peer code reviews
  - Security-focused unit tests
  - Dependency vulnerability checks

Testing:
  - Security test cases
  - Penetration testing
  - Compliance validation
  - Performance under attack

Deployment:
  - Security configuration review
  - Access control verification
  - Monitoring activation
  - Rollback procedures

Maintenance:
  - Security patch management
  - Continuous monitoring
  - Regular security reviews
  - Incident response updates
```

### Code Security Standards
```javascript
// Input validation example
const { joi } = require('joi');
const DOMPurify = require('isomorphic-dompurify');

// Expense submission validation
const expenseSchema = joi.object({
  amount: joi.number().positive().max(10000).required(),
  category: joi.string().valid('transportation', 'meals', 'accommodation', 'supplies', 'other').required(),
  description: joi.string().max(500).required(),
  expense_date: joi.date().max('now').required(),
  production_id: joi.string().uuid().required()
});

// SQL injection prevention with Prisma
async function getArtistContracts(artistId, companyId) {
  return await prisma.contract.findMany({
    where: {
      artist_id: artistId,
      production: {
        company_id: companyId
      }
    },
    select: {
      id: true,
      status: true,
      amount: true,
      start_date: true,
      end_date: true,
      // Never expose sensitive fields
      document_url: false
    }
  });
}

// XSS prevention for user content
function sanitizeAnnouncement(content) {
  return DOMPurify.sanitize(content, {
    ALLOWED_TAGS: ['b', 'i', 'em', 'strong', 'a', 'p', 'br'],
    ALLOWED_ATTR: ['href'],
    ALLOW_DATA_ATTR: false
  });
}

// Secure file upload
async function validateReceipt(file) {
  const allowedTypes = ['image/jpeg', 'image/png', 'application/pdf'];
  const maxSize = 50 * 1024 * 1024; // 50MB
  
  if (!allowedTypes.includes(file.mimetype)) {
    throw new Error('Invalid file type');
  }
  
  if (file.size > maxSize) {
    throw new Error('File too large');
  }
  
  // Verify magic numbers
  const fileTypeResult = await fileType.fromBuffer(file.buffer);
  if (!fileTypeResult || !allowedTypes.includes(fileTypeResult.mime)) {
    throw new Error('File type mismatch');
  }
  
  // Scan for viruses
  const scanResult = await clamav.scanBuffer(file.buffer);
  if (!scanResult.isClean) {
    throw new Error('Security threat detected');
  }
  
  return true;
}
```

## Third-Party Security

### Vendor Assessment
```yaml
Requirements:
  - SOC 2 Type II report (required)
  - Security questionnaire completion
  - Data processing agreement (GDPR)
  - Cyber insurance verification
  - Incident notification SLA (<24 hours)
  - Right to audit clause

Critical Vendors:
  - SharePoint: Microsoft security baseline
  - Xero: Financial data protection
  - DocuSign/Adobe Sign: E-signature compliance
  - SendGrid: Email security
  - Twilio: SMS security
  - Hubdoc: OCR data handling

Ongoing Monitoring:
  - Annual security review
  - Vulnerability notifications
  - Compliance certification updates
  - Performance and uptime tracking
  - Data residency verification
```

### Supply Chain Security
```yaml
Dependency Management:
  - Automated vulnerability scanning (Snyk)
  - License compliance checking
  - Version pinning in package-lock.json
  - Private npm registry for internal packages
  - Security advisories monitoring

Container Images:
  - Official base images only
  - Vulnerability scanning before deployment
  - Signed images with Notary
  - Minimal Alpine Linux base
  - Regular rebuild schedule (monthly)

API Security:
  - OAuth 2.0 for all integrations
  - API key rotation schedule
  - Webhook signature verification
  - TLS certificate validation
  - Rate limit handling
```

## Security Awareness & Training

### Training Program
| Audience | Topics | Frequency |
|----------|--------|-----------|
| All Staff | Security basics, phishing, data privacy | Onboarding + Annual |
| Developers | OWASP Top 10, secure coding, incident response | Quarterly |
| Administrators | Access management, compliance, audit trails | Bi-annual |
| Finance Team | PII handling, tax data security, fraud prevention | Quarterly |

### Security Champions
```yaml
Program Structure:
  - Security champion per team
  - Monthly security meetings
  - Vulnerability remediation involvement
  - Security training budget
  - Conference attendance support
  - Internal knowledge sharing
```

## Business Continuity

### Disaster Recovery Plan
```yaml
RTO (Recovery Time Objective): 4 hours
RPO (Recovery Point Objective): 1 hour

Backup Strategy:
  - Database: Hourly snapshots, daily full backup
  - Files: Real-time sync to secondary region
  - Configuration: Version controlled in Git
  - Secrets: Replicated across regions
  - Testing: Monthly restore verification

Failover Process:
  - Health check failures trigger alerts
  - Automatic failover to secondary region
  - DNS update (5 minute TTL)
  - User notification via status page
  - SharePoint reconnection procedures
```

### Data Retention & Disposal
| Data Type | Retention Period | Disposal Method |
|-----------|-----------------|-----------------|
| Tax Records | 7 years | Secure deletion with audit |
| Contracts | 7 years post-completion | Archive then secure delete |
| Financial Data | 7 years | Encrypted archive |
| User Profiles | Account lifetime + 30 days | Anonymization available |
| System Logs | 1 year | Automated rotation |
| Audit Trails | 7 years | Compressed archive |
| Backups | 30 days operational | Secure overwrite |

## Appendices

### A. Security Checklist
- [ ] All artist passwords meet complexity requirements
- [ ] MFA enabled for all admin/finance accounts
- [ ] SSL/TLS certificates valid and strong
- [ ] Security headers properly configured
- [ ] Input validation on all API endpoints
- [ ] Tax ID encryption verified
- [ ] SharePoint permissions aligned
- [ ] Audit logging operational
- [ ] Incident response plan tested
- [ ] GDPR/CCPA compliance verified
- [ ] Penetration test findings remediated
- [ ] Security training completed

### B. Security Contacts
- Security Issues: security@biglive.com
- Data Protection: privacy@biglive.com
- Compliance: compliance@biglive.com
- Incident Response: incident@biglive.com
- Bug Reports: Use responsible disclosure

### C. References
- OWASP Top 10 2021
- CIS Controls v8
- NIST Cybersecurity Framework
- ISO 27001/27002
- GDPR Article 32 (Security of Processing)
- California Privacy Rights Act (CPRA)
- IRS Publication 1075 (Tax Information Security)

## Clarification Requests or Feedback

1. **Azure AD Integration Depth**: More details on the Azure AD tenant configuration, conditional access policies, and group mappings would help optimize the SSO implementation and ensure proper privilege management.

2. **SharePoint Security Model**: Understanding the existing SharePoint permission inheritance and information management policies would enable better alignment of the portal's access controls with SharePoint's native security features.

3. **Multi-Company Isolation Requirements**: Clarification on whether companies should have completely isolated data or if there are scenarios where data sharing is permitted (e.g., artists working for multiple companies) would refine the access control implementation.

4. **Compliance Audit Schedule**: Specific requirements for compliance audits (SOC 2, financial audits) and their frequency would help plan evidence collection and ensure continuous compliance readiness.

5. **Incident Response Team**: Details on the organization's existing incident response team structure and escalation procedures would enable better integration with current security operations.

6. **Data Residency Requirements**: Clarification on any data residency requirements for different jurisdictions would impact the infrastructure design and backup strategies.

7. **Third-Party Integration Security**: Specific security requirements or concerns with the external integrations (particularly Xero for financial data and DocuSign for contracts) would help prioritize security controls.

8. **Mobile Device Security**: Given the mobile-first approach, additional requirements for mobile device management (MDM) or mobile application management (MAM) would enhance the security posture for field users.