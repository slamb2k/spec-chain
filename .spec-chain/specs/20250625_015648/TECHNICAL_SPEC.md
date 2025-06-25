# Comprehensive Technical Specification: BIG Live Portal

## Executive Summary
BIG Live Portal is a cloud-based, mobile-first Progressive Web Application designed to revolutionize performing arts management by digitizing artist contracts, expense workflows, and schedule coordination. The technical approach leverages a modern microservices architecture built on Node.js and React, with seamless integrations to SharePoint for document management and Xero/Hubdoc for financial processing. The system is architected to support 1,000+ concurrent users across distributed locations while maintaining sub-500ms API response times and 99.9% uptime. By implementing a feature-based project structure, comprehensive security measures including JWT authentication and role-based access control, and a mobile-responsive design system, the platform enables performing arts organizations to reduce administrative overhead by 40-60% while providing artists with intuitive self-service capabilities accessible from any device without requiring corporate email accounts.

## System Architecture

### High-Level Architecture
The BIG Live Portal architecture implements a scalable microservices pattern with clear separation of concerns, enabling independent service scaling and deployment while maintaining system cohesion through an API gateway and event-driven communication.

```mermaid
graph TB
    subgraph "Client Layer"
        Web[Progressive Web App<br/>React + TypeScript + MUI]
        Mobile[Mobile Web Browser<br/>iOS Safari/Chrome Android]
        Desktop[Desktop Browser<br/>Chrome/Firefox/Edge/Safari]
    end

    subgraph "API Gateway Layer"
        Gateway[API Gateway<br/>Node.js + Express]
        Auth[Authentication Service<br/>JWT + OAuth 2.0]
        RateLimit[Rate Limiting<br/>Redis + Express-Rate-Limit]
    end

    subgraph "Application Services"
        UserService[User Service<br/>Profile & Role Management]
        ContractService[Contract Service<br/>Document & Signature Management]
        ExpenseService[Expense Service<br/>Submission & Approval Workflows]
        ScheduleService[Schedule Service<br/>Event & Calendar Management]
        NotificationService[Notification Service<br/>Email/SMS/Push Delivery]
        IntegrationService[Integration Service<br/>External API Orchestration]
    end

    subgraph "Data Layer"
        PrimaryDB[(PostgreSQL<br/>Primary Database)]
        Cache[(Redis Cache<br/>Sessions & Real-time Data)]
        SearchDB[(Elasticsearch<br/>Audit Logs & Search)]
        FileStorage[(Azure Blob/S3<br/>Document & Receipt Storage)]
    end

    subgraph "External Services"
        SharePoint[SharePoint Online<br/>Document Repository]
        Xero[Xero API<br/>Financial Integration]
        Hubdoc[Hubdoc API<br/>Receipt Processing]
        DocuSign[DocuSign/Adobe Sign<br/>E-Signature Service]
        SendGrid[SendGrid<br/>Transactional Email]
        Twilio[Twilio<br/>SMS Notifications]
    end

    subgraph "Infrastructure Services"
        CDN[Azure CDN/CloudFront<br/>Static Asset Delivery]
        Queue[Bull Queue<br/>Async Job Processing]
        WebSocket[Socket.io<br/>Real-time Updates]
        Monitoring[Application Insights<br/>Performance Monitoring]
    end

    Web --> CDN
    Mobile --> CDN
    Desktop --> CDN
    
    CDN --> Gateway
    Gateway --> Auth
    Gateway --> RateLimit
    
    Auth --> Cache
    Auth --> UserService
    
    Gateway --> ContractService
    Gateway --> ExpenseService
    Gateway --> ScheduleService
    Gateway --> NotificationService
    
    ContractService --> PrimaryDB
    ContractService --> FileStorage
    ContractService --> IntegrationService
    ContractService --> Queue
    
    ExpenseService --> PrimaryDB
    ExpenseService --> FileStorage
    ExpenseService --> IntegrationService
    ExpenseService --> Queue
    
    ScheduleService --> PrimaryDB
    ScheduleService --> Cache
    ScheduleService --> WebSocket
    ScheduleService --> NotificationService
    
    UserService --> PrimaryDB
    UserService --> Cache
    UserService --> SearchDB
    
    NotificationService --> Queue
    NotificationService --> SendGrid
    NotificationService --> Twilio
    
    IntegrationService --> SharePoint
    IntegrationService --> Xero
    IntegrationService --> Hubdoc
    IntegrationService --> DocuSign
    
    Queue --> IntegrationService
    WebSocket --> Cache
    
    All Services --> Monitoring
```

### Component Breakdown
Each component in the architecture serves a specific purpose with well-defined interfaces and responsibilities, ensuring maintainability and scalability.

#### Frontend Components
- **Web Application**: React 18+ Progressive Web App with TypeScript, implementing Material-UI v5 for consistent component design. Features offline-first architecture with service workers, code splitting for optimal bundle sizes, and Redux Toolkit for complex state management. Implements responsive design breakpoints at 320px (mobile), 768px (tablet), and 1024px (desktop).

- **Mobile Application**: Same PWA optimized for mobile browsers with touch-first interactions, camera API integration for receipt capture, and progressive enhancement for device capabilities. Implements one-handed operation patterns and 44px minimum touch targets for accessibility.

- **Desktop Application**: Enhanced PWA experience for desktop users with keyboard shortcuts, multi-tab support, advanced data tables, and bulk operation interfaces. Leverages larger screen real estate for split-view layouts and comprehensive dashboards.

#### Backend Services
- **API Gateway**: Central entry point implementing request routing, authentication verification, rate limiting (1000 requests/hour per user), request/response transformation, and API versioning. Built with Express.js and custom middleware for cross-cutting concerns.

- **Authentication Service**: Handles user authentication with JWT tokens (24-hour access, 30-day refresh), personal email support without corporate accounts, optional SharePoint SSO for administrators, password reset flows with secure token generation, and session management with Redis storage.

- **Contract Service**: Manages document lifecycle including upload/storage orchestration with SharePoint, e-signature integration via webhooks, status tracking and notifications, version control with audit trails, and bulk assignment workflows for multiple artists.

- **Expense Service**: Processes expense submissions with receipt image optimization, category mapping with Xero chart of accounts, multi-level approval workflows, offline queue support for poor connectivity, and automated financial system synchronization.

- **Schedule Service**: Coordinates event management with timezone-aware scheduling, real-time updates via WebSocket, calendar export functionality, change notifications and acknowledgments, and integration with external calendar systems.

- **Notification Service**: Delivers multi-channel communications through email templates via SendGrid, SMS alerts via Twilio, push notifications for PWA users, in-app notifications with read tracking, and batched delivery for efficiency.

#### Data Layer
- **Primary Database**: PostgreSQL 14+ with JSONB support for flexible schemas, comprehensive indexing strategy for sub-100ms queries, connection pooling with pgBouncer, read replicas for scale, and automated backup every 6 hours.

- **Caching Layer**: Redis 6+ for session storage with sliding expiration, API response caching with intelligent invalidation, real-time data pub/sub for WebSocket, job queue backend with Bull, and distributed locks for concurrency control.

- **Search Engine**: Elasticsearch for audit log indexing and searching, full-text search across documents, advanced filtering and aggregations, and 30-day retention with archival.

- **File Storage**: Azure Blob Storage or AWS S3 for document persistence with CDN integration, receipt image storage with compression, temporary file handling for processing, lifecycle policies for cost optimization, and encryption at rest.

## Core Functionality

### Feature Implementation Details
Each feature is implemented with careful consideration of user workflows, performance requirements, and system integration needs.

#### Secure Artist Authentication
**Description**: Personal email authentication system eliminating the need for corporate accounts while maintaining enterprise security standards.

**User Stories**: Artists can log in using personal email addresses, administrators can use SharePoint SSO optionally, and all users benefit from secure session management.

**Technical Implementation**:
- **Frontend Components**: 
  - `LoginPage` component with email/password fields and validation
  - `AuthProvider` context for global authentication state
  - `ProtectedRoute` wrapper for role-based access control
  - `SessionTimeout` component with warning modal at 25 minutes
  - `PasswordReset` flow with email verification

- **Backend Services**:
  - `POST /api/v1/auth/login` - Validates credentials and returns JWT tokens
  - `POST /api/v1/auth/refresh` - Exchanges refresh token for new access token
  - `POST /api/v1/auth/logout` - Invalidates session and clears tokens
  - `POST /api/v1/auth/forgot-password` - Initiates password reset flow
  - `POST /api/v1/auth/reset-password` - Completes password reset with token

- **Database Schema**:
  ```sql
  CREATE TABLE users (
      id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
      email VARCHAR(255) UNIQUE NOT NULL,
      password_hash VARCHAR(255) NOT NULL,
      role VARCHAR(50) NOT NULL CHECK (role IN ('artist', 'admin', 'accountant')),
      organization_id UUID NOT NULL REFERENCES organizations(id),
      email_verified BOOLEAN DEFAULT FALSE,
      last_login TIMESTAMP,
      failed_login_attempts INTEGER DEFAULT 0,
      locked_until TIMESTAMP,
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  );

  CREATE TABLE user_sessions (
      id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
      user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
      refresh_token_hash VARCHAR(255) NOT NULL,
      expires_at TIMESTAMP NOT NULL,
      ip_address INET,
      user_agent TEXT,
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  );

  CREATE TABLE password_reset_tokens (
      id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
      user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
      token_hash VARCHAR(255) NOT NULL,
      expires_at TIMESTAMP NOT NULL,
      used_at TIMESTAMP,
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  );
  ```

- **External Integrations**: 
  - SharePoint Graph API for optional admin SSO with OAuth 2.0 flow
  - SendGrid for password reset and verification emails
  - Redis for distributed session storage and rate limiting

- **Security Considerations**:
  - bcrypt with 12 rounds for password hashing
  - Rate limiting: 5 login attempts per minute per IP
  - Account lockout after 10 failed attempts for 30 minutes
  - JWT tokens signed with RS256 algorithm
  - Secure HTTP-only cookies for refresh tokens

- **Performance Requirements**:
  - Login response time < 500ms
  - Token refresh < 200ms
  - Session validation < 50ms from cache

#### Digital Contract Management
**Description**: Comprehensive contract lifecycle management from upload through signature to archival with SharePoint integration.

**User Stories**: Administrators upload and distribute contracts efficiently, artists receive and sign contracts on any device, and signed documents automatically sync to SharePoint.

**Technical Implementation**:
- **Frontend Components**:
  - `ContractDashboard` with data table and bulk operations
  - `ContractUpload` with drag-drop and progress tracking
  - `ContractAssignment` panel with artist selection
  - `ContractViewer` with pinch-to-zoom and annotations
  - `SignatureFlow` embedding DocuSign/Adobe Sign

- **Backend Services**:
  - `POST /api/v1/contracts` - Handles file upload and metadata
  - `POST /api/v1/contracts/:id/assign` - Assigns contracts to artists
  - `GET /api/v1/contracts/:id/status` - Real-time signature status
  - `POST /api/v1/contracts/:id/sign` - Initiates signature flow
  - `GET /api/v1/contracts/:id/download` - Secure document retrieval

- **Database Schema**:
  ```sql
  CREATE TABLE contracts (
      id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
      organization_id UUID NOT NULL REFERENCES organizations(id),
      title VARCHAR(255) NOT NULL,
      document_url VARCHAR(500) NOT NULL,
      sharepoint_id VARCHAR(255),
      file_size_bytes BIGINT,
      mime_type VARCHAR(100),
      status VARCHAR(50) NOT NULL DEFAULT 'draft',
      version INTEGER NOT NULL DEFAULT 1,
      created_by UUID NOT NULL REFERENCES users(id),
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      CHECK (status IN ('draft', 'pending', 'viewed', 'signed', 'filed', 'archived'))
  );

  CREATE TABLE contract_assignments (
      id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
      contract_id UUID NOT NULL REFERENCES contracts(id) ON DELETE CASCADE,
      artist_id UUID NOT NULL REFERENCES artists(id),
      status VARCHAR(50) NOT NULL DEFAULT 'pending',
      viewed_at TIMESTAMP,
      signed_at TIMESTAMP,
      signature_request_id VARCHAR(255),
      signature_document_url VARCHAR(500),
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      UNIQUE(contract_id, artist_id)
  );

  CREATE TABLE contract_versions (
      id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
      contract_id UUID NOT NULL REFERENCES contracts(id) ON DELETE CASCADE,
      version_number INTEGER NOT NULL,
      document_url VARCHAR(500) NOT NULL,
      change_summary TEXT,
      created_by UUID NOT NULL REFERENCES users(id),
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      UNIQUE(contract_id, version_number)
  );
  ```

