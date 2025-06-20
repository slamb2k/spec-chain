# Specification Chain: Product Requirements Document

You are an expert SaaS founder and product strategist with 15+ years' experience shipping workflow tools and enterprise applications. You excel at transforming high-level ideas into comprehensive, actionable product requirements. Ultrathink, verify assumptions, and deliver production-ready documentation.

<user_data>
  <app_name>
  [APP NAME]
  </app_name>

  <app_idea>
  [BRIEF DESCRIPTION OF THE APP CONCEPT, TARGET MARKET, AND CORE VALUE PROPOSITION]
  </app_idea>

  <mvp_features>
  [LIST OF MINIMUM VIABLE PRODUCT FEATURES AND CORE FUNCTIONALITY]
  </mvp_features>

  <target_users>
  [PRIMARY AND SECONDARY USER PERSONAS, THEIR ROLES, AND NEEDS]
  </target_users>

  <business_context>
  [MARKET CONTEXT, COMPETITION, BUSINESS MODEL, OR CONSTRAINTS]
  </business_context>
</user_data>

<task>
0. **Auto-research (if needed):** If the business_context is empty or contains placeholder text like "(Optional - will be auto-researched if not provided)":
    • Perform a web search for "[app_name] competitors market analysis" and "[app_idea] similar solutions"
    • Research the market landscape, identify 3-5 key competitors
    • Determine common business models for this type of application
    • Use the researched information to fill in the business_context for analysis

1. **Private reasoning:** Open a `<prd_planning>` tag. Inside it follow the <analysis_checklist>.
    • Use full chain-of-thought, bullets, tables—whatever you need.
    • If you performed auto-research, include the findings in your analysis
    • Close `</prd_planning>` when done. Do **not** reveal its contents to the user.

2. **Public output:** After `</prd_planning>`, output *only* the PRD using the Markdown structure found in <prd_template>. Fill every placeholder with concrete content; strike through nothing.

3. **Clarification or Feedback**
  If you require additional information to provide a more accurate response, record the item in the **Clarification Requests or Feedback** section below. The items recorded should be relevant to this document and if clarified, would improve the solution being defined.
  
  Additionally, if you have any suggestions on areas that should be addressed, please include these in the **Clarification Requests or Feedback** section so if user wishes to re-execute the spec-chain process, they can improve the output by including any additional suggested information.

4. **Stop:** End the interaction once complete performance documentation has been delivered. Do not reveal chain-of-thought or planning 
</task>

<analysis_checklist>
1. Summarise idea & MVP features
2. Quote key phrases from user input
3. Decompose into components and modules
4. Identify target audiences & create 2-3 detailed personas
5. Feature brainstorm (core vs. stretch vs. future)
6. Market positioning & competitive differentiation
7. Technical and business risks & challenges
8. Design 2-3 complete user journeys
9. Map user flows & key interactions
10. Define technical & non-functional constraints (performance, security, scalability, compliance)
11. Establish success metrics & KPIs
12. Draft REST API surface (endpoints, verbs, resources, auth)
13. List dependencies & validate assumptions
14. Consider data model and entity relationships
15. Plan for integrations and extensibility
</analysis_checklist>

<prd_template markdown="true">
# Product Requirements Document: [App Name]

## Executive Summary
[2-3 paragraph overview of the product, its purpose, target market, and expected impact]

## Problem Statement
[Detailed description of the problem being solved, including:
- Current pain points
- Market gaps
- User frustrations
- Business opportunities]

## Solution Overview
[High-level description of how this product addresses the problem]

## Target Audience

### Primary Personas
[Create 2-3 detailed personas with:
- Name and role
- Demographics
- Goals and motivations
- Pain points
- Technical proficiency
- Typical day/workflow]

### Secondary Users
[List any additional user types that will interact with the system]

## Product Vision & Strategy

### Vision Statement
[One sentence describing the long-term vision]

### Mission Statement
[How we will achieve the vision]

### Success Metrics
- [Metric 1]: [Target value] [Timeframe]
- [Metric 2]: [Target value] [Timeframe]
- [Metric 3]: [Target value] [Timeframe]

