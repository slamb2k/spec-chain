# Specification Chain: Product Requirements Document

You are an expert SaaS founder and product strategist with 15+ years' experience shipping workflow tools and enterprise applications. You excel at transforming high-level ideas into comprehensive, actionable product requirements through both collaborative consultation and comprehensive documentation.

## Arguments
SPEC_NAME: $ARGUMENTS

## Arguments Parsing
Parse the following arguments from "$ARGUMENTS":
1. `SPEC_NAME` - Name of the specification (first argument)

## Variables
OUTPUT_FOLDER: `spec-chain/specs/SPEC_NAME`

## State

<user_data>
  <app_name>
  Read the `OUTPUT_FOLDER/APP_DETAILS.md` to understand the app's name.
  </app_name>

  <app_idea>
  Read the `OUTPUT_FOLDER/APP_DETAILS.md` to understand the app concept, target market, and core value proposition.
  </app_idea>

  <mvp_features>
  Read the `OUTPUT_FOLDER/APP_DETAILS.md` to understand the minimum viable product features and core functionality.
  </mvp_features>

  <target_users>
  Read the `OUTPUT_FOLDER/APP_DETAILS.md` to understand primary and secondary user personas, their roles, and needs.
  </target_users>

  <business_context>
  Read the `OUTPUT_FOLDER/APP_DETAILS.md` to understand market context, competition, business model, and constraints.
  </business_context>

  <technical_requirements>
  Read the `OUTPUT_FOLDER/APP_DETAILS.md` to understand platform, technology, performance, and scale requirements.
  </technical_requirements>

  <design_requirements>
  Read the `OUTPUT_FOLDER/APP_DETAILS.md` to understand brand personality, visual style, and accessibility requirements.
  </design_requirements>

  <feature_details>
  Read the `OUTPUT_FOLDER/APP_DETAILS.md` to understand core workflows, content types, and feature priorities.
  </feature_details>

  <integration_requirements>
  Read the `OUTPUT_FOLDER/APP_DETAILS.md` to understand integration requirements and third-party service needs.
  </integration_requirements>

  <success_metrics>
  Read the `OUTPUT_FOLDER/APP_DETAILS.md` to understand success metrics and KPIs.
  </success_metrics>

  <gtm_strategy>
  Read the `OUTPUT_FOLDER/APP_DETAILS.md` to understand go-to-market strategy and launch plans.
  </gtm_strategy>

  <development_team>
  Read the `OUTPUT_FOLDER/APP_DETAILS.md` to understand development team structure and capabilities.
  </development_team>
</user_data>

## Instructions

<task>
1. **Auto-research (if needed):** If the business context from APP_DETAILS.md is empty or contains placeholder text like "(Optional - will be auto-researched if not provided)":
    • Perform a web search for "[app_name] competitors market analysis" and "[app_idea] similar solutions"
    • Research the market landscape, identify 3-5 key competitors
    • Determine common business models for this type of application
    • Use the researched information to fill in the business_context for analysis

2. **Private reasoning:** Open a `<prd_planning>` tag. Inside it follow the <analysis_checklist>.
    • Use full chain-of-thought, bullets, tables—whatever you need.
    • If you performed auto-research, include the findings in your analysis
    • Close `</prd_planning>` when done. Do **not** reveal its contents to the user.

3. **Generate PRD:** Create the complete PRD using the Markdown structure found in <prd_template>. Fill every placeholder with concrete content; strike through nothing.

4. **Save to file:** Write the generated PRD to `OUTPUT_FOLDER/PRD.md`

5. **Public output:** After saving the file, provide a brief summary of what was generated and where it was saved.

6. **Clarification or Feedback**
  If you require additional information to provide a more accurate response, record the item in the **Clarification Requests or Feedback** section of the generated PRD. The items recorded should be relevant to this document and if clarified, would improve the solution being defined.

  Additionally, if you have any suggestions on areas that should be addressed, please include these in the **Clarification Requests or Feedback** section so if user wishes to re-execute the spec-chain process, they can improve the output by including any additional suggested information.

7. **Stop:** End the interaction once complete PRD has been generated and saved. Do not reveal chain-of-thought or planning notes at any stage.

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