- **External Integrations**:
  - SharePoint Graph API for document storage and retrieval
  - DocuSign Connect or Adobe Sign API for embedded signatures
  - WebHooks for real-time signature status updates
  - Azure Blob/S3 for temporary document caching

- **Security Considerations**:
  - Signed URLs for secure document access (15-minute expiration)
  - Document encryption at rest in all storage locations
  - Audit trail for all document actions
  - IP-based access restrictions for sensitive contracts

- **Performance Requirements**:
  - Document upload < 10 seconds for 50MB files
  - Signature status updates < 1 second via webhooks
  - Document preview generation < 3 seconds
  - Bulk assignment processing < 100ms per artist

#### Mobile Expense Submission
**Description**: Camera-first expense submission workflow optimized for touring artists with receipt capture and automated processing.

**User Stories**: Artists capture receipts immediately after purchase, submit expenses with minimal data entry, and track reimbursement status in real-time.

**Technical Implementation**:
- **Frontend Components**:
  - `ExpenseCapture` with camera API integration
  - `ReceiptEditor` with auto-crop and enhancement
  - `ExpenseForm` with smart defaults and validation
  - `ExpenseHistory` with filtering and status tracking
  - `OfflineQueue` for poor connectivity scenarios

- **Backend Services**:
  - `POST /api/v1/expenses` - Creates new expense claim
  - `POST /api/v1/expenses/:id/receipts` - Handles receipt upload
  - `PUT /api/v1/expenses/:id` - Updates expense details
  - `POST /api/v1/expenses/:id/submit` - Submits for approval
  - `GET /api/v1/expenses` - Lists expenses with filtering

- **Database Schema**:
  ```sql
  CREATE TABLE expenses (
      id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
      artist_id UUID NOT NULL REFERENCES artists(id),
      organization_id UUID NOT NULL REFERENCES organizations(id),
      amount DECIMAL(10, 2) NOT NULL,
      currency VARCHAR(3) NOT NULL DEFAULT 'USD',
      category VARCHAR(100) NOT NULL,
      description TEXT,
      expense_date DATE NOT NULL,
      status VARCHAR(50) NOT NULL DEFAULT 'draft',
      submitted_at TIMESTAMP,
      approved_by UUID REFERENCES users(id),
      approved_at TIMESTAMP,
      rejection_reason TEXT,
      xero_id VARCHAR(255),
      hubdoc_id VARCHAR(255),
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      CHECK (status IN ('draft', 'submitted', 'approved', 'rejected', 'paid', 'cancelled'))
  );

  CREATE TABLE expense_receipts (
      id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
      expense_id UUID NOT NULL REFERENCES expenses(id) ON DELETE CASCADE,
      file_url VARCHAR(500) NOT NULL,
      thumbnail_url VARCHAR(500),
      file_size_bytes INTEGER,
      mime_type VARCHAR(100),
      ocr_extracted_amount DECIMAL(10, 2),
      ocr_confidence DECIMAL(3, 2),
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  );

  CREATE TABLE expense_categories (
      id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
      organization_id UUID NOT NULL REFERENCES organizations(id),
      name VARCHAR(100) NOT NULL,
      code VARCHAR(50),
      xero_account_code VARCHAR(50),
      requires_receipt BOOLEAN DEFAULT TRUE,
      max_amount DECIMAL(10, 2),
      active BOOLEAN DEFAULT TRUE,
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      UNIQUE(organization_id, name)
  );
  ```

- **External Integrations**:
  - Xero API for expense creation and category sync
  - Hubdoc API for receipt processing and OCR
  - Sharp/ImageMagick for image optimization
  - Redis queue for offline submission support

- **Security Considerations**:
  - Receipt images encrypted before storage
  - PII redaction in receipt thumbnails
  - Audit trail for all expense modifications
  - Role-based approval limits

- **Performance Requirements**:
  - Receipt capture and optimization < 3 seconds
  - Form submission < 500ms
  - Image upload < 10 seconds for 10MB files
  - Offline queue sync within 30 seconds of connectivity

#### Personal Schedule Dashboard
**Description**: Real-time schedule management with timezone support for touring artists and instant notifications for changes.

**User Stories**: Artists view personalized schedules across timezones, receive immediate notifications for changes, and export events to personal calendars.

**Technical Implementation**:
- **Frontend Components**:
  - `ScheduleCalendar` with day/week/month views
  - `EventDetail` bottom sheet with venue information
  - `ScheduleNotification` for urgent updates
  - `CalendarExport` for iCal/Google Calendar
  - `TimezoneSelector` for touring support

- **Backend Services**:
  - `GET /api/v1/events` - Lists events with filtering
  - `GET /api/v1/events/:id` - Detailed event information
  - `POST /api/v1/events/:id/acknowledge` - Confirms receipt
  - `GET /api/v1/events/export` - iCal format export
  - WebSocket endpoint for real-time updates

- **Database Schema**:
  ```sql
  CREATE TABLE events (
      id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
      organization_id UUID NOT NULL REFERENCES organizations(id),
      title VARCHAR(255) NOT NULL,
      type VARCHAR(50) NOT NULL,
      start_datetime TIMESTAMP WITH TIME ZONE NOT NULL,
      end_datetime TIMESTAMP WITH TIME ZONE NOT NULL,
      timezone VARCHAR(50) NOT NULL,
      location_name VARCHAR(255),
      location_address TEXT,
      location_coordinates POINT,
      description TEXT,
      notes TEXT,
      requires_acknowledgment BOOLEAN DEFAULT FALSE,
      created_by UUID NOT NULL REFERENCES users(id),
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      CHECK (type IN ('rehearsal', 'performance', 'meeting', 'travel', 'other')),
      CHECK (end_datetime > start_datetime)
  );

  CREATE TABLE event_participants (
      id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
      event_id UUID NOT NULL REFERENCES events(id) ON DELETE CASCADE,
      artist_id UUID NOT NULL REFERENCES artists(id),
      status VARCHAR(50) NOT NULL DEFAULT 'invited',
      acknowledged_at TIMESTAMP,
      notes TEXT,
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      UNIQUE(event_id, artist_id),
      CHECK (status IN ('invited', 'confirmed', 'declined', 'tentative'))
  );

  CREATE TABLE event_updates (
      id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
      event_id UUID NOT NULL REFERENCES events(id) ON DELETE CASCADE,
      update_type VARCHAR(50) NOT NULL,
      previous_value JSONB,
      new_value JSONB,
      updated_by UUID NOT NULL REFERENCES users(id),
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  );
  ```

- **External Integrations**:
  - Socket.io for real-time WebSocket updates
  - Twilio for SMS notifications
  - iCal library for calendar exports
  - Google Maps API for venue locations

- **Security Considerations**:
  - Event visibility based on participation
  - Encrypted WebSocket connections
  - Rate-limited export functionality
  - Audit log for all schedule changes

- **Performance Requirements**:
  - Schedule load time < 1 second
  - Real-time updates < 500ms latency
  - Calendar export < 2 seconds
  - Notification delivery < 5 seconds

#### Administrative Control Panel
**Description**: Comprehensive dashboard for system administration with user management, analytics, and bulk operations.

**User Stories**: Administrators manage users and permissions efficiently, monitor system health and usage metrics, and perform bulk operations with confidence.

**Technical Implementation**:
- **Frontend Components**:
  - `AdminDashboard` with metric cards and charts
  - `UserManagement` with data tables and CRUD
  - `BulkOperations` with progress tracking
  - `SystemSettings` for organization config
  - `AuditLog` with advanced filtering

- **Backend Services**:
  - `GET /api/v1/admin/dashboard` - Aggregated metrics
  - `GET /api/v1/admin/users` - User management endpoints
  - `POST /api/v1/admin/bulk/*` - Bulk operation APIs
  - `GET /api/v1/admin/audit` - Audit log access
  - `PUT /api/v1/admin/settings` - System configuration

- **Database Schema**:
  ```sql
  CREATE TABLE organizations (
      id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
      name VARCHAR(255) NOT NULL,
      slug VARCHAR(100) UNIQUE NOT NULL,
      settings JSONB NOT NULL DEFAULT '{}',
      subscription_tier VARCHAR(50) NOT NULL DEFAULT 'professional',
      subscription_expires_at TIMESTAMP,
      storage_used_bytes BIGINT DEFAULT 0,
      storage_limit_bytes BIGINT,
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  );

  CREATE TABLE audit_logs (
      id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
      organization_id UUID NOT NULL REFERENCES organizations(id),
      user_id UUID REFERENCES users(id),
      action VARCHAR(100) NOT NULL,
      entity_type VARCHAR(50) NOT NULL,
      entity_id UUID,
      changes JSONB,
      ip_address INET,
      user_agent TEXT,
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  );

  CREATE INDEX idx_audit_logs_search ON audit_logs 
      USING gin(to_tsvector('english', action || ' ' || entity_type));
  
  CREATE TABLE system_settings (
      id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
      organization_id UUID NOT NULL REFERENCES organizations(id),
      key VARCHAR(100) NOT NULL,
      value JSONB NOT NULL,
      updated_by UUID NOT NULL REFERENCES users(id),
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      UNIQUE(organization_id, key)
  );
  ```

- **External Integrations**:
  - Elasticsearch for audit log search
  - Chart.js for data visualization
  - CSV export libraries for reports
  - Email service for automated reports

- **Security Considerations**:
  - Granular permission system for admin roles
  - IP whitelisting for admin access
  - Two-factor authentication (future)
  - Encrypted audit log storage

- **Performance Requirements**:
  - Dashboard load < 2 seconds
  - User search < 500ms for 50k records
  - Bulk operations: 100 records/second
  - Report generation < 10 seconds

### User Interface Specifications
Based on the Style Guide and UI States documentation, the interface implements a professional yet approachable design system optimized for both mobile and desktop experiences.

#### Design System Integration
- **Color Palette**: 
  - Primary: Portal Blue #1976D2 for navigation and CTAs
  - Success: Green #4CAF50 for confirmations
  - Error: Red #F44336 for validation errors
  - Warning: Amber #FFA726 for pending states
  - Neutral grays for backgrounds and secondary elements

- **Typography**: 
  - Inter font family for interface text
  - 16px minimum body text for mobile readability
  - Clear hierarchy with 32px H1 down to 12px captions
  - 1.5x line height for comfortable reading

- **Component Library**: 
  - Material-UI v5 components with custom theming
  - 44px minimum touch targets throughout
  - Consistent 8px spacing grid system
  - 4px border radius for inputs, 8px for cards

- **Responsive Design**: 
  - Mobile-first breakpoints: 320px, 768px, 1024px, 1440px
  - Fluid typography scaling between breakpoints
  - Flexible grid layouts with CSS Grid and Flexbox
  - Progressive disclosure for complex interfaces

- **Accessibility**: 
  - WCAG 2.1 AA compliance throughout
  - 4.5:1 minimum contrast ratios
  - Full keyboard navigation support
  - Screen reader optimizations with ARIA labels

#### State Management
- **UI States**: 
  - Initial, loading, success, and error states for all components
  - Skeleton screens for perceived performance
  - Optimistic updates for user actions
  - Clear error messages with recovery paths

- **Data Flow**: 
  - Redux Toolkit for global application state
  - React Query for server state and caching
  - Context API for theme and authentication
  - Local state for component-specific data

- **Error Handling**: 
  - Inline validation with helpful messages
  - Toast notifications for background operations
  - Full-page errors with support contact
  - Automatic retry for transient failures

