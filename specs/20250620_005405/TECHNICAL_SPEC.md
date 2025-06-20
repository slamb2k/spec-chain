# Technical Specification: BIG Live Portal

## System Architecture Overview

The BIG Live Portal employs a modern, cloud-native architecture designed for scalability, performance, and maintainability. The system follows a microservices-oriented approach with clear separation between frontend, backend, and data layers. This architecture supports the platform's core requirements of mobile-first access, SharePoint integration, and reliable performance for distributed performing arts organizations.

```mermaid
graph TB
    subgraph "Frontend"
        UI[React PWA<br/>Mobile-First Web App]
        ServiceWorker[Service Worker<br/>Offline Support]
    end
    
    subgraph "API Gateway"
        Gateway[Express API Gateway<br/>JWT Auth & Rate Limiting]
        WebSocket[WebSocket Server<br/>Real-time Updates]
    end
    
    subgraph "Backend Services"
        AuthService[Auth Service<br/>Azure AD & JWT]
        CoreAPI[Core API Service<br/>Business Logic]
        NotificationService[Notification Service<br/>Email/SMS]
        IntegrationService[Integration Service<br/>External APIs]
    end
    
    subgraph "Data Layer"
        PostgresDB[(PostgreSQL<br/>Primary Database)]
        Redis[(Redis<br/>Cache & Sessions)]
        S3[(S3-Compatible<br/>Temp Storage)]
    end
    
    subgraph "External Services"
        SharePoint[SharePoint API<br/>Document Storage]
        XeroAPI[Xero API<br/>Accounting]
        DocuSign[DocuSign API<br/>E-Signatures]
        SendGrid[SendGrid<br/>Email Delivery]
        Twilio[Twilio<br/>SMS Service]
        Hubdoc[Hubdoc<br/>OCR Service]
    end
    
    UI --> ServiceWorker
    UI --> Gateway
    ServiceWorker --> Gateway
    Gateway --> WebSocket
    Gateway --> AuthService
    Gateway --> CoreAPI
    CoreAPI --> PostgresDB
    CoreAPI --> Redis
    CoreAPI --> NotificationService
    CoreAPI --> IntegrationService
    IntegrationService --> SharePoint
    IntegrationService --> XeroAPI
    IntegrationService --> DocuSign
    IntegrationService --> S3
    NotificationService --> SendGrid
    NotificationService --> Twilio
    IntegrationService --> Hubdoc
```

## Technology Stack

### Frontend
- **Framework**: React 18.2+ with TypeScript 5.0+
- **State Management**: Redux Toolkit 2.0+ with RTK Query
- **UI Library**: Material-UI 5.14+ (customized for performing arts aesthetic)
- **Build Tool**: Vite 5.0+ for fast development and optimized production builds
- **Testing**: Jest 29+ with React Testing Library, Cypress 13+ for E2E

### Backend
- **Runtime**: Node.js 20 LTS
- **Framework**: Express.js 4.18+ with TypeScript
- **ORM**: Prisma 5.0+ for type-safe database access
- **Authentication**: Passport.js with JWT and Azure AD strategies
- **Validation**: Joi 17+ for request validation
- **Testing**: Jest with Supertest for API testing

### Infrastructure
- **Database**: PostgreSQL 15+ with read replicas
- **Cache**: Redis 7+ for sessions and performance caching
- **Email Service**: SendGrid for transactional emails
- **Hosting**: AWS/Azure with auto-scaling EC2/App Service
- **Monitoring**: DataDog APM with custom dashboards

## Database Schema

