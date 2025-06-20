# APP_DETAILS.md

This file contains the core information needed to generate comprehensive documentation for your application. 
Fields marked as (REQUIRED) must be filled out. Fields marked as (OPTIONAL) can be left blank and will be auto-researched or use sensible defaults.

## Basic Information (REQUIRED)

**App Name:** BIG Live Portal

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

### Secondary Users (OPTIONAL)
- Accountants / Finance Team - Process expense claims and manage financial workflows
- Production Managers - Update schedules and post announcements

## Business Context (OPTIONAL - will be auto-researched if not provided)

### Market Context
The performing arts industry faces unique challenges in managing distributed talent, with artists often working as independent contractors across multiple productions. Current solutions are fragmented, with contracts in email, expenses in spreadsheets, and schedules in various formats. The market demands integrated, mobile-friendly solutions that reduce administrative overhead while providing transparency to artists. Post-pandemic, the industry has accelerated digital transformation, creating opportunities for purpose-built platforms that understand the specific workflows of performing arts organizations.

### Competition
- **Overture** - Comprehensive arts management platform with CRM, ticketing, and patron management (enterprise-focused, complex)
- **Theatre Manager** - Box office and venue management with some artist features (venue-centric, less artist-friendly)
- **Tixoom** - Cloud-based arts organization management (focused on ticketing and marketing)
- **Generic HR Platforms** (BambooHR, Gusto) - Not tailored for performing arts workflows
- **Manual Systems** - Many organizations still use email, Excel, and paper forms

### Business Model
- **SaaS Subscription Model**: Monthly/annual pricing based on active artist count
- **Tiered Pricing**: 
  - Starter (up to 50 artists): Core features
  - Professional (50-200 artists): Advanced integrations
  - Enterprise (200+ artists): Custom features and support
- **Implementation Services**: One-time setup and training fees
- **Future Revenue**: Transaction fees for expense processing, premium integrations

### Constraints
- Must integrate with existing Microsoft SharePoint infrastructure
- No external IT support dependency - maintainable by non-technical admin staff
- Budget constraints typical of arts organizations
- Compliance with contractor vs. employee regulations
- Data privacy requirements for artist personal information
- Limited technical expertise among primary users

## Technical Requirements (OPTIONAL - will use modern defaults if not provided)

### Platform
Web-based responsive application with mobile-first design approach. No native mobile apps required, but Progressive Web App (PWA) capabilities for offline access and mobile home screen installation.

### Technology Preferences
- **Frontend**: React with TypeScript for type safety and maintainability
- **UI Framework**: Material-UI or Ant Design for rapid development
- **Backend**: Node.js with Express or NestJS
- **Database**: PostgreSQL for relational data, Redis for caching
- **Authentication**: Azure AD integration for SSO, JWT for session management
- **File Storage**: SharePoint integration, with Azure Blob Storage as backup
- **API**: RESTful with OpenAPI documentation, GraphQL for complex queries

### Performance Requirements
- Page load time: < 2 seconds on 4G mobile connections
- API response time: < 500ms for standard queries
- File upload: Support for 50MB receipts/documents
- Concurrent users: Handle 100+ simultaneous users
- Availability: 99.5% uptime during business hours
- Offline capability: View contracts and schedules without connection

### Scale Requirements
- Initial: 50-200 artists, 5-10 admin users
- Growth: Support up to 1,000 artists within 2 years
- Storage: 10GB per artist for documents and receipts
- Data retention: 7 years for financial records
- Peak usage: Handle 5x normal load during production seasons
- Multi-tenant architecture for future expansion to other organizations

## Design Requirements (OPTIONAL - will use best practices if not provided)

### Brand Personality
- **Professional yet Approachable**: Balance corporate reliability with artistic creativity
- **Empowering**: Make artists feel in control of their administrative tasks
- **Transparent**: Clear communication and status visibility
- **Efficient**: Streamline workflows without overwhelming users
- **Inclusive**: Welcoming to diverse artistic communities