- **Loading States**: 
  - Shimmer effects for content placeholders
  - Progress bars for file uploads
  - Spinner overlays for form submissions
  - Staggered animations for list items

## Technology Stack

### Frontend Technology
- **Framework**: React 18.2+ with concurrent features and Suspense for data fetching
- **Language**: TypeScript 5.0+ with strict mode for type safety
- **State Management**: Redux Toolkit 2.0+ for global state, React Query 5.0+ for server state
- **UI Components**: Material-UI 5.14+ with custom theme, React Hook Form for form management
- **Styling**: Emotion CSS-in-JS with theme integration, CSS modules for component styles
- **Build Tools**: Vite 5.0+ for fast HMR, Rollup for production builds, SWC for transpilation
- **Testing**: Vitest for unit tests, React Testing Library for components, Playwright for E2E
- **Performance**: React.lazy for code splitting, Service workers for offline, Workbox for caching
- **Development Tools**: ESLint with Airbnb config, Prettier for formatting, Husky for git hooks

### Backend Technology
- **Runtime Environment**: Node.js 20 LTS with native ESM support
- **Web Framework**: Express.js 4.18+ with async error handling
- **Language**: TypeScript 5.0+ with path aliases and decorators
- **Database ORM**: Prisma 5.0+ for type-safe queries, migrations, and seeding
- **Authentication**: Passport.js with JWT strategy, express-session for session management
- **API Design**: RESTful with OpenAPI 3.0 documentation, JSON:API specification
- **Validation**: Joi for request validation, class-validator for DTOs
- **Testing**: Jest 29+ for unit tests, Supertest for API tests, test containers for integration
- **Documentation**: Swagger UI for API docs, TypeDoc for code documentation
- **Process Management**: PM2 for production, nodemon for development

### Infrastructure & DevOps
- **Cloud Provider**: Azure (primary) for SharePoint proximity, AWS as fallback option
- **Container Platform**: Docker 24+ with multi-stage builds, Docker Compose for local dev
- **Orchestration**: Kubernetes 1.28+ with Helm charts, ArgoCD for GitOps
- **Database**: Azure Database for PostgreSQL 14+ with read replicas, automated backups
- **Caching**: Azure Cache for Redis 6+, Redis Sentinel for HA
- **File Storage**: Azure Blob Storage with CDN, lifecycle management policies
- **CDN**: Azure CDN with custom domain, automatic cache invalidation
- **Monitoring**: Application Insights for APM, Azure Monitor for infrastructure
- **Logging**: Winston for application logs, Fluentd for log aggregation
- **CI/CD**: GitHub Actions for CI, Azure DevOps for CD, Terraform for IaC

## Data Models

### Database Design
The database schema implements a normalized design with strategic denormalization for performance, using PostgreSQL's advanced features for flexibility and scalability.

#### Entity Relationship Diagram
```mermaid
erDiagram
    Organization ||--o{ User : has
    Organization ||--o{ Contract : creates
    Organization ||--o{ Event : schedules
    Organization ||--o{ ExpenseCategory : defines
    Organization ||--o{ SystemSetting : configures
    
    User ||--o| Artist : "may be"
    User ||--o{ UserSession : creates
    User ||--o{ PasswordResetToken : requests
    User ||--o{ AuditLog : generates
    User ||--o{ Notification : receives
    
    Artist ||--o{ ContractAssignment : "assigned to"
    Artist ||--o{ Expense : submits
    Artist ||--o{ EventParticipant : "participates in"
    Artist ||--o{ ArtistDocument : owns
    
    Contract ||--o{ ContractAssignment : has
    Contract ||--o{ ContractVersion : "versioned as"
    Contract ||--o{ ContractActivity : tracks
    
    ContractAssignment ||--o{ SignatureEvent : generates
    
    Expense ||--o{ ExpenseReceipt : includes
    Expense ||--o{ ExpenseApproval : requires
    Expense ||--o{ ExpenseActivity : tracks
    
    Event ||--o{ EventParticipant : includes
    Event ||--o{ EventUpdate : "updated via"
    
    ExpenseCategory ||--o{ Expense : categorizes
    
    Organization {
        UUID id PK
        String name
        String slug UK
        JSONB settings
        String subscription_tier
        Timestamp subscription_expires_at
        BigInt storage_used_bytes
        BigInt storage_limit_bytes
    }
    
    User {
        UUID id PK
        String email UK
        String password_hash
        String role
        UUID organization_id FK
        Boolean email_verified
        Timestamp last_login
        Integer failed_login_attempts
        Timestamp locked_until
    }
    
    Artist {
        UUID id PK
        UUID user_id FK
        String legal_name
        String stage_name
        JSONB tax_info
        JSONB emergency_contact
        String preferred_timezone
    }
    
    Contract {
        UUID id PK
        UUID organization_id FK
        String title
        String document_url
        String sharepoint_id
        String status
        Integer version
        UUID created_by FK
    }
    
    Expense {
        UUID id PK
        UUID artist_id FK
        Decimal amount
        String currency
        String category
        Date expense_date
        String status
        UUID approved_by FK
        String xero_id
    }
    
    Event {
        UUID id PK
        UUID organization_id FK
        String title
        String type
        Timestamp start_datetime
        Timestamp end_datetime
        String timezone
        Point location_coordinates
    }
```

#### Database Schema
```sql
-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "postgis";

-- Organizations table (multi-tenant root)
CREATE TABLE organizations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL,
    settings JSONB NOT NULL DEFAULT '{}',
    branding JSONB NOT NULL DEFAULT '{}',
    subscription_tier VARCHAR(50) NOT NULL DEFAULT 'professional',
    subscription_expires_at TIMESTAMP,
    storage_used_bytes BIGINT DEFAULT 0,
    storage_limit_bytes BIGINT DEFAULT 53687091200, -- 50GB default
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (subscription_tier IN ('artist', 'professional', 'enterprise'))
);

-- Users table with enhanced security
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    organization_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    email_verified BOOLEAN DEFAULT FALSE,
    email_verified_at TIMESTAMP,
    last_login TIMESTAMP,
    failed_login_attempts INTEGER DEFAULT 0,
    locked_until TIMESTAMP,
    two_factor_enabled BOOLEAN DEFAULT FALSE,
    two_factor_secret VARCHAR(255),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (role IN ('artist', 'admin', 'accountant', 'production_manager', 'finance_director'))
);

-- Artists table with extended profile
CREATE TABLE artists (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID UNIQUE NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    legal_name VARCHAR(255) NOT NULL,
    stage_name VARCHAR(255),
    tax_info JSONB, -- Encrypted
    emergency_contact JSONB,
    preferred_timezone VARCHAR(50) DEFAULT 'America/New_York',
    bio TEXT,
    profile_image_url VARCHAR(500),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- User sessions for JWT refresh tokens
CREATE TABLE user_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    refresh_token_hash VARCHAR(255) NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    ip_address INET,
    user_agent TEXT,
    device_info JSONB,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Password reset tokens
CREATE TABLE password_reset_tokens (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    token_hash VARCHAR(255) NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    used_at TIMESTAMP,
    ip_address INET,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Contracts with version control
CREATE TABLE contracts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    document_url VARCHAR(500) NOT NULL,
    sharepoint_id VARCHAR(255),
    sharepoint_metadata JSONB,
    file_size_bytes BIGINT,
    mime_type VARCHAR(100),
    status VARCHAR(50) NOT NULL DEFAULT 'draft',
    version INTEGER NOT NULL DEFAULT 1,
    tags TEXT[],
    metadata JSONB,
    created_by UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    archived_at TIMESTAMP,
    CHECK (status IN ('draft', 'pending', 'active', 'completed', 'archived', 'cancelled'))
);

-- Contract assignments to artists
CREATE TABLE contract_assignments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    contract_id UUID NOT NULL REFERENCES contracts(id) ON DELETE CASCADE,
    artist_id UUID NOT NULL REFERENCES artists(id),
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    sent_at TIMESTAMP,
    viewed_at TIMESTAMP,
    signed_at TIMESTAMP,
    declined_at TIMESTAMP,
    decline_reason TEXT,
    signature_request_id VARCHAR(255),
    signature_document_url VARCHAR(500),
    reminder_count INTEGER DEFAULT 0,
    last_reminder_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(contract_id, artist_id),
    CHECK (status IN ('pending', 'sent', 'viewed', 'signed', 'declined', 'expired'))
);

-- Contract versions for history
CREATE TABLE contract_versions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    contract_id UUID NOT NULL REFERENCES contracts(id) ON DELETE CASCADE,
    version_number INTEGER NOT NULL,
    document_url VARCHAR(500) NOT NULL,
    change_summary TEXT,
    changed_sections JSONB,
    created_by UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(contract_id, version_number)
);

-- Expense categories with Xero mapping
CREATE TABLE expense_categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    code VARCHAR(50),
    description TEXT,
    xero_account_code VARCHAR(50),
    hubdoc_category VARCHAR(100),
    requires_receipt BOOLEAN DEFAULT TRUE,
    requires_approval BOOLEAN DEFAULT TRUE,
    max_amount DECIMAL(10, 2),
    gl_code VARCHAR(50),
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(organization_id, name),
    UNIQUE(organization_id, code)
);

-- Expenses with enhanced tracking
CREATE TABLE expenses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    artist_id UUID NOT NULL REFERENCES artists(id),
    organization_id UUID NOT NULL REFERENCES organizations(id),
    amount DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) NOT NULL DEFAULT 'USD',
    category_id UUID NOT NULL REFERENCES expense_categories(id),
    merchant VARCHAR(255),
    description TEXT,
    expense_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'draft',
    submitted_at TIMESTAMP,
    approved_by UUID REFERENCES users(id),
    approved_at TIMESTAMP,
    rejected_by UUID REFERENCES users(id),
    rejected_at TIMESTAMP,
    rejection_reason TEXT,
    paid_at TIMESTAMP,
    payment_method VARCHAR(50),
    xero_id VARCHAR(255),
    xero_sync_status VARCHAR(50),
    xero_sync_error TEXT,
    hubdoc_id VARCHAR(255),
    reimbursement_method VARCHAR(50),
    notes TEXT,
    tags TEXT[],
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (status IN ('draft', 'submitted', 'approved', 'rejected', 'paid', 'cancelled', 'archived')),
    CHECK (amount > 0)
);

-- Expense receipts with OCR data
CREATE TABLE expense_receipts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    expense_id UUID NOT NULL REFERENCES expenses(id) ON DELETE CASCADE,
    file_url VARCHAR(500) NOT NULL,
    thumbnail_url VARCHAR(500),
    file_size_bytes INTEGER,
    mime_type VARCHAR(100),
    original_filename VARCHAR(255),
    ocr_extracted_data JSONB,
    ocr_extracted_amount DECIMAL(10, 2),
    ocr_extracted_date DATE,
    ocr_extracted_merchant VARCHAR(255),
    ocr_confidence DECIMAL(3, 2),
    ocr_processed_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Events with timezone support
CREATE TABLE events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL,
    start_datetime TIMESTAMP WITH TIME ZONE NOT NULL,
    end_datetime TIMESTAMP WITH TIME ZONE NOT NULL,
    timezone VARCHAR(50) NOT NULL,
    all_day BOOLEAN DEFAULT FALSE,
    location_name VARCHAR(255),
    location_address TEXT,
    location_coordinates GEOGRAPHY(POINT),
    location_details JSONB,
    description TEXT,
    notes TEXT,
    color VARCHAR(7),
    requires_acknowledgment BOOLEAN DEFAULT FALSE,
    acknowledgment_deadline TIMESTAMP WITH TIME ZONE,
    recurrence_rule TEXT, -- RFC 5545 RRULE
    recurrence_exceptions TIMESTAMP WITH TIME ZONE[],
    parent_event_id UUID REFERENCES events(id),
    created_by UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    cancelled_at TIMESTAMP,
    CHECK (type IN ('rehearsal', 'performance', 'meeting', 'travel', 'call_time', 'other')),
    CHECK (end_datetime > start_datetime OR all_day = TRUE)
);

-- Event participants with RSVP
CREATE TABLE event_participants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id UUID NOT NULL REFERENCES events(id) ON DELETE CASCADE,
    artist_id UUID NOT NULL REFERENCES artists(id),
    role VARCHAR(100),
    status VARCHAR(50) NOT NULL DEFAULT 'invited',
    acknowledged_at TIMESTAMP,
    acknowledgment_note TEXT,
    check_in_time TIMESTAMP WITH TIME ZONE,
    check_out_time TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(event_id, artist_id),
    CHECK (status IN ('invited', 'confirmed', 'declined', 'tentative', 'no_response'))
);

-- Notifications for all users
CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL,
    channel VARCHAR(20) NOT NULL,
    subject VARCHAR(255),
    content TEXT NOT NULL,
    metadata JSONB,
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    scheduled_for TIMESTAMP,
    sent_at TIMESTAMP,
    read_at TIMESTAMP,
    error_message TEXT,
    retry_count INTEGER DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (type IN ('contract_assigned', 'contract_signed', 'expense_approved', 'expense_rejected', 'schedule_change', 'reminder', 'announcement')),
    CHECK (channel IN ('email', 'sms', 'push', 'in_app')),
    CHECK (status IN ('pending', 'sent', 'delivered', 'failed', 'read'))
);

-- Comprehensive audit log
CREATE TABLE audit_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id UUID NOT NULL REFERENCES organizations(id),
    user_id UUID REFERENCES users(id),
    action VARCHAR(100) NOT NULL,
    entity_type VARCHAR(50) NOT NULL,
    entity_id UUID,
    changes JSONB,
    metadata JSONB,
    ip_address INET,
    user_agent TEXT,
    session_id UUID,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- System settings for organizations
CREATE TABLE system_settings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    organization_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    category VARCHAR(50) NOT NULL,
    key VARCHAR(100) NOT NULL,
    value JSONB NOT NULL,
    description TEXT,
    updated_by UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(organization_id, category, key)
);

-- Create indexes for performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_organization ON users(organization_id);
CREATE INDEX idx_artists_user ON artists(user_id);
CREATE INDEX idx_contracts_organization ON contracts(organization_id);
CREATE INDEX idx_contracts_status ON contracts(status);
CREATE INDEX idx_contract_assignments_artist ON contract_assignments(artist_id);
CREATE INDEX idx_contract_assignments_status ON contract_assignments(status);
CREATE INDEX idx_expenses_artist ON expenses(artist_id);
CREATE INDEX idx_expenses_organization ON expenses(organization_id);
CREATE INDEX idx_expenses_status ON expenses(status);
CREATE INDEX idx_expenses_date ON expenses(expense_date);
CREATE INDEX idx_events_organization ON events(organization_id);
CREATE INDEX idx_events_dates ON events(start_datetime, end_datetime);
CREATE INDEX idx_event_participants_artist ON event_participants(artist_id);
CREATE INDEX idx_notifications_user ON notifications(user_id);
CREATE INDEX idx_notifications_status ON notifications(status);
CREATE INDEX idx_audit_logs_organization ON audit_logs(organization_id);
CREATE INDEX idx_audit_logs_entity ON audit_logs(entity_type, entity_id);
CREATE INDEX idx_audit_logs_created ON audit_logs(created_at);

-- Full-text search indexes
CREATE INDEX idx_contracts_search ON contracts 
    USING gin(to_tsvector('english', title || ' ' || COALESCE(description, '')));
CREATE INDEX idx_expenses_search ON expenses 
    USING gin(to_tsvector('english', COALESCE(merchant, '') || ' ' || COALESCE(description, '')));
CREATE INDEX idx_events_search ON events 
    USING gin(to_tsvector('english', title || ' ' || COALESCE(description, '')));

-- Create update timestamp trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply update trigger to all tables with updated_at
CREATE TRIGGER update_organizations_updated_at BEFORE UPDATE ON organizations
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_artists_updated_at BEFORE UPDATE ON artists
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_contracts_updated_at BEFORE UPDATE ON contracts
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_contract_assignments_updated_at BEFORE UPDATE ON contract_assignments
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_expense_categories_updated_at BEFORE UPDATE ON expense_categories
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_expenses_updated_at BEFORE UPDATE ON expenses
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_events_updated_at BEFORE UPDATE ON events
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_event_participants_updated_at BEFORE UPDATE ON event_participants
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_system_settings_updated_at BEFORE UPDATE ON system_settings
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
```