```sql
-- Users table - core user accounts
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255),
    role VARCHAR(50) NOT NULL CHECK (role IN ('artist', 'admin', 'accountant', 'production_manager')),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    tax_id_encrypted TEXT,
    emergency_contact JSONB,
    azure_ad_id VARCHAR(255),
    is_active BOOLEAN DEFAULT true,
    last_login TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Companies table - organizations using the platform
CREATE TABLE companies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    subdomain VARCHAR(100) UNIQUE,
    sharepoint_site_url TEXT,
    azure_tenant_id VARCHAR(255),
    settings JSONB DEFAULT '{}',
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Productions table
CREATE TABLE productions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    company_id UUID NOT NULL REFERENCES companies(id),
    name VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Contracts table
CREATE TABLE contracts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    artist_id UUID NOT NULL REFERENCES users(id),
    production_id UUID NOT NULL REFERENCES productions(id),
    document_url TEXT NOT NULL,
    sharepoint_id VARCHAR(255),
    status VARCHAR(50) NOT NULL CHECK (status IN ('draft', 'pending_signature', 'active', 'completed', 'archived')),
    amount DECIMAL(10,2),
    currency VARCHAR(3) DEFAULT 'USD',
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    signed_at TIMESTAMP,
    signature_id VARCHAR(255),
    version INTEGER DEFAULT 1,
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Expenses table
CREATE TABLE expenses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    artist_id UUID NOT NULL REFERENCES users(id),
    production_id UUID REFERENCES productions(id),
    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',
    category VARCHAR(100) NOT NULL,
    description TEXT,
    expense_date DATE NOT NULL,
    receipt_urls TEXT[],
    status VARCHAR(50) NOT NULL CHECK (status IN ('draft', 'submitted', 'approved', 'rejected', 'paid')),
    submitted_at TIMESTAMP,
    approved_by UUID REFERENCES users(id),
    approved_at TIMESTAMP,
    rejection_reason TEXT,
    xero_id VARCHAR(255),
    hubdoc_id VARCHAR(255),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Schedules table
CREATE TABLE schedules (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    production_id UUID NOT NULL REFERENCES productions(id),
    title VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL CHECK (type IN ('rehearsal', 'performance', 'meeting', 'other')),
    start_time TIMESTAMPTZ NOT NULL,
    end_time TIMESTAMPTZ NOT NULL,
    location VARCHAR(255),
    location_url TEXT,
    notes TEXT,
    created_by UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Schedule assignments junction table
CREATE TABLE schedule_assignments (
    schedule_id UUID NOT NULL REFERENCES schedules(id) ON DELETE CASCADE,
    artist_id UUID NOT NULL REFERENCES users(id),
    PRIMARY KEY (schedule_id, artist_id)
);

-- Announcements table
CREATE TABLE announcements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    production_id UUID REFERENCES productions(id),
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    priority VARCHAR(20) DEFAULT 'normal' CHECK (priority IN ('low', 'normal', 'high', 'urgent')),
    created_by UUID NOT NULL REFERENCES users(id),
    expires_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Audit log table
CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id),
    action VARCHAR(100) NOT NULL,
    entity_type VARCHAR(50) NOT NULL,
    entity_id UUID NOT NULL,
    changes JSONB,
    ip_address INET,
    user_agent TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_company ON users USING btree (id) WHERE is_active = true;
CREATE INDEX idx_contracts_artist ON contracts(artist_id, status);
CREATE INDEX idx_contracts_production ON contracts(production_id);
CREATE INDEX idx_expenses_artist ON expenses(artist_id, status);
CREATE INDEX idx_expenses_approval ON expenses(status) WHERE status = 'submitted';
CREATE INDEX idx_schedules_production ON schedules(production_id, start_time);
CREATE INDEX idx_schedule_assignments_artist ON schedule_assignments(artist_id);
CREATE INDEX idx_audit_logs_user ON audit_logs(user_id, created_at);

-- Triggers for updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER update_companies_updated_at BEFORE UPDATE ON companies
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER update_productions_updated_at BEFORE UPDATE ON productions
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER update_contracts_updated_at BEFORE UPDATE ON contracts
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER update_expenses_updated_at BEFORE UPDATE ON expenses
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER update_schedules_updated_at BEFORE UPDATE ON schedules
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();
```

## Security Requirements

### Authentication & Authorization
- **JWT Tokens**: 24-hour access token expiry with secure httpOnly refresh tokens (30-day expiry)
- **Session Management**: Redis-backed sessions with automatic cleanup and device tracking
- **Role-Based Access Control (RBAC)**: 
  - Artist: Own data only (contracts, expenses, assigned schedules)
  - Admin: Full system access with audit logging
  - Accountant: Expense approval and financial reports
  - Production Manager: Schedule and announcement management

### Data Protection
- **Password Hashing**: Argon2id with salt rounds optimized for 250ms computation time
- **Encryption Standards**: 
  - TLS 1.3 for all external communications
  - AES-256-GCM for sensitive data at rest (tax IDs, bank details)
  - Field-level encryption for PII in database
- **Data Privacy Measures**:
  - GDPR-compliant data export and deletion
  - Automatic PII redaction in logs
  - Consent tracking for data processing

