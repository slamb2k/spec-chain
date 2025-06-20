# Specification Chain: Security & Compliance

You are an expert security architect with 20+ years of experience designing secure, compliant systems for enterprise SaaS applications. You specialize in implementing defense-in-depth strategies, ensuring regulatory compliance, and protecting sensitive data. Create comprehensive security documentation that addresses all aspects of application security.

<user_data>
  <app_name>
  [APP NAME]
  </app_name>

  <data_sensitivity>
  [TYPES OF SENSITIVE DATA HANDLED]
  </data_sensitivity>

  <compliance_requirements>
  [GDPR, HIPAA, SOC2, PCI-DSS, etc.]
  </compliance_requirements>

  <user_roles>
  [USER TYPES AND ACCESS LEVELS]
  </user_roles>

  <technical_stack>
  [TECHNOLOGY CHOICES AFFECTING SECURITY]
  </technical_stack>
</user_data>

<task>
1. **Private reasoning:** Open a `<security_planning>` tag. Inside it follow the <analysis_checklist>.
    • Analyze security threats and attack vectors
    • Design comprehensive security controls
    • Plan compliance implementation
    • Close `</security_planning>` when done. Do **not** reveal its contents to the user.

2. **Public output:** After `</security_planning>`, output *only* the Security & Compliance Documentation using the Markdown structure found in <security_template>. Fill every placeholder with detailed specifications.

3. **Clarification or Feedback**
  If you require additional information to provide a more accurate response, record the item in the **Clarification Requests or Feedback** section below. The items recorded should be relevant to this document and if clarified, would improve the solution being defined.
  
  Additionally, if you have any suggestions on areas that should be addressed, please include these in the **Clarification Requests or Feedback** section so if user wishes to re-execute the spec-chain process, they can improve the output by including any additional suggested information.

4. **Stop:** End the interaction once complete security documentation has been delivered. Do not reveal chain-of-thought or planning notes at any stage.
</task>

<analysis_checklist>
1. Identify all potential threat vectors
2. Design authentication mechanisms
3. Plan authorization and access control
4. Define data encryption strategies
5. Design secure communication protocols
6. Plan vulnerability management
7. Define security monitoring and logging
8. Design incident response procedures
9. Plan compliance controls
10. Define security testing requirements
11. Design secure development practices
12. Plan security training requirements
13. Define third-party security requirements
14. Design data privacy controls
15. Plan disaster recovery and business continuity
</analysis_checklist>

<security_template markdown="true">
# Security & Compliance: [App Name]

## Executive Summary
[Overview of security posture, compliance requirements, and key security measures]

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
Access Token TTL: 15 minutes
Refresh Token TTL: 7 days
Algorithm: RS256 (RSA Signature with SHA-256)
```

#### Multi-Factor Authentication (MFA)
```yaml
Required For:
  - Admin users: Always
  - Regular users: Optional (recommended)
  - API access: Required for sensitive operations

Supported Methods:
  - TOTP (Google Authenticator, Authy)
  - SMS (with fallback)
  - Email codes
  - WebAuthn/FIDO2
  - Backup codes (10 one-time use)
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
```

### Session Management
```yaml
Session Controls:
  - Absolute timeout: 8 hours
  - Idle timeout: 30 minutes
  - Concurrent sessions: 3 per user
  - Session binding: IP and User-Agent
  - Secure cookie flags: HttpOnly, Secure, SameSite=Strict
```

## Authorization & Access Control

### Role-Based Access Control (RBAC)

#### Role Hierarchy
```
Super Admin
    ├── Organization Admin
    │   ├── Project Manager
    │   │   ├── Team Member
    │   │   └── Contributor
    │   └── Viewer
    └── API User
