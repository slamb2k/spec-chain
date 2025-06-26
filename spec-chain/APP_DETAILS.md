# APP_DETAILS.md

This file contains the core information needed to generate comprehensive documentation for your application.
Fields marked as (REQUIRED) must be filled out. Fields marked as (OPTIONAL) can be left blank and will be auto-researched or use sensible defaults.

## Basic Information (REQUIRED)

**App Name:**
BIG Live Portal

**App Idea:**
BIG Live Portal is a browser-based web app designed for performing artists and administrators to manage contracts, expense claims, schedules, and communications. Artists log in using their personal email addresses and access personalized views of their contracts, schedules, and expense forms. Admins can manage users, upload documents, and monitor basic usage. The system integrates with SharePoint for document access and optionally with Xero/Hubdoc for finance workflows. Mobile responsiveness ensures usability across devices, with no dedicated app required. Internal staff maintain the platform without relying on external IT support.

**MVP Features:**
- **Login**: Personal email (not BL); roles: Artist, Admin, Accountant; SharePoint integration preferred; no 2FA.  
- **Contracts**: View, e-sign (MS/Adobe Sign), notify staff, optional versioning.  
- **Expenses**: Upload receipts, structured forms (date, amount, category, desc), submit for approval, Xero/Hubdoc integration (PDF/API).  
- **Schedule**: View-only (rehearsals, performances), announcements via bulletin/news feed, with email/SMS alerts.  
- **Mobile**: Fully responsive on iOS/Android; no app needed.  
- **Admin**: Manage users/docs/stats; maintained internally, no external IT required.

## Target Users (REQUIRED)

### Primary Users
- User type 1: Artists / Contractors - Performing artists who need to access contracts, submit expenses, and view schedules
- User type 2: Administrators / Internal Staff - Administrative personnel managing artist information, documents, and approvals
- User type 3: Accountants - Financial personnel who process expense claims and manage financial workflows

### Secondary Users (OPTIONAL)
- User type 4: Production Managers - Staff who coordinate schedules and manage venue/event logistics
- User type 5: Finance Directors - Senior staff who oversee financial operations and approve high-value expenses

## Business Context (OPTIONAL - will be auto-researched if not provided)

### Market Context
The performing arts management software market is experiencing significant growth, driven by digital transformation in the creative industries. The global market for arts and entertainment software is valued at approximately $42.8 billion (2023) and is expected to reach $67.2 billion by 2030, growing at a CAGR of 6.7%. Key trends include:
- Shift from paper-based to digital contract management
- Increased demand for mobile-accessible solutions for touring artists
- Integration of financial management with artistic operations
- Focus on reducing administrative overhead (currently 30-40% of operational costs)
- Growing need for real-time schedule updates and communication tools
The market opportunity is substantial, with over 5.2 million arts workers in the US alone, and thousands of performing arts organizations seeking efficient management solutions.

### Competition
Key competitors in the performing arts management space include:
1. **Gigwell** - Cloud-based booking and management platform for artists and venues. Strengths: Comprehensive booking features, strong venue network. Weaknesses: Complex interface, expensive for smaller organizations ($149-599/month).
2. **Prism.fm** - Artist management software with tour planning and financial tracking. Strengths: Robust financial features, mobile app. Weaknesses: Limited contract management, steep learning curve.
3. **Theatre Manager** - Comprehensive venue and company management system. Strengths: Full box office integration, donor management. Weaknesses: Desktop-focused, requires IT expertise, high cost ($5,000+ setup).
4. **Arts People** - Web-based system for theaters and performing arts organizations. Strengths: Affordable, good for small organizations. Weaknesses: Limited mobile functionality, basic expense tracking.
5. **Square 9** - Document management with some arts-specific features. Strengths: Strong document handling, workflow automation. Weaknesses: Not arts-specific, requires customization, limited artist-facing features.

### Business Model
**Primary Revenue Model**: SaaS Subscription
- **Artist Tier** ($99/month): Up to 50 artists, basic features, 5GB storage
- **Professional Tier** ($299/month): Up to 200 artists, all features, 50GB storage, priority support
- **Enterprise Tier** ($599+/month): Unlimited artists, custom integrations, dedicated support, unlimited storage

**Secondary Revenue Streams**:
- Transaction fees on expense reimbursements (0.5-1% optional convenience fee)
- Professional services: Setup, training, custom development ($150/hour)
- Premium integrations: Advanced Xero/SharePoint features ($49/month add-on)

