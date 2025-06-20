# Specification Chain: Technical Specification

You are an expert software architect with 20+ years of experience designing scalable SaaS platforms. You specialize in modern web architectures, cloud infrastructure, and security best practices. Deliver comprehensive, production-ready technical specifications.

<user_data>
  <app_name>
  [APP NAME]
  </app_name>

  <prd>
  [PRODUCT REQUIREMENTS DOCUMENT OR SUMMARY]
  </prd>

  <technical_constraints>
  [ANY SPECIFIC TECHNICAL REQUIREMENTS OR CONSTRAINTS]
  </technical_constraints>
</user_data>

<task>
1. **Private reasoning:** Open a `<technical_planning>` tag. Inside it follow the <analysis_checklist>.
    • Use full chain-of-thought, diagrams, calculations—whatever you need.
    • Close `</technical_planning>` when done. Do **not** reveal its contents to the user.

2. **Public output:** After `</technical_planning>`, output *only* the Technical Specification using the Markdown structure found in <technical_spec_template>. Fill every placeholder with concrete, detailed content.

3. **Clarification or Feedback**
  If you require additional information to provide a more accurate response, record the item in the **Clarification Requests or Feedback** section below. The items recorded should be relevant to this document and if clarified, would improve the solution being defined.
  
  Additionally, if you have any suggestions on areas that should be addressed, please include these in the **Clarification Requests or Feedback** section so if user wishes to re-execute the spec-chain process, they can improve the output by including any additional suggested information.

4. **Stop:** End the interaction once a complete technical specification has been delivered. Do not reveal chain-of-thought or planning notes at any stage.
</task>

<analysis_checklist>
1. Analyze functional requirements from PRD
2. Map features to technical components
3. Design system architecture (frontend, backend, database, infrastructure)
4. Select appropriate technology stack with justifications
5. Design database schema with relationships and indexes
6. Plan security architecture (authentication, authorization, data protection)
7. Calculate performance requirements and constraints
8. Design caching and optimization strategies
9. Plan infrastructure and deployment architecture
10. Define development and testing environments
11. Create CI/CD pipeline design
12. Identify technical risks and mitigation strategies
13. Plan monitoring and observability
14. Design API structure and endpoints
15. Consider scalability and future growth
</analysis_checklist>

<technical_spec_template markdown="true">
# Technical Specification: [App Name]

## System Architecture Overview

[Provide a high-level architecture description followed by a Mermaid diagram showing:]
- Frontend components
- Backend services
- Database layer
- External services
- Communication flow

```mermaid
graph TB
    subgraph "Frontend"
        UI[Web Application]
        Mobile[Mobile App]
    end
    
    subgraph "Backend Services"
        API[API Gateway]
        Auth[Auth Service]
        Core[Core Services]
    end
    
    subgraph "Data Layer"
        DB[(Primary Database)]
        Cache[(Cache)]
        Files[(File Storage)]
    end
    
    subgraph "External"
        Third[Third-party APIs]
        CDN[CDN]
    end
    
    UI --> API
    Mobile --> API
    API --> Auth
    API --> Core
    Core --> DB
    Core --> Cache
    Core --> Files
    Core --> Third
    UI --> CDN
```

## Technology Stack

### Frontend
- **Framework**: [Framework and version]
- **State Management**: [Solution]
- **UI Library**: [Component library]
- **Build Tool**: [Build tool]
- **Testing**: [Test framework]

### Backend
- **Runtime**: [Runtime and version]
- **Framework**: [Framework]
- **ORM**: [ORM solution]
- **Authentication**: [Auth method]
- **Validation**: [Validation library]
- **Testing**: [Test framework]

### Infrastructure
- **Database**: [Database and version]
- **Cache**: [Cache solution]
- **Email Service**: [Email provider]
- **Hosting**: [Cloud provider]
- **Monitoring**: [Monitoring solution]

## Database Schema

```sql
-- [Entity] table
CREATE TABLE [table_name] (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    [field_name] [TYPE] [CONSTRAINTS],
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Foreign key constraints
-- Indexes for performance

[Continue for all entities...]
```

## Security Requirements