#### Data Relationships
- **User Management**: One-to-many relationship between organizations and users, with optional one-to-one mapping to artist profiles
- **Contract Flow**: Contracts belong to organizations with many-to-many assignments to artists through junction table
- **Expense Tracking**: Artists submit expenses within organization context with category constraints and approval workflows
- **Schedule Coordination**: Events belong to organizations with many-to-many participant relationships and timezone awareness
- **Audit Trail**: Comprehensive logging of all entity changes with user attribution and metadata
- **Soft Deletes**: Status-based soft deletes for contracts and expenses, timestamp-based for events

## Security Architecture

### Authentication & Authorization
Implementing defense-in-depth security with multiple layers of protection for user data and system resources.

#### Authentication Strategy
- **Method**: JWT-based authentication with asymmetric RS256 signing
- **Token Structure**:
  ```typescript
  interface AccessTokenPayload {
    sub: string; // User ID
    email: string;
    role: UserRole;
    org: string; // Organization ID
    permissions: string[];
    iat: number;
    exp: number;
    jti: string; // Token ID for revocation
  }
  ```
- **Token Expiry**: 
  - Access tokens: 15 minutes (reduced from 24 hours for security)
  - Refresh tokens: 7 days with sliding window
  - Remember me: 30 days with secure device fingerprinting
- **Session Management**: 
  - Stateless JWT with Redis blacklist for revoked tokens
  - Concurrent session limits based on subscription tier
  - Device tracking with anomaly detection
- **Multi-Factor Authentication**: 
  - TOTP-based 2FA with backup codes (Phase 2)
  - SMS fallback for artists without authenticator apps
  - Mandatory for admin accounts handling financial data
- **Password Policy**: 
  - Minimum 12 characters with complexity requirements
  - Pwned Passwords API integration for breach checking
  - Force reset on suspicious activity detection

#### Authorization Framework
- **Role-Based Access Control (RBAC)**:
  ```typescript
  enum UserRole {
    ARTIST = 'artist',
    ADMIN = 'admin',
    ACCOUNTANT = 'accountant',
    PRODUCTION_MANAGER = 'production_manager',
    FINANCE_DIRECTOR = 'finance_director'
  }

  interface RolePermissions {
    [UserRole.ARTIST]: ['contracts:read:own', 'expenses:write:own', 'schedule:read:own'];
    [UserRole.ADMIN]: ['*:*:*']; // Full access
    [UserRole.ACCOUNTANT]: ['expenses:*:*', 'reports:read:*'];
    [UserRole.PRODUCTION_MANAGER]: ['schedule:*:*', 'events:write:*'];
    [UserRole.FINANCE_DIRECTOR]: ['expenses:approve:high_value', 'reports:*:*'];
  }
  ```
- **Resource-Level Permissions**: 
  - Row-level security in PostgreSQL for multi-tenancy
  - Attribute-based access control for fine-grained permissions
  - Dynamic permission evaluation based on resource state
- **API Authorization**: 
  - OAuth 2.0 scopes for third-party integrations
  - API key management with rotation policies
  - Rate limiting by role and endpoint
- **Data Access Controls**: 
  - Organization-based data isolation
  - Field-level encryption for PII
  - Audit logging for all data access

### Data Protection & Privacy
Implementing comprehensive data protection measures to ensure privacy and regulatory compliance.

#### Encryption Standards
- **Data at Rest**: 
  - AES-256-GCM encryption for database fields containing PII
  - Transparent Data Encryption (TDE) for entire database
  - Encrypted file storage with customer-managed keys
  - Secure key management with Azure Key Vault/AWS KMS
- **Data in Transit**: 
  - TLS 1.3 minimum for all client connections
  - Certificate pinning for mobile applications
  - End-to-end encryption for sensitive documents
  - VPN requirements for admin access
- **Database Encryption**: 
  ```sql
  -- Example of field-level encryption for sensitive data
  CREATE EXTENSION IF NOT EXISTS pgcrypto;
  
  -- Encrypt tax information
  UPDATE artists 
  SET tax_info = pgp_sym_encrypt(
    tax_info::text, 
    current_setting('app.encryption_key')
  )::jsonb;
  ```
- **File Storage**: 
  - Client-side encryption before upload
  - Unique encryption keys per file
  - Secure key derivation from user credentials
  - Automatic re-encryption on key rotation

#### Privacy & Compliance
- **Data Minimization**: 
  - Collect only required fields for functionality
  - Automatic PII redaction in logs
  - Anonymous analytics with no tracking
  - Progressive data collection based on need
- **Data Retention**: 
  - 7-year retention for contracts (legal requirement)
  - 3-year retention for financial records
  - 90-day retention for system logs
  - Automated purge of expired data
- **User Consent**: 
  - Granular consent management
  - Clear privacy policy acceptance
  - Opt-in for non-essential features
  - Easy consent withdrawal mechanism
- **Data Export/Deletion**: 
  - Self-service data export in JSON/CSV
  - Right to deletion within 30 days
  - Cascading deletion of related records
  - Audit trail of deletion requests

### Security Headers & Hardening
```nginx
# Nginx security headers configuration
add_header Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; font-src 'self' data:; connect-src 'self' wss://live.bigportal.com https://api.bigportal.com; frame-ancestors 'none'; base-uri 'self'; form-action 'self';" always;

add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload" always;
add_header X-Frame-Options "DENY" always;
add_header X-Content-Type-Options "nosniff" always;
add_header Referrer-Policy "strict-origin-when-cross-origin" always;
add_header Permissions-Policy "accelerometer=(), camera=(self), geolocation=(), gyroscope=(), magnetometer=(), microphone=(), payment=(), usb=()" always;
add_header X-XSS-Protection "1; mode=block" always;
```

### Input Validation & Sanitization
- **Server-Side Validation**: 
  ```typescript
  // Example validation schema using Joi
  const expenseSchema = Joi.object({
    amount: Joi.number().positive().max(10000).required(),
    currency: Joi.string().length(3).uppercase().required(),
    category: Joi.string().uuid().required(),
    description: Joi.string().max(500).trim().required(),
    expense_date: Joi.date().max('now').required(),
    receipts: Joi.array().items(Joi.string().uri()).max(5)
  });
  ```
- **SQL Injection Prevention**: 
  - Parameterized queries exclusively
  - Prisma ORM with prepared statements
  - Input type coercion and validation
  - Stored procedure usage for complex operations
- **XSS Protection**: 
  - React's automatic escaping
  - DOMPurify for user-generated content
  - Content-Type validation
  - SVG sanitization for uploads
- **CSRF Protection**: 
  - Double-submit cookie pattern
  - SameSite cookie attributes
  - Origin header validation
  - State parameter for OAuth flows
- **Rate Limiting**: 
  ```typescript
  // Rate limiting configuration
  const rateLimiters = {
    login: rateLimit({
      windowMs: 1 * 60 * 1000, // 1 minute
      max: 5, // 5 attempts
      skipSuccessfulRequests: true
    }),
    api: rateLimit({
      windowMs: 60 * 60 * 1000, // 1 hour
      max: 1000, // 1000 requests
      keyGenerator: (req) => req.user?.id || req.ip
    }),
    upload: rateLimit({
      windowMs: 24 * 60 * 60 * 1000, // 24 hours
      max: 100, // 100 uploads
      skipFailedRequests: true
    })
  };
  ```

## Performance Requirements

### Response Times
- **API Endpoints**: 
  - p50: < 100ms
  - p95: < 200ms
  - p99: < 500ms
- **Page Load**: 
  - First Contentful Paint: < 1.5s
  - Time to Interactive: < 3.0s
  - Largest Contentful Paint: < 2.5s
- **Database Queries**: 
  - Simple queries: < 50ms
  - Complex joins: < 100ms
  - Aggregations: < 200ms
- **Search Operations**: 
  - Autocomplete: < 100ms
  - Full-text search: < 500ms
  - Faceted search: < 1s