**Value Proposition**: Reduce administrative overhead by 40-60%, eliminate paper processes, improve artist satisfaction, ensure compliance, and enable remote/mobile workforce management.

### Constraints
**Technical Constraints**:
- Must integrate with existing SharePoint infrastructure without requiring SharePoint licenses for all users
- Limited to web technologies (no native mobile app in MVP)
- Must work on older devices/browsers used by some artists
- SharePoint API rate limits may affect bulk operations

**Business Constraints**:
- Budget limitations of performing arts organizations (typically <$50K for software)
- Resistance to change from traditional paper-based processes
- Seasonal usage patterns (peak during performance seasons)
- Need to comply with union regulations and artist contracts

**Regulatory Constraints**:
- Financial data handling must comply with PCI DSS for payment information
- Document retention requirements for contracts (typically 7 years)
- Accessibility compliance (WCAG 2.1 AA) for public-facing features
- Data privacy regulations (GDPR for international artists, state privacy laws)

## Technical Requirements (OPTIONAL - will use modern defaults if not provided)

### Platform
**Primary Platform**: Web (Progressive Web App)
- Modern web browsers (Chrome, Safari, Firefox, Edge - last 2 versions)
- Mobile web browsers on iOS 13+ and Android 8+
- Responsive design with mobile-first approach
- Offline capability for critical features (view contracts, submit expenses)

**Future Considerations**:
- Native mobile apps (iOS/Android) in Phase 2
- Desktop shortcuts/PWA installation for frequent users
- Potential for kiosk mode for venue check-ins

### Technology Preferences
**Frontend Stack**:
- React 18+ with TypeScript for type safety
- Material-UI (MUI) for consistent, accessible components
- Redux Toolkit for state management
- React Query for server state and caching
- Vite for fast development builds

**Backend Stack**:
- Node.js 18+ with Express.js framework
- TypeScript for backend code
- PostgreSQL for primary data storage
- Redis for caching and session management
- Bull for job queues (notifications, integrations)

**Infrastructure**:
- AWS or Azure (preference for Azure given SharePoint integration)
- Docker containers for consistent deployment
- Kubernetes for orchestration (future scaling)
- CloudFront/Azure CDN for static assets
- S3/Azure Blob for document storage

### Performance Requirements
**Response Times**:
- Page load: < 3 seconds on 3G connection
- API responses: < 500ms for 95th percentile
- Document upload: < 10 seconds for 10MB files
- Search results: < 1 second

**Availability**:
- 99.9% uptime SLA (allows ~8.76 hours downtime/year)
- Scheduled maintenance windows: Sunday 2-6 AM
- Zero-downtime deployments
- Automatic failover for critical services

**Capacity**:
- Support 1,000+ concurrent users
- Handle 50,000+ documents
- Process 10,000+ expense submissions/month
- Store 1TB+ of receipts and contracts

### Scale Requirements
**Year 1 Targets**:
- 10-50 organizations
- 500-2,500 total users
- 50-250 concurrent users
- 10GB-100GB storage

**Year 3 Projections**:
- 200-500 organizations
- 10,000-50,000 total users
- 1,000-5,000 concurrent users
- 1TB-5TB storage

**Peak Load Patterns**:
- Performance seasons (Sept-May): 3x normal traffic
- Month-end: 5x expense submissions
- Contract renewal periods: 10x document activity
- Show days: 2x schedule checks

## Design Requirements (OPTIONAL - will use best practices if not provided)

### Brand Personality
**Core Attributes**:
- Professional yet approachable
- Efficient and organized
- Trustworthy and secure
- Creative-industry aware
- Inclusive and accessible

**Tone of Voice**:
- Clear and concise
- Supportive, not condescending
- Action-oriented
- Respectful of artistic professionals
- Encouraging self-service

### Visual Style
**Design Principles**:
- Clean and uncluttered interfaces
- High contrast for stage/backstage viewing
- Large touch targets for mobile use
- Consistent iconography
- Minimal cognitive load