### Security Headers
```javascript
// Required security headers
{
  "Strict-Transport-Security": "max-age=31536000; includeSubDomains",
  "X-Content-Type-Options": "nosniff",
  "X-Frame-Options": "DENY",
  "X-XSS-Protection": "1; mode=block",
  "Content-Security-Policy": "default-src 'self'; script-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; connect-src 'self' wss://portal.biglive.com https://api.sharepoint.com",
  "Referrer-Policy": "strict-origin-when-cross-origin",
  "Permissions-Policy": "geolocation=(), microphone=(), camera=(self)"
}
```

### Input Validation
- **Server-side validation**: All inputs validated with Joi schemas
- **SQL Injection Prevention**: Parameterized queries via Prisma ORM
- **XSS Protection**: React's automatic escaping + DOMPurify for user content
- **CSRF Protection**: Double-submit cookie pattern with SameSite cookies
- **File Upload Security**: 
  - Magic number validation for file types
  - Virus scanning via ClamAV
  - Maximum file size enforcement (50MB)

## Performance Requirements

### Response Times
- API endpoints: <500ms p95, <200ms p50
- Page load: <2 seconds on 4G connection
- Database queries: <100ms for single entity, <500ms for lists
- Search operations: <1 second for full-text search

### Scalability
- Support 100+ concurrent users initially
- Handle 1,000 concurrent users within 2 years
- Database connections: 100 pool size with PgBouncer
- Scaling strategy: Horizontal scaling with load balancer

### Caching Strategy
- **Redis Cache Layers**:
  - Session cache: User sessions and auth tokens (24-hour TTL)
  - API cache: Frequently accessed data (5-minute TTL)
  - Document cache: Contract/schedule data (1-hour TTL)
- **CDN Caching**: Static assets and PWA resources
- **Browser Caching**: Service Worker with intelligent cache-first/network-first strategies
- **Cache Invalidation**: Event-driven invalidation for data changes

## Infrastructure Requirements

### Compute
- Application servers: 
  - Initial: 2x t3.large (2 vCPU, 8GB RAM)
  - Auto-scaling: 2-10 instances based on CPU/memory
- Load balancing: Application Load Balancer with health checks
- Auto-scaling triggers:
  - Scale up: >70% CPU for 5 minutes
  - Scale down: <30% CPU for 15 minutes

### Storage
- Database: 
  - Primary: 100GB SSD with automated backups
  - Read replicas: 2x replicas in different AZs
- Backup storage: 
  - Daily snapshots retained for 30 days
  - Point-in-time recovery for 7 days
- Log retention: 90 days in CloudWatch/Azure Monitor
- Document storage: SharePoint (10GB per artist allocation)

### Network
- **Architecture**: VPC with public/private subnets
- **Security Groups**:
  - Web tier: 443 from anywhere, 80 redirects to 443
  - App tier: 3000 from web tier only
  - Data tier: 5432 from app tier only
- **CDN Configuration**: CloudFront/Azure CDN for static assets

### Monitoring & Logging
- **APM Solution**: DataDog with custom dashboards
- **Error Tracking**: Sentry with source map support
- **Log Aggregation**: CloudWatch/Azure Monitor with alerts
- **Uptime Monitoring**: 99.5% SLA with StatusPage integration

## Development Environment

### Local Development
```yaml
# docker-compose.yml
version: '3.8'
services:
  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: biglive_dev
      POSTGRES_USER: biglive
      POSTGRES_PASSWORD: localdev123
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
  
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
  
  api:
    build: 
      context: ./backend
      dockerfile: Dockerfile.dev
    environment:
      NODE_ENV: development
      DATABASE_URL: postgresql://biglive:localdev123@postgres:5432/biglive_dev
      REDIS_URL: redis://redis:6379
      JWT_SECRET: local-dev-secret-change-in-production
    ports:
      - "3000:3000"
    volumes:
      - ./backend:/app
      - /app/node_modules
    depends_on:
      - postgres
      - redis
  
  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile.dev
    environment:
      VITE_API_URL: http://localhost:3000
    ports:
      - "5173:5173"
    volumes:
      - ./frontend:/app
      - /app/node_modules

volumes:
  postgres_data:
```