### Scalability
- **Concurrent Users**: 
  - Support 1,000 concurrent active users
  - 10,000 total daily active users
  - 50,000 registered users per organization
- **Request Volume**: 
  - 1,000 requests/second sustained
  - 5,000 requests/second peak
  - 100 requests/second for uploads
- **Database Connections**: 
  - Connection pool: 100 connections
  - Connection timeout: 30 seconds
  - Idle timeout: 10 minutes
- **Scaling Strategy**: 
  - Horizontal scaling for application servers
  - Read replicas for database scaling
  - Auto-scaling based on CPU and memory
  - Geographic distribution for global access

### Caching Strategy
- **Browser Cache**: 
  - Static assets: 1 year with content hash
  - API responses: 5 minutes for lists
  - User data: Session storage only
- **CDN Cache**: 
  - Images: 30 days
  - Documents: 7 days with revalidation
  - JavaScript/CSS: 1 year with versioning
- **Application Cache**: 
  - User sessions: 30 minutes sliding window
  - Permission cache: 15 minutes
  - API responses: 5-60 minutes based on data
- **Database Cache**: 
  - Query result cache: 60 seconds
  - Prepared statement cache: Per connection
  - Materialized views for reports

## Infrastructure Requirements

### Compute
- **Application Servers**: 
  - Production: 4x D4s v3 (4 vCPU, 16GB RAM)
  - Staging: 2x D2s v3 (2 vCPU, 8GB RAM)
  - Development: 1x D2s v3
- **Load Balancing**: 
  - Azure Application Gateway with WAF
  - Health probes every 5 seconds
  - Session affinity for WebSocket
  - Geographic routing for multi-region
- **Auto-scaling**: 
  - CPU threshold: 70%
  - Memory threshold: 80%
  - Scale out: 2 instances per trigger
  - Scale in: 1 instance with 5-minute cooldown

### Storage
- **Database**: 
  - Azure Database for PostgreSQL
  - 500GB SSD storage with auto-growth
  - Point-in-time restore: 35 days
  - Geo-redundant backups
- **File Storage**: 
  - Azure Blob Storage: 5TB initial
  - Hot tier for recent documents
  - Cool tier after 30 days
  - Archive tier after 1 year
- **Backup Storage**: 
  - Daily backups: 30-day retention
  - Weekly backups: 12-week retention
  - Monthly backups: 12-month retention
  - Yearly backups: 7-year retention
- **Log Retention**: 
  - Application logs: 90 days
  - Access logs: 180 days
  - Audit logs: 7 years
  - Performance logs: 30 days

### Network
- **Architecture**: 
  - Hub-spoke VNet topology
  - Private endpoints for PaaS services
  - Network security groups per tier
  - DDoS Protection Standard
- **Security Groups**: 
  ```hcl
  # Example Terraform security rules
  resource "azurerm_network_security_rule" "web_inbound" {
    name                       = "AllowHTTPS"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["443"]
    source_address_prefix      = "Internet"
    destination_address_prefix = "VirtualNetwork"
  }
  ```
- **CDN Configuration**: 
  - Azure CDN Standard
  - 50+ global PoPs
  - Custom domain with SSL
  - Compression and minification
  - Cache rules per file type

### Monitoring & Logging
- **APM Solution**: 
  - Application Insights with custom events
  - Distributed tracing
  - Performance counters
  - Custom metrics and dashboards
- **Error Tracking**: 
  - Real-time error notifications
  - Error grouping and trends
  - Source map support
  - User impact analysis
- **Log Aggregation**: 
  - Azure Log Analytics workspace
  - Custom log queries
  - Alert rules for anomalies
  - Integration with SIEM
- **Uptime Monitoring**: 
  - Multi-region availability tests
  - API endpoint monitoring
  - SSL certificate monitoring
  - SLA dashboard with 99.9% target

## Development Environment

### Local Development
```yaml
# docker-compose.yml
version: '3.8'

services:
  postgres:
    image: postgis/postgis:14-3.2
    environment:
      POSTGRES_DB: biglive_dev
      POSTGRES_USER: biglive
      POSTGRES_PASSWORD: ${DB_PASSWORD:-development}
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./scripts/init-db.sql:/docker-entrypoint-initdb.d/init.sql
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U biglive"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    command: redis-server --appendonly yes --requirepass ${REDIS_PASSWORD:-development}
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "auth", "${REDIS_PASSWORD:-development}", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.11.0
    environment:
      - discovery.type=single-node
      - xpack.security.enabled=false
      - ES_JAVA_OPTS=-Xms512m -Xmx512m
    ports:
      - "9200:9200"
    volumes:
      - es_data:/usr/share/elasticsearch/data

  api:
    build:
      context: ./api
      dockerfile: Dockerfile.dev
    environment:
      NODE_ENV: development
      DATABASE_URL: postgresql://biglive:${DB_PASSWORD:-development}@postgres:5432/biglive_dev
      REDIS_URL: redis://:${REDIS_PASSWORD:-development}@redis:6379
      ELASTICSEARCH_URL: http://elasticsearch:9200
      JWT_SECRET: ${JWT_SECRET:-development-secret}
      SHAREPOINT_CLIENT_ID: ${SHAREPOINT_CLIENT_ID}
      SHAREPOINT_CLIENT_SECRET: ${SHAREPOINT_CLIENT_SECRET}
    ports:
      - "3000:3000"
      - "9229:9229" # Node debugger
    volumes:
      - ./api:/app
      - /app/node_modules
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
      elasticsearch:
        condition: service_started
    command: npm run dev

  web:
    build:
      context: ./web
      dockerfile: Dockerfile.dev
    environment:
      VITE_API_URL: http://localhost:3000
      VITE_WS_URL: ws://localhost:3000
    ports:
      - "5173:5173"
    volumes:
      - ./web:/app
      - /app/node_modules
    command: npm run dev

  mailhog:
    image: mailhog/mailhog
    ports:
      - "1025:1025" # SMTP
      - "8025:8025" # Web UI

volumes:
  postgres_data:
  redis_data:
  es_data:

networks:
  default:
    name: biglive_network
```

### Environment Variables
```env
# .env.development
NODE_ENV=development
PORT=3000
API_URL=http://localhost:3000

# Database
DATABASE_URL=postgresql://biglive:development@localhost:5432/biglive_dev
DATABASE_POOL_MIN=2
DATABASE_POOL_MAX=10

# Redis
REDIS_URL=redis://:development@localhost:6379
REDIS_PREFIX=biglive:

# Elasticsearch
ELASTICSEARCH_URL=http://localhost:9200
ELASTICSEARCH_INDEX_PREFIX=biglive_

# Authentication
JWT_SECRET=development-secret-change-in-production
JWT_ACCESS_EXPIRY=15m
JWT_REFRESH_EXPIRY=7d
BCRYPT_ROUNDS=12

# SharePoint Integration
SHAREPOINT_TENANT_ID=your-tenant-id
SHAREPOINT_CLIENT_ID=your-client-id
SHAREPOINT_CLIENT_SECRET=your-client-secret
SHAREPOINT_SITE_URL=https://yourorg.sharepoint.com/sites/contracts

# Xero Integration
XERO_CLIENT_ID=your-xero-client-id
XERO_CLIENT_SECRET=your-xero-client-secret
XERO_REDIRECT_URI=http://localhost:3000/api/v1/xero/callback

# DocuSign Integration
DOCUSIGN_INTEGRATION_KEY=your-integration-key
DOCUSIGN_SECRET_KEY=your-secret-key
DOCUSIGN_REDIRECT_URI=http://localhost:3000/api/v1/docusign/callback

# Email (Development uses Mailhog)
SMTP_HOST=localhost
SMTP_PORT=1025
SMTP_SECURE=false
SMTP_USER=
SMTP_PASS=
EMAIL_FROM="BIG Live Portal <noreply@bigliveportal.com>"

# File Storage
STORAGE_TYPE=local
STORAGE_LOCAL_PATH=./uploads
STORAGE_AZURE_ACCOUNT=
STORAGE_AZURE_KEY=
STORAGE_AZURE_CONTAINER=

# Monitoring
LOG_LEVEL=debug
SENTRY_DSN=
APPLICATION_INSIGHTS_KEY=

# Feature Flags
FEATURE_TWO_FACTOR_AUTH=false
FEATURE_OFFLINE_MODE=true
FEATURE_BULK_OPERATIONS=true
```

## Testing Strategy

### Unit Tests
- **Coverage Target**: 85% overall, 95% for critical paths
- **Key Areas**: 
  - Authentication and authorization logic
  - Business rule validation
  - Data transformation functions
  - API response formatting
  - Error handling paths
- **Mocking Strategy**: 
  - Database queries with in-memory fixtures
  - External API calls with recorded responses
  - File system operations with virtual fs
  - Time-based operations with clock mocking

### Integration Tests
- **API Endpoint Testing**: All REST endpoints with various payloads
- **Database Integration**: Transaction rollback between tests
- **External Service Mocking**: WireMock for third-party APIs
- **Authentication Flows**: Complete login/logout cycles
- **File Upload/Download**: Multipart form handling

### End-to-End Tests
- **Critical User Journeys**:
  - Artist login → View contract → Sign → Logout
  - Admin upload contracts → Assign → Track signatures
  - Artist capture receipt → Submit expense → Track approval
  - Schedule update → Notification → Acknowledgment
- **Cross-Browser Testing**: Chrome, Safari, Firefox, Edge
- **Mobile Testing**: Real device testing on iOS/Android
- **Performance Testing**: Lighthouse CI for performance regression

### Load Testing
- **Target**: 1,000 concurrent users
- **Scenarios**: 
  - Login surge during morning hours
  - Contract distribution to 500 artists
  - Month-end expense submission spike
  - Schedule check before performances
- **Success Criteria**: 
  - Response time p95 < 500ms under load
  - No errors at expected load
  - Graceful degradation at 2x load
  - Auto-scaling triggers properly

## Deployment Pipeline

### CI/CD Pipeline
```yaml
# .github/workflows/deploy.yml
name: Deploy to Production

on:
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run linting
        run: npm run lint
      
      - name: Run type checking
        run: npm run type-check
      
      - name: Run unit tests
        run: npm run test:unit -- --coverage
      
      - name: Run integration tests
        run: npm run test:integration
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3

  security-scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Run npm audit
        run: npm audit --production
      
      - name: Run Snyk scan
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
      
      - name: Run OWASP dependency check
        uses: dependency-check/Dependency-Check_Action@main
      
      - name: Run container scan
        uses: azure/container-scan@v0
        with:
          image-name: bigliveportal/api:${{ github.sha }}

  build:
    needs: [test, security-scan]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Build API Docker image
        run: |
          docker build -t bigliveportal/api:${{ github.sha }} ./api
          docker tag bigliveportal/api:${{ github.sha }} bigliveportal/api:latest
      
      - name: Build Web Docker image
        run: |
          docker build -t bigliveportal/web:${{ github.sha }} ./web
          docker tag bigliveportal/web:${{ github.sha }} bigliveportal/web:latest
      
      - name: Push to registry
        run: |
          echo ${{ secrets.REGISTRY_PASSWORD }} | docker login -u ${{ secrets.REGISTRY_USERNAME }} --password-stdin
          docker push bigliveportal/api:${{ github.sha }}
          docker push bigliveportal/api:latest
          docker push bigliveportal/web:${{ github.sha }}
          docker push bigliveportal/web:latest

  deploy-staging:
    needs: build
    runs-on: ubuntu-latest
    environment: staging
    steps:
      - name: Deploy to staging
        uses: azure/webapps-deploy@v2
        with:
          app-name: biglive-staging
          images: |
            bigliveportal/api:${{ github.sha }}
            bigliveportal/web:${{ github.sha }}
      
      - name: Run smoke tests
        run: npm run test:smoke -- --env=staging

  deploy-production:
    needs: deploy-staging
    runs-on: ubuntu-latest
    environment: production
    steps:
      - name: Deploy to production (blue)
        uses: azure/webapps-deploy@v2
        with:
          app-name: biglive-prod-blue
          images: |
            bigliveportal/api:${{ github.sha }}
            bigliveportal/web:${{ github.sha }}
      
      - name: Run health checks
        run: npm run test:health -- --env=production-blue
      
      - name: Switch traffic to blue
        run: |
          az webapp traffic-routing set \
            --distribution blue=100 \
            --name biglive-prod
      
      - name: Monitor for 5 minutes
        run: npm run monitor -- --duration=5m
      
      - name: Tag as stable
        run: |
          docker tag bigliveportal/api:${{ github.sha }} bigliveportal/api:stable
          docker tag bigliveportal/web:${{ github.sha }} bigliveportal/web:stable
          docker push bigliveportal/api:stable
          docker push bigliveportal/web:stable
```