### Visual Style
- **Clean and Minimal**: Focus on content over decoration
- **High Contrast**: Ensure readability in various lighting conditions
- **Color Palette**: 
  - Primary: Deep purple (#6B46C1) - creativity and sophistication
  - Secondary: Warm gold (#F59E0B) - energy and optimism
  - Neutral grays for UI elements
- **Typography**: Modern sans-serif (Inter, Roboto) for clarity
- **Spacing**: Generous white space for visual breathing room
- **Mobile-optimized**: Large touch targets, readable text sizes

### Key Emotions
- **Confidence**: Artists feel secure about their administrative status
- **Relief**: Reduced anxiety about paperwork and deadlines
- **Empowerment**: Easy access to their information
- **Trust**: Reliable system for important documents
- **Efficiency**: Quick task completion

### Accessibility Requirements
- **WCAG 2.1 AA Compliance** minimum, with AAA for critical features
- **Screen Reader Support**: Full ARIA labeling and semantic HTML
- **Keyboard Navigation**: All features accessible without mouse
- **Color Contrast**: 4.5:1 for normal text, 3:1 for large text
- **Responsive Text**: Support for 200% zoom without horizontal scrolling
- **Alternative Formats**: Options for large print or high contrast modes

## Feature Details (OPTIONAL - will be inferred from MVP if not provided)

### Core Workflows
1. **Artist Onboarding**: Email invite → Profile creation → Document access
2. **Contract Management**: Upload → Artist notification → E-signature → Storage
3. **Expense Submission**: Receipt capture → Form completion → Approval → Processing
4. **Schedule Access**: Login → View personal schedule → Receive updates
5. **Admin Management**: User creation → Document upload → Approval workflows → Reporting

### Content Types
- **Contracts**: PDF documents with metadata (dates, amounts, production)
- **Expense Claims**: Structured forms with receipt attachments
- **Schedules**: Calendar events with location and role details
- **Announcements**: Rich text posts with optional attachments
- **User Profiles**: Contact information and role assignments
- **Audit Logs**: System activity tracking for compliance

### Feature Priorities
1. **Critical**: Authentication, contract viewing, expense submission
2. **High**: E-signatures, schedule viewing, mobile responsiveness
3. **Medium**: Bulk operations, advanced search, reporting
4. **Low**: Social features, advanced analytics, custom branding
5. **Future**: Multi-organization support, API for third-party apps

## Integration Requirements (OPTIONAL)

### External Services
- **SharePoint**: Primary document storage and retrieval
- **Azure AD**: Single sign-on and user authentication
- **Microsoft/Adobe Sign**: Electronic signature workflows
- **Xero**: Expense claim processing and financial sync
- **Hubdoc**: Receipt OCR and data extraction
- **SendGrid/Mailgun**: Transactional email delivery
- **Twilio**: SMS notifications for urgent updates

### API Requirements
- **RESTful API** with JSON responses
- **Authentication**: OAuth 2.0 with JWT tokens
- **Rate Limiting**: 100 requests per minute per user
- **Webhooks**: Real-time notifications for document changes
- **Batch Operations**: Bulk user and document management
- **API Documentation**: Interactive Swagger/OpenAPI docs
- **Versioning**: Semantic versioning with deprecation notices

## Success Metrics (OPTIONAL - will generate standard KPIs if not provided)

### Business Metrics
- **Artist Adoption Rate**: 80% of artists actively using within 3 months
- **Document Processing Time**: 50% reduction in contract turnaround
- **Expense Claim Efficiency**: 75% faster reimbursement cycles
- **Admin Time Savings**: 10 hours per week reduced administrative work
- **Cost Reduction**: 30% lower operational costs vs. current process

### Technical Metrics
- **System Uptime**: 99.5% availability during business hours
- **Page Load Speed**: 90% of pages load in under 2 seconds
- **Error Rate**: Less than 0.1% failed transactions
- **Mobile Usage**: 60% of artist access via mobile devices
- **API Performance**: 95% of API calls complete in under 500ms

### User Satisfaction
- **Net Promoter Score (NPS)**: Target 40+ within first year
- **User Satisfaction (CSAT)**: 85% satisfied or very satisfied
- **Task Completion Rate**: 95% of users complete primary tasks
- **Support Tickets**: Less than 5% of users require support monthly
- **Feature Adoption**: 70% of users utilize core features weekly

## Go-to-Market Strategy (OPTIONAL - will be researched if not provided)

### Target Market
- **Primary**: Small to medium performing arts organizations (50-500 artists)
- **Geographic**: Initially English-speaking markets (US, UK, Canada, Australia)
- **Organization Types**: Theatre companies, dance troupes, orchestras, opera houses
- **Sweet Spot**: Organizations with $1M-$10M annual budgets
- **Early Adopters**: Tech-forward artistic directors and operations managers

### Value Proposition
"BIG Live Portal eliminates the administrative chaos of managing performing artists by providing a single, mobile-friendly platform for contracts, expenses, and schedules. Save 10+ hours per week, reduce payment delays by 75%, and give your artists the professional experience they deserve - all without IT complexity."

### Launch Strategy
- **Phase 1 (Months 1-3)**: Beta with 3-5 friendly organizations
- **Phase 2 (Months 4-6)**: Soft launch in local market
- **Phase 3 (Months 7-12)**: Regional expansion with case studies
- **Marketing Channels**: Arts administration conferences, industry publications, peer referrals
- **Pricing Strategy**: Free pilot period, then competitive SaaS pricing
- **Success Stories**: Document time/cost savings for marketing

## Development Team (OPTIONAL - will use standard team if not provided)

### Team Structure
- **Product Owner**: 1 person (0.5 FTE) - requirements and prioritization
- **UX/UI Designer**: 1 person (0.5 FTE) - design and user research
- **Full-Stack Developers**: 2 people (2 FTE) - frontend and backend
- **DevOps Engineer**: 1 person (0.25 FTE) - infrastructure and deployment
- **QA Tester**: 1 person (0.5 FTE) - testing and quality assurance
- **Technical Writer**: 1 person (0.25 FTE) - documentation

### Timeline Estimates
- **Phase 1 (Months 1-2)**: Foundation - Authentication, user management, basic UI
- **Phase 2 (Months 3-4)**: Core Features - Contracts, expenses, schedules
- **Phase 3 (Months 5-6)**: Integrations - SharePoint, e-signatures, Xero
- **Phase 4 (Month 7)**: Polish - Mobile optimization, notifications
- **Phase 5 (Month 8)**: Launch Preparation - Testing, documentation, training
- **Total MVP Timeline**: 8 months with dedicated team

## Additional Context (OPTIONAL)

### Migration Strategy
- **Data Export**: Tools to extract from current Excel/email systems
- **Bulk Import**: CSV upload for artist information and schedules
- **Document Migration**: Batch upload existing contracts to SharePoint
- **Parallel Running**: Support gradual transition over 3-month period
- **Training Materials**: Video tutorials and documentation for smooth adoption

### Training Requirements
- **Artist Training**: 30-minute video overview, 2-page quick start guide
- **Admin Training**: 2-hour hands-on session, comprehensive manual
- **IT Documentation**: Setup and maintenance guide for internal IT
- **Ongoing Support**: Monthly office hours, FAQ updates
- **Train-the-Trainer**: Empower super users to support their peers

### Security Considerations
- **Data Encryption**: TLS 1.3 in transit, AES-256 at rest
- **Access Control**: Role-based permissions with principle of least privilege
- **Audit Trail**: Complete logging of all document and financial actions
- **Compliance**: GDPR for EU artists, CCPA for California
- **Backup Strategy**: Daily automated backups with 30-day retention
- **Incident Response**: Documented procedures for security events

### Future Roadmap
- **Year 1**: Core MVP features and stabilization
- **Year 2**: Advanced analytics, custom workflows, API marketplace
- **Year 3**: Multi-organization platform, white-label options
- **Long-term**: AI-powered insights, predictive scheduling, industry marketplace

---

## Instructions for Use

1. **Fill out all REQUIRED sections** - These are essential for generating documentation
2. **OPTIONAL sections can be left blank** - The system will:
   - Research market context and competitors
   - Suggest appropriate technology stacks
   - Generate design guidelines
   - Create standard metrics and KPIs
   - Propose go-to-market strategies

3. **The more detail you provide, the more tailored the output** - While optional fields will be auto-filled, providing your specific requirements will result in more customized documentation

4. **Save this file as APP_DETAILS.md** in your project root directory