### Environment Variables
```env
# Application
NODE_ENV=production
PORT=3000
API_URL=https://api.biglive.com

# Database
DATABASE_URL=postgresql://user:pass@host:5432/biglive
DATABASE_POOL_MIN=2
DATABASE_POOL_MAX=10

# Redis
REDIS_URL=redis://host:6379
REDIS_PASSWORD=secure-password

# Authentication
JWT_SECRET=32-char-secure-random-string
JWT_EXPIRES_IN=24h
REFRESH_TOKEN_EXPIRES_IN=30d

# Azure AD (optional)
AZURE_AD_TENANT_ID=tenant-id
AZURE_AD_CLIENT_ID=client-id
AZURE_AD_CLIENT_SECRET=client-secret

# SharePoint
SHAREPOINT_SITE_URL=https://company.sharepoint.com/sites/biglive
SHAREPOINT_CLIENT_ID=sp-client-id
SHAREPOINT_CLIENT_SECRET=sp-client-secret

# External Services
SENDGRID_API_KEY=sg-api-key
TWILIO_ACCOUNT_SID=twilio-sid
TWILIO_AUTH_TOKEN=twilio-token
TWILIO_FROM_NUMBER=+1234567890
DOCUSIGN_INTEGRATION_KEY=ds-key
DOCUSIGN_SECRET_KEY=ds-secret
XERO_CLIENT_ID=xero-id
XERO_CLIENT_SECRET=xero-secret
HUBDOC_API_KEY=hubdoc-key

# Monitoring
SENTRY_DSN=https://sentry.io/project
DATADOG_API_KEY=dd-api-key
```

## Testing Strategy

### Unit Tests
- Coverage target: 80% for business logic, 90% for critical paths
- Key areas: Authentication, authorization, data validation, business rules
- Mocking strategy: Repository pattern for database, stubs for external services

### Integration Tests
- API endpoint testing with real database
- SharePoint integration with test tenant
- E-signature flow with sandbox environment
- Xero integration with demo company

### End-to-End Tests
- Critical journey: Artist onboarding and first contract
- Critical journey: Expense submission to payment
- Critical journey: Schedule update notifications
- Browser matrix: Chrome, Firefox, Safari (desktop + mobile)

### Load Testing
- Target: 200 concurrent users
- Scenarios: 
  - Login surge (50 users/minute)
  - Contract viewing (100 concurrent PDF loads)
  - Expense submission (50 concurrent uploads)
- Success criteria: 
  - <500ms API response at p95
  - <2% error rate
  - No memory leaks over 1-hour test

## Deployment Pipeline

### CI/CD Pipeline
1. **Code Commit** → GitHub/GitLab trigger
2. **Build Stage**:
   - Install dependencies
   - Run linting (ESLint, Prettier)
   - Compile TypeScript
3. **Test Stage**:
   - Unit tests with coverage
   - Integration tests
   - Security scanning (OWASP Dependency Check)
4. **Build Artifacts**:
   - Docker images with multi-stage builds
   - Optimize frontend bundle
5. **Deploy to Staging**:
   - Automated database migrations
   - Smoke tests
6. **Manual Approval** for production
7. **Deploy to Production**:
   - Blue-green deployment
   - Health checks before traffic switch
8. **Post-Deployment**:
   - Automated E2E tests
   - Performance monitoring alerts

### Rollback Strategy
- **Rollback Triggers**: 
  - Error rate >5%
  - Response time >2x baseline
  - Health check failures
- **Rollback Procedure**:
  1. Switch load balancer to previous version
  2. Verify system stability
  3. Investigate root cause
  4. Fix forward or full rollback
- **Data Migration Handling**: 
  - Forward-only migrations
  - Backward-compatible changes
  - Feature flags for gradual rollout
- **Version Retention**: Keep 5 previous versions for quick rollback

## API Design

### REST Endpoints