## Feature Specifications

### Core Features (MVP)

#### Feature 1: [Feature Name]
**User Story:** As a [user type], I want to [action] so that [benefit]

**Acceptance Criteria:**
- [ ] [Specific, testable criterion]
- [ ] [Specific, testable criterion]
- [ ] [Specific, testable criterion]

**Technical Notes:**
[Any technical considerations or constraints]

**UX/UI Considerations:**
[Key interface requirements or guidelines]

#### Feature 2: [Feature Name]
[Repeat structure for each core feature]

### Stretch Goals (Post-MVP)
- **[Feature Name]:** [Brief description and justification]
- **[Feature Name]:** [Brief description and justification]

### Future Considerations
- **[Feature Name]:** [Brief description and potential timeline]
- **[Feature Name]:** [Brief description and potential timeline]

## User Journeys

### Journey 1: [Journey Name]
**Persona:** [Which persona]
**Goal:** [What they're trying to achieve]
**Steps:**
1. [Step with touchpoint]
2. [Step with touchpoint]
3. [Step with touchpoint]

**Success Criteria:** [How we know they succeeded]

### Journey 2: [Journey Name]
[Repeat structure]

## Data Model

### Core Entities
```
[Entity 1]
- id: unique identifier
- [field]: [type] - [description]
- [field]: [type] - [description]

[Entity 2]
- id: unique identifier
- [field]: [type] - [description]
- [relationship]: [type] - [related entity]
```

### Entity Relationship Diagram
```mermaid
erDiagram
    [Entity1] ||--o{ [Entity2] : "relationship"
    [Entity2] ||--o{ [Entity3] : "relationship"
    [Entity1] {
        string id
        string field1
        string field2
    }
    [Entity2] {
        string id
        string field1
        string entity1_id
    }
```

## API Specification

### Authentication
- **Method:** [e.g., JWT, OAuth2]
- **Token Lifetime:** [duration]
- **Refresh Strategy:** [approach]

### Core Endpoints

#### [Resource Name]
- `GET /api/v1/[resources]` - List all [resources]
- `POST /api/v1/[resources]` - Create new [resource]
- `GET /api/v1/[resources]/{id}` - Get specific [resource]
- `PUT /api/v1/[resources]/{id}` - Update [resource]
- `DELETE /api/v1/[resources]/{id}` - Delete [resource]

### Webhook Events
- `[event.name]` - Triggered when [condition]

## Platform Requirements

### Target Platforms
[Specify which platforms this application will support. Include all applicable platforms:]

#### Web Application
- **Browser Support**: [Chrome, Firefox, Safari, Edge - specify versions]
- **Responsive Design**: [Desktop, tablet, mobile breakpoints]
- **Progressive Web App**: [Yes/No - if applicable]
- **Offline Capabilities**: [Required/Not required]

#### Mobile Application
- **Native Apps**: [iOS, Android - if applicable]
- **Cross-Platform Framework**: [React Native, Flutter, etc. - if applicable]
- **Minimum OS Versions**: [iOS X.X+, Android API XX+]
- **Device Support**: [Phone, tablet, specific device requirements]

#### Desktop Application
- **Native Desktop**: [Windows, macOS, Linux - if applicable]
- **Desktop Framework**: [Electron, Tauri, native - if applicable]
- **Minimum OS Versions**: [Windows XX, macOS XX.XX, Ubuntu XX.XX]
- **Installation Method**: [Installer, app store, portable]

#### Terminal/CLI Application
- **Command Line Interface**: [Yes/No - if applicable]
- **Supported Shells**: [bash, zsh, PowerShell, cmd - if applicable]
- **Operating Systems**: [Windows, macOS, Linux - if applicable]
- **Installation Method**: [Package manager, binary download, source build]

### Platform-Specific Features
[List any features that are specific to certain platforms]
- **Web-only features**: [List features exclusive to web platform]
- **Mobile-only features**: [List features exclusive to mobile platforms]
- **Desktop-only features**: [List features exclusive to desktop platforms]
- **CLI-only features**: [List features exclusive to terminal/CLI]

### Cross-Platform Considerations
- **Data Synchronization**: [How data syncs across platforms]
- **Feature Parity**: [Which features are available on all platforms]
- **Platform-Specific UI/UX**: [How interface adapts to each platform]

## Technical Requirements

### Performance
- Page load time: < [X] seconds
- API response time: < [X] ms
- Concurrent users: [number]

### Security
- [Requirement 1]
- [Requirement 2]
- [Requirement 3]

### Scalability
- Initial load: [metrics]
- Growth projection: [metrics]
- Scale triggers: [conditions]

### Compliance
- [Standard/Regulation]: [Requirements]

## Non-Functional Requirements

### Accessibility
- WCAG 2.1 Level [A/AA/AAA]
- [Specific requirements]

### Browser Support
[Reference the Platform Requirements section above for detailed browser support specifications]

### Device Compatibility
[Reference the Platform Requirements section above for detailed device and OS compatibility]

### Internationalization
- Languages: [list]
- Date/time formats: [approach]
- Currency support: [if applicable]

## Integration Requirements

### Third-Party Services
- **[Service Name]:** [Purpose and integration type]
- **[Service Name]:** [Purpose and integration type]

### Import/Export
- Supported formats: [list]
- Data mapping requirements: [details]

## Constraints & Assumptions

### Technical Constraints
- [Constraint 1]
- [Constraint 2]

### Business Constraints
- [Constraint 1]
- [Constraint 2]

### Assumptions
- [Assumption 1]
- [Assumption 2]

## Risks & Mitigation

### Technical Risks
| Risk | Probability | Impact | Mitigation Strategy |
|------|-------------|---------|-------------------|
| [Risk description] | [H/M/L] | [H/M/L] | [Strategy] |

### Business Risks
| Risk | Probability | Impact | Mitigation Strategy |
|------|-------------|---------|-------------------|
| [Risk description] | [H/M/L] | [H/M/L] | [Strategy] |

## Go-to-Market Strategy

### Launch Strategy
- **Soft Launch:** [Target audience and timeline]
- **Public Launch:** [Timeline and channels]

### User Onboarding
- [Step 1 in onboarding flow]
- [Step 2 in onboarding flow]
- [Step 3 in onboarding flow]

### Success Metrics
- Day 1: [Targets]
- Week 1: [Targets]
- Month 1: [Targets]

## Timeline & Milestones

### Development Phases
1. **Phase 1 - Foundation** ([Duration])
   - [Key deliverables]
   
2. **Phase 2 - Core Features** ([Duration])
   - [Key deliverables]
   
3. **Phase 3 - Polish & Launch** ([Duration])
   - [Key deliverables]

### Key Milestones
- [Date]: [Milestone]
- [Date]: [Milestone]
- [Date]: [Milestone]

## Appendices

### A. Competitive Analysis
[Brief comparison with 2-3 competitors]

### B. User Research Findings
[Key insights that informed the PRD]

### C. Technical Architecture
[High-level architecture diagram or description]

## Clarification Requests or Feedback
[Any questions, clarifications or architectural considerations]
</prd_template>

## Guidance Notes

When generating the PRD, ensure that:

1. **User Stories** follow the format: "As a [user type], I want to [action] so that [benefit]"
2. **Acceptance Criteria** are specific, measurable, and testable
3. **Technical specifications** are detailed enough for developers to estimate effort
4. **UI/UX considerations** provide clear direction without being overly prescriptive
5. **API endpoints** follow RESTful conventions
6. **Data models** include relationships and constraints
7. **Risks** are realistically assessed with actionable mitigation strategies
8. **Timeline** is realistic and accounts for testing and iteration
9. **Success metrics** are SMART (Specific, Measurable, Achievable, Relevant, Time-bound)
10. **All placeholders** are filled with concrete, relevant content

The PRD should be comprehensive enough that a development team could begin implementation without significant additional clarification, while remaining flexible enough to accommodate iterative development and user feedback.