### Rollback Strategy
- **Automated Rollback Triggers**:
  - Error rate > 5% for 2 minutes
  - Response time p95 > 1 second
  - Health check failures
  - Memory usage > 90%
- **Rollback Procedure**:
  1. Automatic traffic shift to previous version
  2. Alert to on-call engineer
  3. Preserve logs and metrics
  4. Create incident report
- **Data Migration Handling**:
  - Forward-compatible migrations only
  - Rollback scripts for each migration
  - Data validation before and after
  - Backup before major changes
- **Version Retention Policy**:
  - Keep last 5 stable versions
  - 30-day retention for all builds
  - Tag releases with semantic versioning
  - Maintain compatibility matrix

## API Specifications

### API Design Principles
- **RESTful Architecture**: Resource-based URLs with standard HTTP verbs
- **Consistent Naming**: Plural nouns for collections, kebab-case for multi-word resources
- **Versioning Strategy**: URL-based versioning (/api/v1/) with 1-year deprecation notice
- **Error Handling**: RFC 7807 Problem Details for consistent error responses
- **Authentication**: Bearer token in Authorization header for all protected endpoints
- **Rate Limiting**: X-RateLimit headers with remaining, limit, and reset values
- **Pagination**: Cursor-based with next/previous links in response
- **Filtering**: Query parameters for field filtering and search

### Core API Endpoints

#### Authentication Endpoints
```
POST /api/v1/auth/register
├── Request:
│   ├── Headers: Content-Type: application/json
│   ├── Body: {
│   │     "email": "sarah@example.com",
│   │     "password": "SecurePassword123!",
│   │     "first_name": "Sarah",
│   │     "last_name": "Chen",
│   │     "organization_id": "550e8400-e29b-41d4-a716-446655440000"
│   │   }
│   └── Validation: Email uniqueness, password strength, organization exists
├── Response:
│   ├── 201: {
│   │     "user": {
│   │       "id": "660e8400-e29b-41d4-a716-446655440001",
│   │       "email": "sarah@example.com",
│   │       "role": "artist",
│   │       "profile": { ... }
│   │     },
│   │     "tokens": {
│   │       "access_token": "eyJhbGciOiJSUzI1NiIs...",
│   │       "refresh_token": "eyJhbGciOiJSUzI1NiIs...",
│   │       "expires_in": 900
│   │     }
│   │   }
│   ├── 400: { "type": "validation_error", "errors": [...] }
│   └── 409: { "type": "email_exists", "detail": "Email already registered" }
└── Authorization: None required

POST /api/v1/auth/login
├── Request:
│   ├── Headers: Content-Type: application/json
│   └── Body: { "email": "sarah@example.com", "password": "SecurePassword123!" }
├── Response:
│   ├── 200: { "user": {...}, "tokens": {...} }
│   ├── 401: { "type": "invalid_credentials" }
│   └── 429: { "type": "too_many_attempts", "retry_after": 300 }
└── Authorization: None required

POST /api/v1/auth/refresh
├── Request:
│   ├── Headers: Content-Type: application/json
│   └── Body: { "refresh_token": "eyJhbGciOiJSUzI1NiIs..." }
├── Response:
│   ├── 200: { "access_token": "...", "expires_in": 900 }
│   └── 401: { "type": "invalid_token" }
└── Authorization: None required

POST /api/v1/auth/logout
├── Request:
│   ├── Headers: Authorization: Bearer {token}
│   └── Body: { "refresh_token": "..." }
├── Response:
│   └── 204: No Content
└── Authorization: Valid JWT token
```

#### Contract Management Endpoints
```
GET /api/v1/contracts
├── Request:
│   ├── Headers: Authorization: Bearer {token}
│   ├── Query params: 
│   │     ?status=active,pending
│   │     &artist_id=660e8400-e29b-41d4-a716-446655440001
│   │     &cursor=eyJpZCI6IjEyMzQ1Njc4OTAifQ
│   │     &limit=20
│   └── Validation: Valid status values, UUID format
├── Response:
│   ├── 200: {
│   │     "data": [
│   │       {
│   │         "id": "770e8400-e29b-41d4-a716-446655440002",
│   │         "title": "2024 Season Performance Contract",
│   │         "status": "pending",
│   │         "created_at": "2024-01-15T10:30:00Z",
│   │         "assignments": [...]
│   │       }
│   │     ],
│   │     "pagination": {
│   │       "next_cursor": "eyJpZCI6IjEyMzQ1Njc4OTEifQ",
│   │       "has_more": true
│   │     }
│   │   }
│   ├── 401: { "type": "unauthorized" }
│   └── 403: { "type": "forbidden" }
└── Authorization: Valid JWT token

POST /api/v1/contracts
├── Request:
│   ├── Headers: 
│   │     Authorization: Bearer {token}
│   │     Content-Type: multipart/form-data
│   ├── Body: 
│   │     file: (binary)
│   │     title: "2024 Season Performance Contract"
│   │     description: "Standard performance agreement"
│   │     metadata: { "season": "2024", "type": "performance" }
│   └── Validation: File type (PDF/DOCX), size < 50MB
├── Response:
│   ├── 201: {
│   │     "id": "880e8400-e29b-41d4-a716-446655440003",
│   │     "title": "2024 Season Performance Contract",
│   │     "document_url": "https://storage.biglive.com/contracts/880e8400.pdf",
│   │     "status": "draft"
│   │   }
│   ├── 400: { "type": "invalid_file_type" }
│   └── 413: { "type": "file_too_large", "max_size": 52428800 }
└── Authorization: Admin role required

POST /api/v1/contracts/{id}/assign
├── Request:
│   ├── Headers: 
│   │     Authorization: Bearer {token}
│   │     Content-Type: application/json
│   ├── Body: {
│   │     "artist_ids": ["660e8400-e29b-41d4-a716-446655440001"],
│   │     "message": "Please review and sign by January 31st",
│   │     "send_notification": true
│   │   }
│   └── Validation: Contract exists, artists exist, not already assigned
├── Response:
│   ├── 200: {
│   │     "assignments": [{
│   │       "id": "990e8400-e29b-41d4-a716-446655440004",
│   │       "artist_id": "660e8400-e29b-41d4-a716-446655440001",
│   │       "status": "sent",
│   │       "sent_at": "2024-01-15T11:00:00Z"
│   │     }]
│   │   }
│   └── 404: { "type": "contract_not_found" }
└── Authorization: Admin role required

POST /api/v1/contracts/{id}/sign
├── Request:
│   ├── Headers: Authorization: Bearer {token}
│   └── Body: { "signature_request_id": "docusign_request_123" }
├── Response:
│   ├── 200: {
│   │     "signature_url": "https://docusign.com/embed/sign/...",
│   │     "expires_at": "2024-01-15T12:00:00Z"
│   │   }
│   └── 403: { "type": "not_assigned_to_user" }
└── Authorization: Artist with assignment
```

#### Expense Management Endpoints
```
POST /api/v1/expenses
├── Request:
│   ├── Headers: 
│   │     Authorization: Bearer {token}
│   │     Content-Type: application/json
│   ├── Body: {
│   │     "amount": 125.50,
│   │     "currency": "USD",
│   │     "category_id": "aa0e8400-e29b-41d4-a716-446655440005",
│   │     "merchant": "Yellow Cab Co",
│   │     "description": "Taxi to venue",
│   │     "expense_date": "2024-01-14",
│   │     "notes": "Late night rehearsal"
│   │   }
│   └── Validation: Amount > 0, valid category, date not future
├── Response:
│   ├── 201: {
│   │     "id": "bb0e8400-e29b-41d4-a716-446655440006",
│   │     "amount": 125.50,
│   │     "status": "draft",
│   │     "created_at": "2024-01-15T10:00:00Z"
│   │   }
│   └── 400: { "type": "invalid_category" }
└── Authorization: Artist role

POST /api/v1/expenses/{id}/receipts
├── Request:
│   ├── Headers: 
│   │     Authorization: Bearer {token}
│   │     Content-Type: multipart/form-data
│   ├── Body: 
│   │     file: (binary image)
│   └── Validation: Image format (JPG/PNG/HEIC), size < 10MB
├── Response:
│   ├── 201: {
│   │     "id": "cc0e8400-e29b-41d4-a716-446655440007",
│   │     "file_url": "https://storage.biglive.com/receipts/cc0e8400.jpg",
│   │     "thumbnail_url": "https://storage.biglive.com/receipts/cc0e8400_thumb.jpg",
│   │     "ocr_extracted_amount": 125.50
│   │   }
│   └── 413: { "type": "file_too_large" }
└── Authorization: Expense owner

POST /api/v1/expenses/{id}/submit
├── Request:
│   ├── Headers: Authorization: Bearer {token}
│   └── Body: {} (empty)
├── Response:
│   ├── 200: {
│   │     "id": "bb0e8400-e29b-41d4-a716-446655440006",
│   │     "status": "submitted",
│   │     "submitted_at": "2024-01-15T11:00:00Z"
│   │   }
│   └── 400: { "type": "missing_receipts" }
└── Authorization: Expense owner

POST /api/v1/expenses/{id}/approve
├── Request:
│   ├── Headers: 
│   │     Authorization: Bearer {token}
│   │     Content-Type: application/json
│   └── Body: { "notes": "Approved for reimbursement" }
├── Response:
│   ├── 200: {
│   │     "id": "bb0e8400-e29b-41d4-a716-446655440006",
│   │     "status": "approved",
│   │     "approved_at": "2024-01-15T14:00:00Z",
│   │     "approved_by": "dd0e8400-e29b-41d4-a716-446655440008"
│   │   }
│   └── 403: { "type": "insufficient_approval_limit" }
└── Authorization: Accountant or Finance Director role
```

#### Schedule Management Endpoints
```
GET /api/v1/events
├── Request:
│   ├── Headers: Authorization: Bearer {token}
│   ├── Query params: 
│   │     ?start_date=2024-01-15
│   │     &end_date=2024-01-31
│   │     &type=rehearsal,performance
│   │     &timezone=America/New_York
│   └── Validation: Valid date range, known timezone
├── Response:
│   ├── 200: {
│   │     "data": [{
│   │       "id": "ee0e8400-e29b-41d4-a716-446655440009",
│   │       "title": "Swan Lake Rehearsal",
│   │       "type": "rehearsal",
│   │       "start_datetime": "2024-01-16T14:00:00-05:00",
│   │       "end_datetime": "2024-01-16T17:00:00-05:00",
│   │       "location": {
│   │         "name": "Lincoln Center Studio 3",
│   │         "address": "10 Lincoln Center Plaza, New York, NY",
│   │         "coordinates": { "lat": 40.7725, "lng": -73.9835 }
│   │       },
│   │       "participants": [...]
│   │     }]
│   │   }
│   └── 401: { "type": "unauthorized" }
└── Authorization: Valid JWT token

POST /api/v1/events/{id}/acknowledge
├── Request:
│   ├── Headers: 
│   │     Authorization: Bearer {token}
│   │     Content-Type: application/json
│   └── Body: { "note": "Confirmed attendance" }
├── Response:
│   ├── 200: {
│   │     "acknowledged_at": "2024-01-15T16:00:00Z",
│   │     "status": "confirmed"
│   │   }
│   └── 404: { "type": "event_not_found" }
└── Authorization: Event participant

GET /api/v1/events/export
├── Request:
│   ├── Headers: 
│   │     Authorization: Bearer {token}
│   │     Accept: text/calendar
│   └── Query params: ?format=ical
├── Response:
│   ├── 200: (iCalendar format data)
│   │     BEGIN:VCALENDAR
│   │     VERSION:2.0
│   │     PRODID:-//BIG Live Portal//EN
│   │     ...
│   └── 406: { "type": "unsupported_format" }
└── Authorization: Valid JWT token
```