```
POST /api/v1/auth/login
├── Request:
│   ├── Headers: Content-Type: application/json
│   ├── Body: { email: string, password: string }
│   └── Query params: none
├── Response:
│   ├── 200: { accessToken: string, refreshToken: string, user: UserDto }
│   ├── 401: { error: "Invalid credentials" }
│   └── 429: { error: "Too many attempts" }
└── Authorization: None (public endpoint)

GET /api/v1/contracts
├── Request:
│   ├── Headers: Authorization: Bearer {token}
│   ├── Body: none
│   └── Query params: ?status=pending&production=uuid&page=1&limit=20
├── Response:
│   ├── 200: { data: Contract[], pagination: PaginationMeta }
│   ├── 401: { error: "Unauthorized" }
│   └── 403: { error: "Forbidden" }
└── Authorization: Authenticated user (filtered by role)

POST /api/v1/expenses
├── Request:
│   ├── Headers: Authorization: Bearer {token}, Content-Type: multipart/form-data
│   ├── Body: FormData { amount, currency, category, description, date, receipts[] }
│   └── Query params: none
├── Response:
│   ├── 201: { data: Expense, message: "Expense created" }
│   ├── 400: { error: "Validation error", details: ValidationError[] }
│   └── 413: { error: "File too large" }
└── Authorization: Artist or Admin role

PUT /api/v1/expenses/{id}/approve
├── Request:
│   ├── Headers: Authorization: Bearer {token}
│   ├── Body: { notes?: string }
│   └── Query params: none
├── Response:
│   ├── 200: { data: Expense, message: "Expense approved" }
│   ├── 404: { error: "Expense not found" }
│   └── 409: { error: "Invalid status transition" }
└── Authorization: Accountant or Admin role

GET /api/v1/schedules
├── Request:
│   ├── Headers: Authorization: Bearer {token}
│   ├── Body: none
│   └── Query params: ?start=date&end=date&type=rehearsal&production=uuid
├── Response:
│   ├── 200: { data: Schedule[], included: { productions: Production[] } }
│   └── 401: { error: "Unauthorized" }
└── Authorization: Authenticated user (filtered by assignments)
```

### Rate Limiting
- **Global limit**: 1000 requests per hour per IP
- **Authenticated limit**: 100 requests per minute per user
- **Upload endpoints**: 10 requests per minute
- **Rate limit headers**:
  - `X-RateLimit-Limit`: Maximum requests
  - `X-RateLimit-Remaining`: Requests remaining
  - `X-RateLimit-Reset`: Reset timestamp

## Technical Risks & Mitigation

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| SharePoint API rate limits | High | Medium | Implement caching layer, batch operations, fallback to direct storage |
| E-signature service outage | High | Low | Support multiple providers (DocuSign + Adobe Sign), queue for retry |
| Database performance at scale | High | Medium | Read replicas, query optimization, connection pooling, caching |
| Mobile browser compatibility issues | Medium | Medium | Progressive enhancement, extensive device testing, fallback UI |
| Peak season load spikes | High | High | Auto-scaling, CDN, performance testing, capacity planning |
| Integration API changes | Medium | Medium | Version pinning, integration tests, adapter pattern |
| Security breach | High | Low | Regular audits, penetration testing, security monitoring |
| Data migration errors | High | Low | Thorough testing, rollback procedures, data validation |

## Future Considerations

- **GraphQL API**: Consider GraphQL for mobile optimization and reduced API calls
- **Microservices Migration**: Split monolith into services as team grows
- **Multi-Region Deployment**: Geographic distribution for global organizations
- **AI/ML Integration**: Expense categorization, anomaly detection, schedule optimization
- **Real-time Collaboration**: WebRTC for video calls, collaborative document editing
- **Blockchain Integration**: Immutable contract storage and audit trails
- **Advanced Analytics**: Data warehouse for complex reporting and BI tools

## Clarification Requests or Feedback

1. **SharePoint Permission Model**: Detailed understanding of the existing SharePoint folder structure and permission inheritance would optimize the integration design and ensure seamless document access control.

2. **Xero Integration Depth**: Clarification on whether the integration should create draft bills, approved bills, or trigger actual payments would help define the exact API endpoints and approval workflows needed.

3. **E-signature Provider Preference**: While both DocuSign and Adobe Sign are mentioned, a primary preference would help optimize the integration and potentially reduce costs through committed volume pricing.

4. **Disaster Recovery Requirements**: Specific RPO (Recovery Point Objective) and RTO (Recovery Time Objective) requirements would inform the backup strategy and infrastructure redundancy design.

5. **Compliance Certifications**: Timeline for SOC 2 Type II and other compliance certifications would help prioritize security controls and audit logging implementation.

6. **API Rate Limits**: Expected peak usage patterns and third-party API rate limits (especially SharePoint and Xero) would help design appropriate caching and queuing strategies.

7. **Custom Branding Requirements**: The extent of white-labeling needed (domains, emails, UI) would impact the multi-tenancy architecture and deployment strategy.