```

#### Permission Matrix
| Resource | Super Admin | Org Admin | Manager | Member | Viewer |
|----------|------------|-----------|---------|---------|---------|
| Users | CRUD | CRU | R | R | - |
| Projects | CRUD | CRUD | CRUD | RU | R |
| Billing | CRUD | RU | R | - | - |
| Settings | CRUD | RU | R | - | - |
| API Keys | CRUD | CRU | - | - | - |

### Attribute-Based Access Control (ABAC)
```javascript
// Example policy
{
  "resource": "project",
  "action": "update",
  "conditions": {
    "user.role": ["manager", "admin"],
    "user.department": "${resource.department}",
    "time.hour": { "$gte": 8, "$lte": 18 },
    "resource.status": { "$ne": "archived" }
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
  
File Storage:
  Method: AES-256-CBC
  Key per file: Yes
  Metadata encryption: Yes

Backup Encryption:
  Method: AES-256-GCM
  Separate keys: Yes
  Offline key storage: Yes
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
```

### Data Classification
| Classification | Description | Security Controls |
|----------------|-------------|-------------------|
| **Critical** | PII, credentials, payment data | Encryption, access logging, audit |
| **Confidential** | Business data, user content | Encryption, access control |
| **Internal** | System data, logs | Access control, retention limits |
| **Public** | Marketing content, docs | Integrity protection only |

### Data Loss Prevention (DLP)
```yaml
Monitoring:
  - API response filtering for PII patterns
  - Outbound email scanning
  - File upload/download monitoring
  - Database query result filtering

Actions:
  - Block: Prevent data exposure
  - Alert: Notify security team
  - Redact: Mask sensitive data
  - Log: Audit trail for compliance
```

## Application Security

### Input Validation & Sanitization
```yaml
Validation Rules:
  - Whitelist acceptable inputs
  - Length limits on all fields
  - Type checking (strict mode)
  - Encoding validation (UTF-8)
  - SQL injection prevention (parameterized queries)
  - XSS prevention (context-aware output encoding)
  - XXE prevention (disable external entities)
  - Path traversal prevention
  
API Rate Limiting:
  - Per user: 1000 requests/hour
  - Per IP: 5000 requests/hour
  - Burst: 100 requests/minute
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
add_header Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://trusted-cdn.com; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; font-src 'self'; connect-src 'self' https://api.example.com; frame-ancestors 'none';";
add_header Permissions-Policy "geolocation=(), microphone=(), camera=()";
```

### API Security
```yaml
Authentication:
  - Bearer token required
  - API key + secret for service accounts
  - Request signing (HMAC-SHA256)

Authorization:
  - Scope-based permissions
  - Resource-level access control
  - Rate limiting per endpoint

Validation:
  - JSON schema validation
  - Request size limits (10MB)
  - Timeout protection (30s)
```

## Infrastructure Security

### Network Security
```yaml
Firewall Rules:
  - Default: Deny all
  - Inbound: 
    - 443/tcp (HTTPS)
    - 22/tcp (SSH - restricted IPs)
  - Outbound:
    - 443/tcp (HTTPS)
    - 587/tcp (SMTP)
    - 53/udp (DNS)

Network Segmentation:
  - Public subnet: Load balancers only
  - Private subnet: Application servers
  - Data subnet: Databases (no internet)
  - Management subnet: Admin access

VPN Access:
  - Required for: Production access
  - Protocol: OpenVPN / WireGuard
  - MFA: Required
```

### Container Security
```dockerfile
# Dockerfile security practices
FROM node:16-alpine AS builder
# Run as non-root user
RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001
# Copy only necessary files
COPY --chown=nodejs:nodejs package*.json ./
RUN npm ci --only=production
# Minimal final image
FROM node:16-alpine
RUN apk add --no-cache dumb-init
COPY --from=builder --chown=nodejs:nodejs /app /app
USER nodejs
EXPOSE 3000
ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "server.js"]
```

### Secrets Management
```yaml
Storage:
  - Provider: HashiCorp Vault / AWS Secrets Manager
  - Encryption: AES-256-GCM
  - Access: Role-based with audit logging

Rotation:
  - Database passwords: 90 days
  - API keys: 180 days
  - Encryption keys: 365 days
  - Certificates: Before expiry

Usage:
  - No secrets in code or configs
  - Environment variable injection
  - Runtime retrieval for sensitive ops
```

## Monitoring & Logging

### Security Monitoring
```yaml
SIEM Integration:
  - Provider: Splunk / ELK Stack
  - Log retention: 1 year
  - Real-time alerts: Yes

Monitored Events:
  - Authentication (success/failure)
  - Authorization failures
  - Data access (sensitive resources)
  - Configuration changes
  - Privilege escalations
  - API anomalies
  - File integrity changes
```

### Audit Logging
```json
{
  "timestamp": "2024-01-20T10:30:45.123Z",
  "event_type": "data_access",
  "user_id": "123e4567-e89b-12d3-a456-426614174000",
  "session_id": "sess_abc123",
  "ip_address": "192.168.1.100",
  "user_agent": "Mozilla/5.0...",
  "resource": {
    "type": "customer_record",
    "id": "cust_456",
    "classification": "confidential"
  },
  "action": "read",
  "result": "success",
  "metadata": {
    "query_params": {"fields": ["name", "email"]},
    "response_size": 245
  }
}
```

### Alerting Rules
| Alert | Condition | Response |
|-------|-----------|----------|
| Brute Force | 10 failed logins/5 min | Block IP, notify |
| Data Exfiltration | >1000 records/hour | Suspend account |
| Privilege Escalation | Role change to admin | Manual review |
| Anomalous Access | Off-hours sensitive data | Investigate |
| Config Change | Production settings | Approval required |

## Incident Response

### Incident Response Plan

#### 1. Detection & Analysis
```yaml
Detection Sources:
  - Automated monitoring alerts
  - User reports
  - Third-party notifications
  - Routine audits

Initial Analysis:
  - Severity classification (P1-P4)
  - Impact assessment
  - Evidence collection
  - Stakeholder notification
```

#### 2. Containment
```yaml
Immediate Actions:
  - Isolate affected systems
  - Disable compromised accounts
  - Block malicious IPs
  - Preserve evidence

Short-term Containment:
  - Patch vulnerabilities
  - Reset credentials
  - Increase monitoring
```

#### 3. Eradication & Recovery
```yaml
Eradication:
  - Remove malicious code
  - Close attack vectors
  - Update security controls

Recovery:
  - Restore from clean backups
  - Rebuild compromised systems
  - Verify system integrity
  - Return to normal operations
```

#### 4. Post-Incident
```yaml
Activities:
  - Root cause analysis
  - Lessons learned meeting
  - Update response procedures
  - Security control improvements
  - Stakeholder report
```

### Contact Information
| Role | Contact | Escalation |
|------|---------|------------|
| Security Lead | security@example.com | +1-555-0100 |
| Engineering On-Call | ops@example.com | PagerDuty |
| Legal Counsel | legal@example.com | +1-555-0200 |
| PR/Communications | pr@example.com | +1-555-0300 |

## Compliance

### GDPR Compliance
```yaml
Data Subject Rights:
  - Right to Access: API endpoint + UI
  - Right to Rectification: User profile editing
  - Right to Erasure: Account deletion with cascade
  - Right to Portability: JSON/CSV export
  - Right to Object: Opt-out mechanisms

Technical Measures:
  - Privacy by Design
  - Data minimization
  - Purpose limitation
  - Consent management
  - Data retention policies
```

### SOC 2 Type II Controls
| Control Family | Implementation |
|----------------|----------------|
| **CC1: Control Environment** | Policies, training, governance |
| **CC2: Communication** | Security awareness, reporting |
| **CC3: Risk Assessment** | Annual assessment, threat modeling |
| **CC4: Monitoring** | Continuous monitoring, audits |
| **CC5: Control Activities** | Technical controls, procedures |
| **CC6: Logical Access** | Access control, authentication |
| **CC7: System Operations** | Change management, monitoring |
| **CC8: Change Management** | Version control, testing |
| **CC9: Risk Mitigation** | Vendor management, BCP |

### PCI-DSS Requirements (if applicable)
```yaml
Requirement 1: Firewall configuration
Requirement 2: Default password changes
Requirement 3: Cardholder data protection
Requirement 4: Encrypted transmission
Requirement 5: Antivirus software
Requirement 6: Secure development
Requirement 7: Access restrictions
Requirement 8: User authentication
Requirement 9: Physical access controls
Requirement 10: Activity logging
Requirement 11: Security testing
Requirement 12: Security policy
```

## Security Testing

### Vulnerability Assessment
```yaml
Frequency:
  - Automated scans: Weekly
  - Manual assessment: Quarterly
  - Third-party pentest: Annually

Tools:
  - SAST: SonarQube, Checkmarx
  - DAST: OWASP ZAP, Burp Suite
  - Dependencies: Snyk, Dependabot
  - Infrastructure: Nessus, Qualys
```

### Penetration Testing
```yaml
Scope:
  - External network penetration
  - Web application testing
  - API security testing
  - Social engineering (with approval)
  - Physical security (if applicable)

Methodology:
  - OWASP Testing Guide
  - PTES (Penetration Testing Execution Standard)
  - Custom scenarios based on threat model
```

### Security Metrics
| Metric | Target | Measurement |
|--------|--------|-------------|
| Patch Time | <30 days | Time to apply critical patches |
| Vulnerability Resolution | <7 days (critical) | Time to fix after discovery |
| Security Training | 100% annually | Employee completion rate |
| Incident Response | <1 hour | Time to initial response |
| False Positive Rate | <10% | Security alert accuracy |

## Secure Development

### SDLC Security
```yaml
Planning:
  - Threat modeling
  - Security requirements
  - Risk assessment

Development:
  - Secure coding training
  - Code review checklist
  - SAST integration

Testing:
  - Security test cases
  - Penetration testing
  - Vulnerability scanning

Deployment:
  - Security configuration
  - Access control setup
  - Monitoring activation

Maintenance:
  - Patch management
  - Security updates
  - Continuous monitoring
```

### Code Security Standards
```javascript
// Example secure coding practices

// Input validation
function validateInput(input) {
  const schema = Joi.object({
    email: Joi.string().email().required(),
    age: Joi.number().integer().min(0).max(150)
  });
  
  const { error, value } = schema.validate(input);
  if (error) throw new ValidationError(error.details);
  return value;
}

// SQL injection prevention
async function getUser(userId) {
  return await db.query(
    'SELECT * FROM users WHERE id = $1',
    [userId]  // Parameterized query
  );
}

// XSS prevention
function renderUserContent(content) {
  return DOMPurify.sanitize(content, {
    ALLOWED_TAGS: ['b', 'i', 'em', 'strong', 'a'],
    ALLOWED_ATTR: ['href']
  });
}
```

## Third-Party Security

### Vendor Assessment
```yaml
Requirements:
  - SOC 2 Type II report
  - Security questionnaire
  - Data processing agreement
  - Cyber insurance proof
  - Incident notification SLA

Ongoing Monitoring:
  - Annual reassessment
  - Vulnerability notifications
  - Compliance updates
  - Performance reviews
```

### Supply Chain Security
```yaml
Dependency Management:
  - Automated scanning
  - License compliance
  - Version pinning
  - Private registry

Container Images:
  - Signed images only
  - Vulnerability scanning
  - Minimal base images
  - Regular rebuilds
```

## Security Awareness & Training

### Training Program
| Audience | Topics | Frequency |
|----------|--------|-----------|
| All Employees | Security basics, phishing | Onboarding + Annual |
| Developers | Secure coding, OWASP | Quarterly |
| Admins | Incident response, tools | Monthly |
| Management | Risk, compliance | Semi-annual |

### Security Champions
```yaml
Program Structure:
  - One champion per team
  - Monthly meetings
  - Security project involvement
  - Training and certification support
  - Recognition program
```

## Business Continuity

### Disaster Recovery Plan
```yaml
RTO (Recovery Time Objective): 4 hours
RPO (Recovery Point Objective): 1 hour

Backup Strategy:
  - Frequency: Hourly incremental, daily full
  - Retention: 30 days standard, 1 year archive
  - Testing: Monthly restore tests
  - Offsite: Different geographic region

Failover Process:
  - Automated health checks
  - DNS failover (5 minute TTL)
  - Database replication lag < 1 minute
  - Communication plan activated
```

### Data Retention & Disposal
| Data Type | Retention Period | Disposal Method |
|-----------|-----------------|-----------------|
| User Data | Active + 30 days | Secure deletion |
| Logs | 1 year | Automated purge |
| Backups | 30 days operational | Encrypted shred |
| Audit Trails | 7 years | Archive + purge |

## Appendices

### A. Security Checklist
- [ ] All passwords meet complexity requirements
- [ ] MFA enabled for admin accounts
- [ ] SSL/TLS properly configured
- [ ] Security headers implemented
- [ ] Input validation on all forms
- [ ] API rate limiting active
- [ ] Logging and monitoring configured
- [ ] Incident response plan tested
- [ ] Security training completed
- [ ] Compliance requirements met

### B. Security Contacts
- CERT/CSIRT: cert@example.com
- Bug Bounty: security@example.com
- Compliance: compliance@example.com
- Privacy: privacy@example.com

### C. References
- OWASP Top 10
- CIS Controls
- NIST Cybersecurity Framework
- ISO 27001/27002
- Industry-specific regulations

## Clarification Requests or Feedback
[Any questions, clarifications or architectural considerations]
</security_template>

## Guidance Notes

When generating security documentation, ensure:

1. **Comprehensive Coverage** of all security domains
2. **Practical Implementation** with specific configurations
3. **Compliance Alignment** with required standards
4. **Risk-Based Approach** prioritizing critical assets
5. **Defense in Depth** with multiple security layers
6. **Incident Readiness** with clear procedures
7. **Continuous Improvement** through metrics and testing
8. **Clear Responsibilities** for all stakeholders
9. **Technical Accuracy** in security controls
10. **Regular Updates** as threats evolve

Focus on creating security documentation that:
- Development teams can implement correctly
- Security teams can audit and monitor
- Compliance auditors can verify
- Incident responders can execute
- Management can understand and support