### API Standards
- **Request/Response Format**: 
  - JSON with camelCase field names
  - UTF-8 encoding
  - ISO 8601 datetime format
  - UUID v4 for identifiers
- **HTTP Status Codes**: 
  - 200 OK - Successful GET/PUT
  - 201 Created - Successful POST
  - 204 No Content - Successful DELETE
  - 400 Bad Request - Validation errors
  - 401 Unauthorized - Missing/invalid auth
  - 403 Forbidden - Insufficient permissions
  - 404 Not Found - Resource doesn't exist
  - 429 Too Many Requests - Rate limited
  - 500 Internal Server Error - Server fault
- **Error Responses**: 
  ```json
  {
    "type": "validation_error",
    "title": "Invalid request data",
    "status": 400,
    "detail": "The request contains invalid fields",
    "instance": "/api/v1/expenses",
    "errors": [
      {
        "field": "amount",
        "message": "Amount must be greater than 0"
      }
    ]
  }
  ```
- **Pagination**: 
  ```json
  {
    "data": [...],
    "pagination": {
      "cursor": "eyJpZCI6IjEyMzQ1Njc4OTAifQ",
      "next_cursor": "eyJpZCI6IjEyMzQ1Njc4OTEifQ",
      "has_more": true,
      "total_count": 150
    }
  }
  ```
- **Filtering**: 
  - Field selection: `?fields=id,title,status`
  - Equality: `?status=active`
  - In: `?status=active,pending`
  - Range: `?created_after=2024-01-01&created_before=2024-01-31`
  - Search: `?q=swan+lake`
- **Rate Limiting**: 
  - Default: 1000 requests/hour per user
  - Uploads: 100 requests/hour
  - Auth endpoints: 5 requests/minute
  - Headers:
    - X-RateLimit-Limit: 1000
    - X-RateLimit-Remaining: 950
    - X-RateLimit-Reset: 1642339200

## Technical Risks & Mitigation

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| SharePoint API complexity delays integration | High | High | Create abstraction layer with mock implementation, engage Microsoft support early, implement circuit breaker pattern for failures |
| Mobile browser camera API inconsistencies | Medium | High | Progressive enhancement approach, fallback to file picker, extensive device testing matrix, consider native app wrapper |
| E-signature service downtime affects operations | High | Low | Support multiple providers (DocuSign + Adobe Sign), implement queue for retry, manual signature upload fallback |
| Data migration errors during onboarding | High | Medium | Comprehensive validation suite, dry-run capability, incremental migration with rollback, dedicated onboarding team |
| Xero rate limits impact financial sync | Medium | Medium | Implement intelligent batching, off-peak scheduling, webhook-based updates instead of polling |
| Offline functionality complexity | Medium | High | Phased approach starting with read-only, conflict resolution strategy, clear sync status indicators |
| GDPR compliance for international artists | High | Low | Data residency options, consent management system, regular compliance audits, DPO consultation |
| Performance degradation at scale | High | Medium | Comprehensive performance testing, database query optimization, caching strategy, auto-scaling policies |

## Performance & Scalability

### Performance Requirements
Based on performance targets from APP_DETAILS and scale requirements, the system must maintain responsiveness under significant load.

#### Response Time Targets
- **API Endpoints**: 
  - Authentication: < 200ms (critical path)
  - Data retrieval: < 300ms for lists
  - File upload initiation: < 100ms
  - Search operations: < 500ms with highlighting
- **Database Queries**: 
  - Index-supported queries: < 50ms
  - Complex aggregations: < 200ms
  - Full-text search: < 100ms
  - Bulk operations: < 10ms per record
- **Page Load Times**: 
  - First Contentful Paint: < 1.2 seconds
  - Time to Interactive: < 2.5 seconds
  - Subsequent navigation: < 500ms
  - Offline mode activation: < 100ms
- **Interactive Elements**: 
  - Button feedback: < 50ms
  - Form validation: < 100ms
  - Autocomplete suggestions: < 200ms
  - Modal transitions: < 300ms

#### Scalability Targets
- **Concurrent Users**: 
  - Year 1: 250 concurrent (500-2,500 total)
  - Year 3: 5,000 concurrent (10,000-50,000 total)
  - Peak factor: 10x during performance seasons
  - Geographic distribution across 4+ timezones
- **Request Volume**: 
  - Sustained: 1,000 requests/second
  - Peak: 5,000 requests/second
  - Upload traffic: 100 concurrent uploads
  - WebSocket connections: 5,000 simultaneous
- **Data Growth**: 
  - Documents: 50,000 initial → 500,000 by year 3
  - Storage: 100GB initial → 5TB by year 3
  - Database records: 1M initial → 50M by year 3
  - Audit logs: 10M entries/year
- **Geographic Distribution**: 
  - Primary region: US East
  - Secondary region: US West
  - CDN: Global presence (50+ PoPs)
  - Database replication: Cross-region

### Caching Strategy
Multi-layered caching approach to minimize latency and reduce backend load.

- **Browser Cache**: 
  - Static assets: 1 year with fingerprinting
  - API responses: 5 minutes for lists, 1 minute for details
  - User preferences: localStorage with encryption
  - Offline data: IndexedDB with 100MB quota
- **CDN Cache**: 
  - Images: 30 days with automatic WebP conversion
  - Documents: 7 days with version-based invalidation
  - JavaScript/CSS: Immutable with hash-based names
  - API responses: 60 seconds at edge locations
- **Application Cache**: 
  - User sessions: 30-minute sliding window in Redis
  - Permission matrix: 15 minutes with lazy refresh
  - Frequently accessed data: 5-60 minutes based on volatility
  - Computed aggregations: 1 hour with background refresh
- **Database Cache**: 
  - Query plan cache: Per connection lifetime
  - Result cache: 60 seconds for repeated queries
  - Materialized views: Daily refresh for reports
  - Connection pool: 100 connections with 30-second timeout

### Database Optimization
Strategic optimizations for sub-100ms query performance at scale.

- **Indexing Strategy**: 
  ```sql
  -- Composite indexes for common queries
  CREATE INDEX idx_contracts_org_status_date 
    ON contracts(organization_id, status, created_at DESC);
  
  CREATE INDEX idx_expenses_artist_status_date 
    ON expenses(artist_id, status, expense_date DESC);
  
  -- Partial indexes for active records
  CREATE INDEX idx_active_contracts 
    ON contracts(organization_id, created_at) 
    WHERE status IN ('pending', 'active');
  
  -- GIN indexes for full-text search
  CREATE INDEX idx_contracts_search 
    ON contracts USING gin(
      to_tsvector('english', title || ' ' || COALESCE(description, ''))
    );
  ```
- **Query Optimization**: 
  - Use of prepared statements for all queries
  - Batch operations for bulk updates
  - Cursor-based pagination instead of OFFSET
  - Query result streaming for large datasets
- **Connection Pooling**: 
  - PgBouncer in transaction mode
  - Pool size: 100 connections
  - Overflow: 20 additional connections
  - Health checks every 30 seconds
- **Read Replicas**: 
  - 2 read replicas for load distribution
  - Automatic failover in < 30 seconds
  - Read preference routing by query type
  - Eventual consistency handling

### Frontend Performance
Optimizations for fast, responsive user experience on all devices.

- **Code Splitting**: 
  ```typescript
  // Route-based splitting
  const ContractDashboard = lazy(() => 
    import(/* webpackChunkName: "contracts" */ './features/contracts/Dashboard')
  );
  
  // Feature-based splitting
  const ExpenseCapture = lazy(() => 
    import(/* webpackChunkName: "expense-capture" */ './features/expenses/Capture')
  );
  ```
- **Asset Optimization**: 
  - Image lazy loading with intersection observer
  - WebP with JPEG fallback
  - Responsive images with srcset
  - SVG sprites for icons
- **Critical Path**: 
  - Inline critical CSS (< 14KB)
  - Preload key fonts and resources
  - DNS prefetch for external domains
  - Prioritize above-fold content
- **Service Workers**: 
  - Offline-first for core features
  - Background sync for uploads
  - Push notification support
  - Cache strategies per resource type

## Deployment & Infrastructure

### Infrastructure Architecture
Cloud-native architecture optimized for performing arts workload patterns and SharePoint integration.

#### Cloud Infrastructure
- **Cloud Provider**: 
  - Primary: Microsoft Azure (SharePoint proximity)
  - Multi-region deployment: East US (primary), West US (DR)
  - Azure AD integration for enterprise SSO
  - Reserved instances for cost optimization
- **Compute Resources**: 
  - Production: Azure App Service Premium v3
  - API servers: 4x P2v3 (4 vCPU, 16GB RAM)
  - Background workers: 2x P1v3 (2 vCPU, 8GB RAM)
  - Auto-scaling: 2-8 instances based on metrics
- **Storage Solutions**: 
  - Database: Azure Database for PostgreSQL Flexible Server
  - File storage: Azure Blob Storage with lifecycle policies
  - Cache: Azure Cache for Redis Premium
  - Backups: Geo-redundant storage with 7-year retention
- **Network Configuration**: 
  - Hub-spoke VNet architecture
  - Application Gateway with WAF
  - Private endpoints for PaaS services
  - ExpressRoute for SharePoint connectivity

#### Environment Strategy
- **Development**: 
  - Local Docker Compose setup
  - Shared dev database with tenant isolation
  - Feature branch deployments
  - Integration sandbox accounts
- **Staging**: 
  - Production-like infrastructure at 50% scale
  - Anonymized production data refresh weekly
  - Full integration connections
  - Performance testing environment
- **Production**: 
  - Blue-green deployment slots
  - Multi-region active-passive setup
  - 99.9% SLA with automatic failover
  - Real-time monitoring and alerting
- **Disaster Recovery**: 
  - RPO: 1 hour for data
  - RTO: 4 hours for full recovery
  - Automated backup testing
  - Quarterly DR drills

### CI/CD Pipeline
```yaml
# Azure DevOps Pipeline
trigger:
  branches:
    include: [main, develop]
  paths:
    exclude: [docs/*, README.md]

stages:
  - stage: Build
    jobs:
      - job: BuildTest
        pool:
          vmImage: 'ubuntu-latest'
        steps:
          - task: NodeTool@0
            inputs:
              versionSpec: '20.x'
          
          - script: |
              npm ci
              npm run build
              npm run test:ci
            displayName: 'Build and Test'
          
          - task: SonarQubePrepare@5
            inputs:
              SonarQube: 'SonarQube'
              scannerMode: 'CLI'
          
          - task: SonarQubeAnalyze@5
          
          - task: Docker@2
            inputs:
              command: 'buildAndPush'
              containerRegistry: 'ACR'
              repository: 'bigliveportal/api'
              tags: |
                $(Build.BuildId)
                latest

  - stage: SecurityScan
    jobs:
      - job: Security
        steps:
          - task: ContainerScan@0
            inputs:
              image: 'bigliveportal/api:$(Build.BuildId)'
          
          - task: CredScan@3
          
          - task: Trivy@1
            inputs:
              image: 'bigliveportal/api:$(Build.BuildId)'
              severityThreshold: 'HIGH'

  - stage: DeployStaging
    dependsOn: [Build, SecurityScan]
    condition: succeeded()
    jobs:
      - deployment: DeployToStaging
        environment: 'staging'
        strategy:
          runOnce:
            deploy:
              steps:
                - task: AzureRmWebAppDeployment@4
                  inputs:
                    appType: 'webAppContainer'
                    WebAppName: 'biglive-staging'
                    DockerNamespace: 'bigliveportal'
                    DockerRepository: 'api'
                    DockerImageTag: '$(Build.BuildId)'
                
                - task: AzureCLI@2
                  inputs:
                    scriptType: 'bash'
                    scriptLocation: 'inlineScript'
                    inlineScript: |
                      az webapp config appsettings set \
                        --name biglive-staging \
                        --resource-group biglive-rg \
                        --settings BUILD_VERSION=$(Build.BuildId)

  - stage: IntegrationTests
    dependsOn: DeployStaging
    jobs:
      - job: RunTests
        steps:
          - script: |
              npm run test:integration -- --env=staging
              npm run test:e2e -- --env=staging
            displayName: 'Run Integration Tests'

  - stage: DeployProduction
    dependsOn: IntegrationTests
    condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
    jobs:
      - deployment: DeployToProduction
        environment: 'production'
        strategy:
          blueGreen:
            deploy:
              steps:
                - task: AzureRmWebAppDeployment@4
                  inputs:
                    appType: 'webAppContainer'
                    WebAppName: 'biglive-prod'
                    deployToSlotOrASE: true
                    slotName: 'staging'
                    DockerImageTag: '$(Build.BuildId)'
            
            routeTraffic:
              steps:
                - task: AzureAppServiceManage@0
                  inputs:
                    action: 'Start Azure App Service'
                    WebAppName: 'biglive-prod'
                    slotName: 'staging'
                
                - script: npm run test:smoke -- --env=production-staging
                  displayName: 'Smoke Tests'
                
                - task: AzureAppServiceManage@0
                  inputs:
                    action: 'Swap Slots'
                    WebAppName: 'biglive-prod'
                    sourceSlot: 'staging'
                    targetSlot: 'production'
            
            postRouteTraffic:
              steps:
                - script: npm run monitor -- --duration=10m
                  displayName: 'Monitor Health'
                
                - task: CreateWorkItem@1
                  condition: failed()
                  inputs:
                    workItemType: 'Bug'
                    title: 'Production deployment failed'
```