**Color Palette**:
- Primary: Professional blue (#1976D2)
- Secondary: Warm gray (#424242)
- Success: Green (#4CAF50)
- Warning: Amber (#FFA726)
- Error: Red (#F44336)
- Background: Light gray (#F5F5F5)

**Typography**:
- Headers: Inter or Roboto (sans-serif)
- Body: System fonts for performance
- Minimum 16px for mobile
- Clear hierarchy with 1.5x line height

### Key Emotions
**Primary Emotions**:
- **Confidence**: "I can manage my artistic business efficiently"
- **Relief**: "Finally, no more paper forms and lost documents"
- **Empowerment**: "I have control over my financial and contractual matters"
- **Trust**: "My sensitive information is secure and private"

**Emotional Journey**:
1. First use: Welcoming and easy
2. Daily use: Efficient and satisfying
3. Problem solving: Supportive and clear
4. Achievement: Celebratory (expense approved, contract signed)

### Accessibility Requirements
**Standards Compliance**:
- WCAG 2.1 AA compliance minimum
- Section 508 compliance for government contracts
- ADA compliance for public accommodations

**Specific Requirements**:
- Full keyboard navigation
- Screen reader compatibility (JAWS, NVDA, VoiceOver)
- High contrast mode option
- Minimum 4.5:1 color contrast ratios
- Scalable text up to 200% without horizontal scrolling
- Clear focus indicators
- Alternative text for all images
- Captions for any video content
- No reliance on color alone for information

## Feature Details (OPTIONAL - will be inferred from MVP if not provided)

### Core Workflows
1. **Artist Onboarding**:
   - Admin creates artist profile with email
   - System sends welcome email with login link
   - Artist sets password and completes profile
   - Artist views assigned contracts and schedules
   - Artist acknowledges platform tour

2. **Contract Management**:
   - Admin uploads contract to SharePoint
   - Admin assigns contract to artist(s)
   - System notifies artist via email/SMS
   - Artist reviews contract in portal
   - Artist e-signs using integrated service
   - System notifies admin of completion
   - Both parties receive signed copy

3. **Expense Submission**:
   - Artist photographs/scans receipt
   - Artist fills expense form (date, amount, category)
   - Artist uploads receipt image
   - Artist submits for approval
   - Admin/Accountant reviews submission
   - Approval triggers Xero/Hubdoc integration
   - Artist notified of approval/rejection
   - Reimbursement tracked to completion

4. **Schedule Viewing**:
   - Admin updates master schedule
   - System syncs changes to all affected artists
   - Artists view personal schedule dashboard
   - System sends reminders for upcoming events
   - Artists acknowledge important updates
   - Late changes trigger immediate notifications

5. **Administrative Management**:
   - Admin monitors dashboard metrics
   - Admin manages user accounts
   - Admin configures document templates
   - Admin reviews system usage reports
   - Admin handles support requests
   - Admin maintains organization settings

### Content Types
**Documents**:
- Contracts (PDF, DOCX) - up to 50MB
- Receipts (JPG, PNG, PDF) - up to 10MB
- Tax forms (PDF) - up to 25MB
- Schedules (imported from various formats)
- Announcements (rich text with attachments)

**Structured Data**:
- Artist profiles (name, contact, tax info, emergency contacts)
- Expense claims (date, amount, category, description, status)
- Events (date, time, location, type, participants)
- Organizations (name, settings, branding)
- Audit trails (who, what, when for all actions)

**Media**:
- Profile photos (JPG, PNG) - up to 5MB
- Receipt images (JPG, PNG, HEIC) - up to 10MB
- Company logos (SVG, PNG) - up to 2MB
- Document thumbnails (auto-generated)

### Feature Priorities
**Phase 1 - MVP (Months 1-3)**:
1. User authentication and roles
2. Basic contract viewing and e-signing
3. Expense form submission with receipts
4. Schedule viewing (read-only)
5. Mobile responsive design
6. Basic admin dashboard

**Phase 2 - Enhanced (Months 4-6)**:
1. SharePoint deep integration
2. Xero/Hubdoc API integration
3. Email/SMS notifications
4. Advanced search and filters
5. Bulk operations for admins
6. Basic reporting

**Phase 3 - Advanced (Months 7-12)**:
1. Offline mode for mobile
2. Advanced analytics dashboard
3. Custom workflow automation
4. Multi-language support
5. API for third-party integrations
6. Advanced security features (2FA optional)

## Integration Requirements (OPTIONAL)

### External Services
**SharePoint Integration**:
- OAuth 2.0 authentication for admin accounts
- Read/write access to designated document libraries
- Metadata synchronization for contracts
- Permission inheritance from SharePoint
- Real-time document updates
- Support for SharePoint Online and On-premises (2019+)

**Xero Integration**:
- OAuth 2.0 for secure connection
- Create bills/expenses via API
- Attach receipt images to transactions
- Sync approval status back to portal
- Map expense categories bidirectionally
- Support for multiple Xero organizations

**Hubdoc Integration**:
- API key authentication
- Upload documents programmatically
- Retrieve processing status
- Auto-fetch extracted data
- Handle multiple document types

**E-Signature Services**:
- DocuSign Connect or Adobe Sign API
- Embedded signing experience
- Template management
- Signature status webhooks
- Audit trail retrieval
- Support for multiple signers

**Communication Services**:
- SendGrid or AWS SES for transactional emails
- Twilio for SMS notifications
- Support for email templates
- Delivery tracking and analytics
- Unsubscribe management

### API Requirements
**Architecture Style**: RESTful API with JSON
**Authentication**: OAuth 2.0 with JWT tokens
**Documentation**: OpenAPI 3.0 specification

**Core Endpoints**:
- `/auth/*` - Authentication and authorization
- `/users/*` - User management
- `/artists/*` - Artist profiles and data
- `/contracts/*` - Contract management
- `/expenses/*` - Expense submission and tracking
- `/schedules/*` - Event and schedule data
- `/documents/*` - Document upload/download
- `/notifications/*` - Notification preferences
- `/admin/*` - Administrative functions
- `/reports/*` - Analytics and reporting

**API Features**:
- Versioning via URL (v1, v2)
- Rate limiting (1000 requests/hour)
- Pagination for list endpoints
- Filtering and sorting capabilities
- Webhook support for real-time updates
- Batch operations for efficiency
- CORS support for web clients

## Success Metrics (OPTIONAL - will generate standard KPIs if not provided)

### Business Metrics
**User Adoption**:
- 60% of invited artists actively using within 30 days
- 80% of contracts managed digitally within 6 months
- 90% of expenses submitted through portal by year 1

**Efficiency Gains**:
- 50% reduction in contract processing time
- 75% reduction in expense reimbursement cycle time
- 40% reduction in administrative staff hours
- 90% reduction in paper usage

**Financial Impact**:
- 30% reduction in late payments/missing receipts
- 25% improvement in cash flow visibility
- ROI positive within 18 months
- 60% reduction in document storage costs

### Technical Metrics
**Performance KPIs**:
- 99.9% uptime achieved
- <3 second page load for 95% of users
- <500ms API response time (median)
- Zero data loss incidents

**Quality Metrics**:
- <2% error rate for all transactions
- 90% of issues resolved within 24 hours
- Code coverage >80%
- Security scan score >95/100

**Scalability Metrics**:
- Support 2x projected load without degradation
- <5 minute deployment time
- Horizontal scaling validated
- Database queries optimized (<100ms)

### User Satisfaction
**Experience Metrics**:
- Net Promoter Score (NPS) >50
- Customer Satisfaction (CSAT) >4.5/5
- Task completion rate >95%
- User error rate <5%

**Engagement Metrics**:
- Monthly Active Users (MAU) >60%
- Average session duration 5-10 minutes
- Feature adoption rate >70% for core features
- Support ticket rate <5% of MAU

**Accessibility Metrics**:
- WCAG 2.1 AA compliance score 100%
- Screen reader task completion >90%
- Keyboard navigation coverage 100%
- Color contrast issues: 0

## Go-to-Market Strategy (OPTIONAL - will be researched if not provided)

### Target Market
**Primary Market**:
- Small to medium performing arts organizations (10-200 artists)
- Regional theaters and dance companies
- Music venues and festivals
- Arts education institutions

**Market Characteristics**:
- Annual budgets $1M-$50M
- Currently using paper/email/spreadsheets
- 5-20 administrative staff
- 20-200 contracted artists per year

**Geographic Focus**:
- Phase 1: English-speaking markets (US, UK, Canada, Australia)
- Phase 2: European markets (GDPR compliant)
- Phase 3: Global expansion

### Value Proposition
**For Performing Arts Organizations**: "BIG Live Portal eliminates the chaos of managing artist contracts and expenses, reducing administrative overhead by 40% while ensuring compliance and improving artist satisfaction."

**For Artists**: "Access your contracts, submit expenses, and view schedules instantly from any device - no more lost paperwork or payment delays."

**Key Differentiators**:
- Built specifically for performing arts (not generic)
- No IT department required
- Artists use personal emails (no corporate accounts)
- Integrates with existing tools (SharePoint, Xero)
- Mobile-first design for touring artists

### Launch Strategy
**Phase 1 - Soft Launch (Months 1-2)**:
- 3-5 beta organizations
- Full feature set with close support
- Gather feedback and testimonials
- Refine based on real usage

**Phase 2 - Limited Release (Months 3-4)**:
- 20-30 early adopter organizations
- Case study development
- Referral program launch
- Industry conference presence

**Phase 3 - General Availability (Months 5-6)**:
- Public launch with PR campaign
- Content marketing (blogs, webinars)
- Partner channel development
- Freemium tier consideration

**Marketing Channels**:
- Industry associations and conferences
- Arts management publications
- Social media (LinkedIn, Facebook groups)
- Referral and word-of-mouth
- Direct sales to target organizations
- Partnership with arts consultants

## Development Team (OPTIONAL - will use standard team if not provided)

### Team Structure
**Core Team (Months 1-6)**:
- Product Manager/Owner (1) - Requirements, priorities, stakeholder management
- Full-Stack Developer (2) - Frontend and backend development
- UI/UX Designer (1) - Design system, workflows, user research
- DevOps Engineer (0.5) - Infrastructure, CI/CD, monitoring
- QA Engineer (0.5) - Testing, quality assurance

**Expanded Team (Months 7-12)**:
- Additional Full-Stack Developer (1)
- Integration Specialist (1) - SharePoint, Xero, e-signature
- Customer Success Manager (1) - Onboarding, support, training
- Technical Writer (0.5) - Documentation, help content

**External Resources**:
- Security consultant (as needed)
- Accessibility auditor (quarterly)
- Legal advisor (contracts, compliance)
- Marketing agency (launch support)

### Timeline Estimates
**MVP Development (Months 1-3)**:
- Month 1: Architecture, authentication, basic UI
- Month 2: Core features (contracts, expenses, schedules)
- Month 3: Mobile optimization, admin features, testing

**Integration Phase (Months 4-6)**:
- Month 4: SharePoint integration, e-signature setup
- Month 5: Xero/Hubdoc integration, notifications
- Month 6: Performance optimization, security hardening

**Enhancement Phase (Months 7-12)**:
- Months 7-8: Analytics, reporting, bulk operations
- Months 9-10: Offline support, advanced features
- Months 11-12: API development, third-party integrations

## Additional Context (OPTIONAL)

### Migration Strategy
**From Paper-Based Systems**:
- Gradual migration approach (no "big bang")
- Digital-first for new contracts/expenses
- Historical document upload tools
- Parallel running for 3-6 months
- Staff training and support

**From Existing Software**:
- Data export/import tools
- API-based migration where possible
- Mapping workshops for data fields
- Phased cutover by department
- Rollback plan for critical issues

### Training Requirements
**Administrator Training**:
- 2-hour initial training session
- Role-specific workshops
- Video tutorial library
- Monthly office hours
- Quick reference guides

**Artist Onboarding**:
- 15-minute guided tour on first login
- Mobile-optimized help videos
- FAQ section for common tasks
- In-app contextual help
- Multi-language support (future)

### Security Considerations
**Data Protection**:
- Encryption at rest (AES-256)
- Encryption in transit (TLS 1.3)
- Regular security audits
- Penetration testing annually
- OWASP compliance

**Access Control**:
- Role-based permissions (RBAC)
- Principle of least privilege
- Session timeout controls
- IP whitelisting (optional)
- Audit logging for all actions

**Compliance**:
- SOC 2 Type II certification path
- GDPR compliance built-in
- CCPA/CPRA compliance
- PCI DSS for payment data
- Industry-specific regulations

### Future Roadmap
**Year 2 Enhancements**:
- Native mobile applications
- Advanced workflow automation
- AI-powered expense categorization
- Predictive analytics for budgeting
- Multi-currency support

**Year 3 Expansion**:
- Venue booking integration
- Donor/patron management
- Ticket sales integration
- Grant management features
- International market features

**Long-term Vision**:
- Complete performing arts ERP
- Industry-specific AI assistant
- Blockchain for contract verification
- Virtual venue capabilities
- Global arts network platform