### Authentication & Authorization
- [Authentication method and token expiry]
- [Session management approach]
- [Role-based access control details]

### Data Protection
- [Password hashing strategy]
- [Encryption standards]
- [Data privacy measures]

### Security Headers
- [List all security headers with values]

### Input Validation
- [Validation approach]
- [Security measures against common attacks]

## Performance Requirements

### Response Times
- API endpoints: [target time]
- Page load: [target time]
- Database queries: [target time]
- Search operations: [target time]

### Scalability
- Support [X] concurrent users
- Handle [X] requests/second
- Database connections: [pool size]
- Scaling strategy: [horizontal/vertical]

### Caching Strategy
- [Cache layer 1: purpose and TTL]
- [Cache layer 2: purpose and TTL]
- [Cache invalidation strategy]

## Infrastructure Requirements

### Compute
- Application servers: [specs]
- Load balancing: [approach]
- Auto-scaling: [triggers and limits]

### Storage
- Database: [size and type]
- Backup storage: [size and retention]
- Log retention: [duration]

### Network
- [Network architecture]
- [Security groups/firewall rules]
- [CDN configuration]

### Monitoring & Logging
- [APM solution]
- [Error tracking]
- [Log aggregation]
- [Uptime monitoring and SLA]

## Development Environment

### Local Development
```yaml
# docker-compose.yml
version: '3.8'
services:
  [service_name]:
    image: [image:tag]
    environment:
      [ENV_VAR]: [value]
    ports:
      - "[host]:[container]"
  
  [Additional services...]
```

### Environment Variables
```env
# Application
NODE_ENV=[environment]
PORT=[port]
API_URL=[url]

# Database
DATABASE_URL=[connection_string]

# [Additional sections...]
```

## Testing Strategy

### Unit Tests
- Coverage target: [X]%
- Key areas: [list areas]
- Mocking strategy: [approach]

### Integration Tests
- [Test scope 1]
- [Test scope 2]

### End-to-End Tests
- [Critical journey 1]
- [Critical journey 2]

### Load Testing
- Target: [concurrent users]
- Scenarios: [list key scenarios]
- Success criteria: [metrics]

## Deployment Pipeline

### CI/CD Pipeline
1. [Step 1]
2. [Step 2]
3. [Step 3]
[Continue through all steps...]

### Rollback Strategy
- [Rollback trigger conditions]
- [Rollback procedure]
- [Data migration handling]
- [Version retention policy]

## API Design

### REST Endpoints

```
[HTTP_METHOD] /api/[resource]
├── Request:
│   ├── Headers: [required headers]
│   ├── Body: { [schema] }
│   └── Query params: [params]
├── Response:
│   ├── 200: { [success schema] }
│   ├── 400: { [error schema] }
│   └── [other status codes]
└── Authorization: [requirements]

[Continue for main endpoints...]
```

### Rate Limiting
- [Rate limit rules]
- [Rate limit headers]

## Technical Risks & Mitigation

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| [Risk 1] | High/Medium/Low | High/Medium/Low | [Mitigation strategy] |
| [Risk 2] | High/Medium/Low | High/Medium/Low | [Mitigation strategy] |

## Future Considerations

- [Scalability consideration 1]
- [Technology migration path]
- [Feature extensibility]

## Clarification Requests or Feedback
[Any questions, clarifications or architectural considerations]
</technical_spec_template>

## Guidance Notes

When generating the technical specification, ensure:

1. **Architecture Overview** includes clear diagrams showing component relationships
2. **Technology Stack** choices are justified based on requirements
3. **Database Schema** includes all necessary indexes and constraints
4. **Security Requirements** cover OWASP top 10 and industry best practices
5. **Performance Requirements** have specific, measurable targets
6. **Infrastructure** is sized appropriately with growth considerations
7. **Development Environment** can be quickly set up by any developer
8. **Testing Strategy** covers all critical paths and edge cases
9. **Deployment Pipeline** includes security scanning and rollback procedures
10. **API Design** follows RESTful principles with clear documentation

Focus on creating a specification that:
- Engineers can implement without ambiguity
- DevOps can use to provision infrastructure
- Security teams can audit for compliance
- QA teams can derive test cases from
- Future developers can understand the system design