### Monitoring & Observability
- **Application Monitoring**: 
  - Azure Application Insights with custom events
  - Real User Monitoring (RUM) for frontend
  - Distributed tracing across services
  - Custom business metrics dashboards
- **Infrastructure Monitoring**: 
  - Azure Monitor for resource metrics
  - Log Analytics workspace for centralized logs
  - Network Watcher for connectivity
  - Cost Management alerts
- **Log Aggregation**: 
  - Structured logging with correlation IDs
  - Log retention: 90 days hot, 2 years cold
  - Real-time log streaming for debugging
  - SIEM integration for security events
- **Error Tracking**: 
  - Sentry integration for exception tracking
  - Error grouping and deduplication
  - User impact analysis
  - Automated ticket creation for critical errors
- **User Analytics**: 
  - Privacy-preserving analytics
  - Feature usage tracking
  - Performance metrics by user segment
  - A/B testing framework

## Third-Party Dependencies

### External Services
Critical integrations that enable core platform functionality.

#### Required Integrations
- **SharePoint Integration**: 
  - Microsoft Graph API v1.0 for document operations
  - OAuth 2.0 with admin consent flow
  - Webhook subscriptions for real-time updates
  - Batch API for bulk operations
  - Delta query for efficient synchronization
- **Xero Integration**: 
  - Xero API v2.0 for accounting operations
  - OAuth 2.0 with offline_access scope
  - Webhook endpoints for payment status
  - Batch creation of bills/expenses
  - Attachment API for receipt upload
- **DocuSign Integration**: 
  - DocuSign eSignature REST API v2.1
  - Embedded signing with iFrame integration
  - Connect webhooks for status updates
  - Template management for standard contracts
  - Bulk send for multiple recipients
- **SendGrid Integration**: 
  - SendGrid API v3 for transactional email
  - Dynamic template management
  - Email activity webhooks
  - Suppression list management
  - IP warming for deliverability
- **Twilio Integration**: 
  - Twilio SMS API for notifications
  - Programmable messaging with templates
  - Delivery status callbacks
  - International number support
  - Opt-out management

#### Service Level Agreements
- **Uptime Requirements**: 
  - SharePoint: 99.9% (Microsoft SLA)
  - Xero: 99.5% (published SLA)
  - DocuSign: 99.9% (Enterprise SLA)
  - SendGrid: 99.95% (Pro plan)
  - Twilio: 99.95% (Enterprise)
- **Response Time**: 
  - SharePoint Graph: < 1s typical
  - Xero API: < 2s for most operations
  - DocuSign: < 3s for envelope creation
  - SendGrid: < 500ms for send
  - Twilio: < 1s for SMS dispatch
- **Data Privacy**: 
  - All services GDPR compliant
  - Data residency options available
  - Encryption in transit and at rest
  - Right to deletion supported
  - Audit logs maintained
- **Backup Plans**: 
  - SharePoint: Local document cache
  - Xero: Queue for later sync
  - DocuSign: Adobe Sign as backup
  - SendGrid: AWS SES fallback
  - Twilio: Alternative SMS provider

## Quality Assurance

### Testing Strategy
Comprehensive testing approach ensuring reliability and performance across all user scenarios.

#### Testing Levels
- **Unit Testing**: 
  - Jest for JavaScript/TypeScript
  - 85% coverage minimum
  - Isolated component testing
  - Mock all external dependencies
  - Snapshot testing for UI components
- **Integration Testing**: 
  - API endpoint testing with Supertest
  - Database integration with test containers
  - External service mocking with WireMock
  - Message queue testing
  - Authentication flow validation
- **End-to-End Testing**: 
  - Playwright for cross-browser testing
  - Critical user journeys
  - Mobile device testing
  - Performance assertions
  - Visual regression testing
- **Performance Testing**: 
  - k6 for load testing
  - Lighthouse CI for frontend
  - Database query profiling
  - Memory leak detection
  - Stress testing at 2x capacity
- **Security Testing**: 
  - OWASP ZAP scanning
  - Dependency vulnerability scanning
  - Penetration testing quarterly
  - Code security analysis
  - Authentication bypass attempts

#### Test Automation
- **Continuous Testing**: 
  - Pre-commit hooks for linting
  - Unit tests on every commit
  - Integration tests on PR
  - E2E tests before deployment
  - Performance tests weekly
- **Test Data Management**: 
  - Faker.js for synthetic data
  - Anonymized production snapshots
  - Test data cleanup jobs
  - Isolated test tenants
  - Predictable seed data
- **Cross-Browser Testing**: 
  - Chrome, Safari, Firefox, Edge latest
  - Mobile Safari and Chrome
  - Responsive design validation
  - Progressive enhancement testing
  - Accessibility testing with axe
- **Mobile Testing**: 
  - Real device testing lab
  - iOS 13+ and Android 8+
  - Network condition simulation
  - Offline mode validation
  - Camera API testing

### Code Quality
- **Code Reviews**: 
  - Mandatory PR reviews
  - Two approvals for production
  - Automated style checking
  - Security-focused reviews
  - Performance impact assessment
- **Static Analysis**: 
  - ESLint with strict rules
  - TypeScript strict mode
  - SonarQube quality gates
  - Complexity metrics
  - Code duplication detection
- **Documentation**: 
  - JSDoc for all public APIs
  - README for each module
  - Architecture decision records
  - API documentation with examples
  - Runbook for operations
- **Coding Standards**: 
  - Airbnb JavaScript style guide
  - Functional programming patterns
  - SOLID principles
  - Error handling standards
  - Logging conventions

## Risk Assessment

### Technical Risks
| Risk | Probability | Impact | Mitigation Strategy |
|------|-------------|--------|-------------------|
| SharePoint API rate limits | High | High | Request batching, caching layer, exponential backoff, negotiate higher limits |
| Database performance at scale | Medium | High | Query optimization, read replicas, connection pooling, vertical scaling option |
| Mobile browser incompatibilities | High | Medium | Progressive enhancement, feature detection, fallback options, extensive testing |
| Real-time sync conflicts | Medium | Medium | Operational transformation, conflict resolution UI, audit trail, user notifications |
| Third-party service outages | Low | High | Circuit breakers, graceful degradation, status page, alternative providers |
| Security breach | Low | High | Defense in depth, regular audits, incident response plan, cyber insurance |
| Technology obsolescence | Medium | Medium | Modular architecture, regular updates, technology radar, skilled team |

### Operational Risks
| Risk | Probability | Impact | Mitigation Strategy |
|------|-------------|--------|-------------------|
| Peak season load spikes | High | Medium | Auto-scaling, performance testing, CDN optimization, capacity planning |
| Data loss | Low | High | Multiple backup strategies, point-in-time recovery, disaster recovery drills |
| Compliance violations | Low | High | Regular audits, automated compliance checks, training, legal counsel |
| Key person dependency | Medium | Medium | Documentation, knowledge sharing, cross-training, vendor support |
| Integration partner changes | Medium | Medium | Abstraction layers, version pinning, change monitoring, contracts |

## Future Considerations

### Scalability Roadmap
- **Phase 1 (Months 1-6)**: 
  - Core features for 50 organizations
  - Single region deployment
  - Manual scaling procedures
  - Basic monitoring
- **Phase 2 (Months 7-12)**: 
  - Auto-scaling implementation
  - Multi-region deployment
  - Advanced caching strategies
  - Performance optimization
- **Phase 3 (Year 2)**: 
  - Microservices architecture
  - Global edge deployment
  - AI-powered features
  - Native mobile apps

### Technology Evolution
- **Framework Updates**: 
  - React 19 migration plan
  - Node.js LTS upgrades
  - Database version updates
  - Security patch automation
- **Feature Extensibility**: 
  - Plugin architecture design
  - Webhook system for integrations
  - Custom workflow engine
  - API marketplace
- **Platform Expansion**: 
  - iOS/Android native apps
  - Apple Watch complications
  - Voice assistant integration
  - AR venue navigation

### Maintenance & Support
- **Documentation Updates**: 
  - Automated API doc generation
  - Video tutorial creation
  - FAQ maintenance
  - Release notes automation
- **Knowledge Transfer**: 
  - Onboarding program
  - Internal tech talks
  - External training budget
  - Mentorship program
- **Legacy System Migration**: 
  - Gradual feature parity
  - Data migration tools
  - Dual-run period
  - Sunset planning

## Critical Questions and Clarifications

1. **Multi-Organization Architecture**: Should the system support artists working with multiple organizations simultaneously? This would require significant changes to the authentication model and data isolation strategy, potentially implementing a workspace switcher similar to Slack.

2. **Expense Approval Complexity**: What level of customization is needed for approval workflows? Should organizations be able to create complex multi-level approval chains based on amount thresholds, expense categories, or reporting hierarchies? This would impact the workflow engine design.

3. **Real-time Notification Requirements**: Do schedule updates and notifications require true real-time delivery (sub-second) via WebSocket, or would near-real-time (1-5 seconds) with polling be acceptable? This significantly affects infrastructure complexity and costs.

4. **Offline Functionality Scope**: Beyond viewing contracts and drafting expenses, which specific features must work offline? Full offline support including schedule modifications and expense approvals would require sophisticated conflict resolution mechanisms.

5. **SharePoint Integration Depth**: Will the platform require deep SharePoint integration beyond document storage, such as metadata synchronization, permission inheritance, or workflow triggers? This could significantly impact the integration timeline and require additional Microsoft Graph API scopes.

6. **E-Signature Provider Priority**: Between DocuSign and Adobe Sign, which provides better API stability, pricing, and features specific to performing arts contracts? Should the system abstract the integration to support both providers for redundancy?

7. **Data Retention Automation**: With 7-year contract retention requirements and varying retention for other data types, should the system implement automatic archival to cold storage with retrieval capabilities, or maintain all data in the primary database?

8. **Performance Season Handling**: With 3x traffic during performance seasons and 10x document activity during contract periods, should the infrastructure pre-scale for known peak periods, or rely entirely on auto-scaling? This affects cost optimization strategies.

9. **Compliance Audit Detail**: What specific level of audit logging is required for SOC 2 Type II compliance? Should the system log all data access including reads, or only modification events? This impacts database performance and storage requirements.

10. **Multi-Currency Support**: While the MVP specifies USD, international touring artists may have expenses in multiple currencies. Should the system include real-time currency conversion and multi-currency reporting from the start, or defer this to Phase 2?