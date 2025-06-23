<goal>
Create a comprehensive technical specification document for a software development project that will serve as direct input for planning and code generation AI systems. The specification must be precise, structured, and provide actionable implementation guidance covering all aspects of the system from architecture to deployment.
</goal>

<format>
The output should be a detailed technical specification in markdown format with the following structure:

# {Project Name} Technical Specification

## 1. Executive Summary
- Project overview and objectives
- Key technical decisions and rationale
- High-level architecture diagram
- Technology stack recommendations

## 2. System Architecture
### 2.1 Architecture Overview
- System components and their relationships
- Data flow diagrams
- Infrastructure requirements

### 2.2 Technology Stack
- Frontend technologies and frameworks
- Backend technologies and frameworks
- Database and storage solutions
- Third-party services and APIs

## 3. Feature Specifications
For each major feature:
### 3.X {Feature Name}
- User stories and acceptance criteria
- Technical requirements and constraints
- Detailed implementation approach
- User flow diagrams
- API endpoints (if applicable)
- Data models involved
- Error handling and edge cases
- Performance considerations

## 4. Data Architecture
### 4.1 Data Models
For each entity:
- Entity definition and purpose
- Attributes (name, type, constraints, defaults)
- Relationships and associations
- Indexes and optimization strategies

### 4.2 Data Storage
- Database selection and rationale
- Data persistence strategies
- Caching mechanisms
- Backup and recovery procedures

## 5. API Specifications
### 5.1 Internal APIs
For each endpoint:
- Endpoint URL and HTTP method
- Request parameters and body schema
- Response schema and status codes
- Authentication and authorization
- Rate limiting and throttling
- Example requests and responses

### 5.2 External Integrations
For each integration:
- Service description and purpose
- Authentication mechanisms
- API endpoints and usage
- Error handling and fallback strategies
- Data synchronization approaches

## 6. Security & Privacy
### 6.1 Authentication & Authorization
- Authentication mechanism and flow
- Authorization strategies and role definitions
- Session management
- Token handling and refresh strategies

### 6.2 Data Security
- Encryption strategies (at rest and in transit)
- PII handling and protection
- Compliance requirements (GDPR, CCPA, etc.)
- Security audit procedures

### 6.3 Application Security
- Input validation and sanitization
- OWASP compliance measures
- Security headers and policies
- Vulnerability management

## 7. User Interface Specifications
### 7.1 Design System
- Visual design principles
- Brand guidelines and personality
- Component library structure
- Responsive design approach
- Accessibility standards (WCAG compliance)
- Platform-specific UI considerations

### 7.2 Design Foundations
#### 7.2.1 Color System
- Primary, secondary, and accent colors (hex/rgb values)
- Semantic colors (success, warning, error, info)
- Neutral/grayscale palette
- Dark mode considerations
- Color accessibility ratios

#### 7.2.2 Typography
- Font families (primary, secondary, monospace)
- Type scale (font sizes and line heights)
- Font weights and styles
- Responsive typography rules
- Text color treatments

#### 7.2.3 Spacing & Layout
- Base unit system (4px, 8px grid, etc.)
- Spacing scale (xs, sm, md, lg, xl values)
- Container widths and breakpoints
- Grid system specifications
- Component spacing patterns

#### 7.2.4 Interactive Elements
- Button styles and states
- Form field specifications
- Animation timing and easing
- Hover/focus/active states
- Loading and transition patterns

#### 7.2.5 Component Specifications
- Design tokens structure
- Core component variants
- Composition patterns
- State visualizations
- Platform-specific adaptations

### 7.3 User Experience Flows
- Key user journeys with wireframes/mockups
- Navigation structure
- State management and transitions
- Error states and user feedback
- Loading and empty states

## 8. Infrastructure & Deployment
### 8.1 Infrastructure Requirements
- Hosting environment specifications
- Server requirements and configuration
- Network architecture
- Storage requirements

### 8.2 Deployment Strategy
- CI/CD pipeline configuration
- Environment management (dev, staging, production)
- Deployment procedures and rollback strategies
- Configuration management

</format>

<warnings-and-guidelines>
Before creating the specification:

1. **Analyze the project comprehensively** in <brainstorm> tags, considering:
  - System architecture and infrastructure requirements
  - Core functionality and feature breakdown
  - Data models and storage architecture
  - API and integration specifications
  - Security, privacy, and compliance requirements
  - Performance and scalability considerations
  - User interface and experience specifications
  - Third-party services and external dependencies
  - Deployment and operational requirements
  - Quality assurance and monitoring strategy

2. **For each area, ensure you**:
  - Provide detailed breakdown of requirements and implementation approaches
  - Identify potential challenges, risks, and mitigation strategies
  - Consider edge cases, error scenarios, and recovery mechanisms
  - Propose alternative solutions where applicable

3. **Critical considerations**:
  - Break down complex features into detailed user flows and system interactions
  - Identify areas requiring clarification or having technical constraints
  - Consider platform-specific requirements (web, mobile, desktop)
  - Address non-functional requirements (performance, security, accessibility)

4. **Quality guidelines**:
  - Be technology-agnostic unless specific technologies are mandated in the PRD
  - Provide concrete examples and clear interfaces between components
  - Include specific implementation guidance without unnecessary jargon
  - Focus on completeness and actionability for development teams
  - Consider both technical and business constraints

5. **Project structure guidelines** (adapt based on technology stack): - Prefer feature-based organization over layer-based when possible - Group related functionality together (e.g., components, hooks, utilities for a feature) - Separate concerns clearly (business logic, UI, data access) - Consider these common patterns: - `/features` or `/modules` for feature-based grouping - `/shared` or `/common` for cross-cutting concerns - `/lib` or `/utils` for utilities and helpers - `/services` for external integrations - Document the chosen structure rationale in the specification - Include example directory trees for complex features 

6. **When specifying project structure**: - Show concrete examples with file paths - Explain the reasoning for the chosen organization - Highlight where shared code should live - Indicate naming conventions (camelCase, PascalCase, kebab-case) - Specify file naming patterns (e.g., `*.test.ts`, `*.spec.ts`)
</warnings-and-guidelines>

<context>
You are an expert software architect creating technical specifications that will be used as direct input for planning and code generation AI systems. The specification must translate business requirements from a Product Requirements Document (PRD) into comprehensive technical documentation that development teams can execute against.

The project request will be provided here:

<project_request>
Features (MVP)
Authentication & User Management
Provides secure user registration with email verification, password reset functionality, and comprehensive profile management. Integrates with Clerk for authentication services while maintaining user preferences and settings in the database.
Tech Involved
Clerk Authentication
Next.js App Router with middleware
Prisma ORM with PostgreSQL
Server Actions for profile updates
Main Requirements
Clerk webhook integration for user sync
User metadata storage in PostgreSQL
Session management across Server Components
Profile data synchronization between Clerk and database
Role-based access control preparation
Prompt Organization
Enables users to organize prompts using a flexible folder/tag hierarchy with drag-and-drop functionality, smart collections, and multi-dimensional categorization. Supports nested folder structures and rule-based automatic organization.
Tech Involved
PostgreSQL with recursive CTEs for folder hierarchy
React DnD Kit for drag-and-drop
Server Actions for CRUD operations
Prisma with relation queries
Main Requirements
Recursive folder structure with infinite nesting
Many-to-many prompt-tag relationships
Smart collection rule engine
Optimistic UI updates for drag-and-drop
Efficient tree traversal queries
Cascade delete for folder hierarchies
Search & Filtering
Provides comprehensive full-text search across all prompts with advanced filtering capabilities by platform, date, tags, and author. Includes search within results and faceted search options.
Tech Involved
PostgreSQL full-text search with GIN indexes
Prisma raw queries for search
React Query for search result caching
Server Actions for search API
Main Requirements
GIN indexes on searchable columns
Search result ranking and relevance
Real-time search suggestions
Filter state management
Pagination for large result sets
Search history tracking
Prompt Creation & Editing
Features a rich text editor with Markdown/XML support, syntax highlighting, live preview, and template variable system. Includes comprehensive version control with revision history and comparison tools.
Tech Involved
CodeMirror 6 or Monaco Editor
Unified/Remark for Markdown processing
Server Actions for saving
PostgreSQL JSONB for version storage
Main Requirements
Real-time syntax highlighting
Template variable parsing and validation
Debounced auto-save functionality
Version diff algorithm
Preview rendering pipeline
Concurrent editing conflict resolution
Templates & Snippets
Provides pre-built prompt templates organized by category and a custom snippet library for reusable prompt components. Supports template inheritance and variable substitution.
Tech Involved
PostgreSQL for template storage
React components for template gallery
Server Actions for template CRUD
Template engine for variable substitution
Main Requirements
Template categorization system
Template versioning
Snippet insertion UI
Variable validation in templates
Template sharing permissions
Usage analytics for popular templates
System Diagram
mermaid
graph TB
    subgraph "Client Layer"
        UI[Next.js App Router]
        MW[Middleware]
    end
    
    subgraph "Authentication"
        CLERK[Clerk Service]
        WEBHOOK[Clerk Webhooks]
    end
    
    subgraph "Application Layer"
        SA[Server Actions]
        API[API Routes]
    end
    
    subgraph "Data Layer"
        PRISMA[Prisma ORM]
        PG[(PostgreSQL/Supabase)]
        CACHE[React Query Cache]
    end
    
    subgraph "External Services"
        VERCEL[Vercel CDN]
    end
    
    UI --> MW
    MW --> CLERK
    MW --> SA
    UI --> CACHE
    
    SA --> PRISMA
    API --> PRISMA
    PRISMA --> PG
    
    CLERK --> WEBHOOK
    WEBHOOK --> API
    API --> PG
    
    UI --> VERCEL
    CACHE --> SA
    
    PG -.-> |Full-text Search| PG
    PG -.-> |Recursive CTEs| PG
    PG -.-> |JSONB Storage| PG

</project_request>

User specific tech stack requests here:

<tech-stack>
NextJS (frontend)
NextJS Server Actions (backend)
Supabase (Postgres DB)
Prisma ORM
Clerk Auth
Deployment on Vercel
Zustand for state management
TailwindCSS for styling
Framer Motion for Animation
</tech-stack>

Project design considerations will be provided here:

<design-considerations>
<aesthetics>
Bold simplicity with intuitive navigation creating frictionless experiences
Breathable whitespace complemented by strategic color accents for visual hierarchy
Strategic negative space calibrated for cognitive breathing room and content prioritization
Systematic color theory applied through subtle gradients and purposeful accent placement
Typography hierarchy utilizing weight variance and proportional scaling for information architecture
Visual density optimization balancing information availability with cognitive load management
Motion choreography implementing physics-based transitions for spatial continuity
Accessibility-driven contrast ratios paired with intuitive navigation patterns ensuring universal usability
Feedback responsiveness via state transitions communicating system status with minimal latency
Content-first layouts prioritizing user objectives over decorative elements for task efficiency
</aesthetics>
<app-design-system>
Color Palette
Primary Colors
Primary Dark - #0F0F14 (Deep charcoal for main backgrounds)
Primary Surface - #1A1A1F (Elevated surface color for cards and panels)
Primary Light - #F8F9FA (Clean white for text and highlights)
Secondary Colors
Secondary Purple - #8B5CF6 (Primary brand accent for key actions)
Secondary Purple Light - #A78BFA (Hover states and secondary elements)
Secondary Purple Pale - #EDE9FE (Subtle backgrounds and selected states)
Accent Colors
Accent Gradient Start - #8B5CF6 (Purple for gradient beginnings)
Accent Gradient End - #EC4899 (Pink for gradient endings)
Accent Blue - #3B82F6 (For informational elements)
Accent Teal - #14B8A6 (For success states and confirmations)
Functional Colors
Success Green - #10B981 (Successful operations and saves)
Warning Amber - #F59E0B (Warnings and cautions)
Error Red - #EF4444 (Errors and destructive actions)
Info Blue - #3B82F6 (Informational messages)
Neutral Colors
Neutral 50 - #FAFAFA (Lightest backgrounds)
Neutral 100 - #F4F4F5 (Light mode backgrounds)
Neutral 200 - #E4E4E7 (Borders in light mode)
Neutral 400 - #A1A1AA (Muted text)
Neutral 500 - #71717A (Secondary text)
Neutral 600 - #52525B (Primary text in light mode)
Neutral 700 - #3F3F46 (Dark mode borders)
Neutral 800 - #27272A (Dark mode elevated surfaces)
Neutral 900 - #18181B (Dark mode primary surfaces)
Typography
Font Family
Primary Font: Inter (All weights)
Monospace Font: JetBrains Mono (For code/prompts)
System Fallback: -apple-system, BlinkMacSystemFont, Segoe UI
Font Weights
Light: 300
Regular: 400
Medium: 500
Semibold: 600
Bold: 700
Text Styles
Headings
H1: 32px/40px, Bold, Letter-spacing -0.025em
Used for page titles and major sections
H2: 28px/36px, Semibold, Letter-spacing -0.02em
Section headers and important callouts
H3: 24px/32px, Semibold, Letter-spacing -0.015em
Subsection headers
H4: 20px/28px, Medium, Letter-spacing -0.01em
Card titles and minor headers
H5: 18px/24px, Medium, Letter-spacing 0
Small section headers
Body Text
Body Large: 16px/24px, Regular, Letter-spacing 0
Primary reading text for prompt content
Body: 14px/20px, Regular, Letter-spacing 0
Standard UI text
Body Small: 12px/16px, Regular, Letter-spacing 0.025em
Secondary information and metadata
Special Text
Code: 14px/20px, JetBrains Mono Regular, Letter-spacing 0
Prompt content and code blocks
Label: 12px/16px, Medium, Letter-spacing 0.05em, Uppercase
Form labels and small headers
Caption: 11px/14px, Regular, Letter-spacing 0.025em
Timestamps and tertiary information
Component Styling
Buttons
Primary Button
Background: Linear gradient (135deg, #8B5CF6 0%, #EC4899 100%)
Text: White (#FFFFFF)
Height: 40px
Padding: 12px 24px
Border Radius: 8px
Font: 14px/20px, Medium
Shadow: 0 4px 6px -1px rgba(139, 92, 246, 0.25)
Hover: Brightness 110%, Transform scale(1.02)
Active: Transform scale(0.98)
Transition: all 200ms cubic-bezier(0.4, 0, 0.2, 1)
Secondary Button
Background: Transparent
Border: 1px solid #3F3F46
Text: #E4E4E7
Height: 40px
Padding: 12px 24px
Border Radius: 8px
Hover: Background #27272A, Border #52525B
Ghost Button
Background: Transparent
Text: #A1A1AA
Height: 36px
Padding: 8px 16px
Hover: Text #E4E4E7, Background rgba(161, 161, 170, 0.1)
Cards
Background: #1A1A1F
Border: 1px solid rgba(255, 255, 255, 0.06)
Border Radius: 12px
Padding: 24px
Shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.3)
Hover Shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.4)
Transition: all 200ms ease-out
Input Fields
Height: 40px
Background: #0F0F14
Border: 1px solid #27272A
Border Radius: 8px
Padding: 10px 16px
Font Size: 14px
Text Color: #F4F4F5
Placeholder: #52525B
Focus Border: 1px solid #8B5CF6
Focus Shadow: 0 0 0 3px rgba(139, 92, 246, 0.1)
Text Areas
Min Height: 120px
Background: #0F0F14
Border: 1px solid #27272A
Border Radius: 8px
Padding: 12px 16px
Font: 14px/20px JetBrains Mono
Resize: Vertical only
Modals/Dialogs
Background: #1A1A1F
Border Radius: 16px
Shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.75)
Backdrop: rgba(0, 0, 0, 0.7)
Max Width: 560px
Padding: 32px
Icons
Small: 16px × 16px
Default: 20px × 20px
Large: 24px × 24px
Interactive Color: #A1A1AA
Active/Hover Color: #E4E4E7
Accent Color: #8B5CF6
Spacing System
2px - Micro (Icon to text spacing)
4px - Tiny (Related elements)
8px - Small (Compact spacing)
12px - Medium-Small (Form elements)
16px - Default (Standard padding)
24px - Medium (Section spacing)
32px - Large (Major sections)
48px - Extra Large (Page margins)
64px - Huge (Hero sections)
Motion & Animation
Transitions
Micro: 150ms ease-out (Hover states, small changes)
Default: 200ms cubic-bezier(0.4, 0, 0.2, 1) (Most interactions)
Smooth: 300ms cubic-bezier(0.4, 0, 0.2, 1) (Modals, dropdowns)
Entrance: 400ms cubic-bezier(0.0, 0, 0.2, 1) (Page transitions)
Animation Patterns
Fade In: opacity 0 → 1
Slide Up: translateY(10px) → translateY(0)
Scale: scale(0.95) → scale(1)
Gradient Shift: Background position animation for gradient buttons
Interactive States
Hover: Transform scale(1.02) for cards, brightness adjustment for buttons
Active: Transform scale(0.98)
Focus: Box shadow with primary color
Loading: Pulse animation with opacity 0.5 → 1
Special UI Elements
Gradient Overlays
Card Hover Gradient: Linear gradient overlay with 5% opacity
Premium Features: Gradient border using pseudo-elements
Active Tab: Bottom border with gradient
Glass Morphism Elements
Background: rgba(26, 26, 31, 0.7)
Backdrop Filter: blur(10px)
Border: 1px solid rgba(255, 255, 255, 0.1)
Code Block Styling
Background: #0A0A0D
Border: 1px solid #27272A
Border Radius: 8px
Padding: 16px
Font: 13px/20px JetBrains Mono
Syntax Highlighting: Using Prism.js dark theme
Tag/Label Components
Height: 24px
Padding: 4px 12px
Border Radius: 12px
Background: rgba(139, 92, 246, 0.1)
Text: #A78BFA
Font Size: 12px
Border: 1px solid rgba(139, 92, 246, 0.2)
Dark Mode Optimizations
Reduced contrast for eye comfort (never pure black on white)
Subtle gradients to create depth without harsh shadows
Increased saturation for accent colors to maintain vibrancy
Adjusted opacity values for overlays and disabled states
Accessibility Considerations
WCAG AA compliant contrast ratios (4.5:1 for normal text, 3:1 for large text)
Focus indicators visible and consistent
Interactive elements minimum 44px touch target
Clear hover and active states
Sufficient color contrast for colorblind users

</app-design-system>
<app-screen-states>
Authentication & User Management
Landing Page
Initial Load State
Hero section with animated gradient background using Primary Purple (#8B5CF6) to Pink (#EC4899) with subtle wave animation
Headline "Your AI Prompts, Organized" in H1 (32px, Bold) with fade-in animation
Subheadline in Body Large (16px) in Neutral 400 (#A1A1AA): "Transform scattered prompts into an organized knowledge base"
Primary CTA button "Get Started" with gradient background, 40px height, smooth scale(1.02) on hover
Below fold: Three feature cards with glass morphism effect showcasing key benefits
Social proof counter animating up from 0 to current user count
Navigation bar with transparent background, blur effect on scroll
Smooth parallax scrolling on hero elements
Scroll State
Navigation bar transitions to solid #1A1A1F background with subtle shadow
Feature cards animate in with staggered fade-up effect (translateY(10px) → translateY(0))
Interactive preview section shows prompt organization with cursor animation
Testimonial cards slide in from sides with intersection observer
Footer fades in with links in Neutral 500 (#71717A)
Registration Modal
Initial State
Modal backdrop with rgba(0, 0, 0, 0.7) fade-in over 300ms
Modal container slides up with scale(0.95) → scale(1) animation
Email input field auto-focused with purple glow (#8B5CF6 with 0.1 opacity)
"Continue with Email" primary button disabled until valid email
Divider with "OR" text in Neutral 500
Social login buttons (Google/GitHub) with subtle hover elevation
"Already have an account?" link at bottom in Secondary Purple Light (#A78BFA)
Close button (X) in top-right with rotate animation on hover
Email Validation State
Real-time validation with 150ms debounce
Green checkmark fades in next to valid email
Red error message slides down for invalid format
Button enables with color transition when email valid
Input border transitions to Success Green (#10B981) for valid email
Loading State
Button text fades out, replaced by spinning loader
Modal content has subtle opacity reduction (0.7)
Prevent additional clicks with pointer-events: none
Smooth transition lasting 200ms
Password Step State
Email field slides up and locks with gray background
Password field slides in from bottom with auto-focus
Password strength meter appears below with segments
Requirements checklist with real-time validation
Show/hide password toggle with eye icon morph animation
Terms checkbox with custom styling matching brand
Success State
Confetti animation using brand colors
Success message "Check your email!" with mail icon
Modal content fades out and scales down
Smooth redirect to email verification screen
Email Verification Screen
Pending State
Full-screen centered container with dark background (#0F0F14)
Large animated email icon with subtle bounce effect
"Check your inbox" as H2 heading
Email address displayed in code font style
Countdown timer before "Resend" button enables (60s)
"Open email app" button with system email client detection
Tips section with common issues in collapsible accordion
Resend State
Button transforms from disabled to primary style
Click triggers subtle pulse animation on email icon
Toast notification slides in from top: "Email resent!"
Countdown resets with smooth number transitions
Success State
Green checkmark draws in with SVG animation
"Email verified!" message with celebration animation
Auto-redirect progress bar at bottom
"Continue to app" button for manual proceed
Smooth fade transition to onboarding flow
Password Reset Flow
Reset Request Initial State
Clean centered form with single email input
Forgot password icon animation (key rotating)
Clear instruction text in Body size
Rate limit warning if multiple attempts detected
Link to return to login with back arrow
Reset Request Loading State
Button width animates to circle with spinner
Form elements fade to 50% opacity
Prevents double-submission
Reset Request Success State
Full-screen success illustration
Clear next steps in numbered list
"Check spam folder" reminder
Return to login link prominent
Reset Password Form State
Token validation with skeleton loader
Password field with same styling as registration
Confirm password field with match validation
Requirements dynamically check off
Submit button with gradient effect
Reset Success State
Brief success animation
"Password updated" message
Auto-redirect to login with 3s countdown
Manual "Go to login" button
Prompt Organization
Create Folder/Tag Hierarchy
Sidebar Initial State
Collapsed to 64px width showing only icons
Folder icons in Neutral 400 with tooltip on hover
Smooth width transition on hover (64px → 240px)
"New Folder" button at bottom with plus icon
Drag handle appears on hover for reordering
Sidebar Expanded State
240px width with folder names visible
Tree structure with 16px indentation per level
Folder count badges in small gray pills
Active folder highlighted with purple left border
Smooth accordion animations for expand/collapse
Search bar slides down from top on CMD+K
Folder Creation Modal Initial State
Modal slides up with spring physics animation
Name input auto-focused with purple glow
Suggested names based on existing patterns
Color palette with 12 preset colors in grid
Custom color picker collapsed by default
Icon grid with search functionality
Folder Creation Icon Selection State
Searchable grid of 100+ icons
Icons organized by category tabs
Selected icon scales up with spring animation
Preview of folder appearance updates live
Recently used icons section at top
Folder Creation Completion State
Create button with gradient background
Loading state with button transformation
Success state with folder sliding into sidebar
Modal fades out with scale down animation
New folder auto-selected and expanded
Nested Folders with Drag-and-Drop
Hover State
Folder scales to 1.02 with shadow elevation
Cursor changes to grab hand
Drag handle becomes visible on left edge
Multi-select shows checkbox on hover
Dragging State
Original position shows dashed outline
Dragged item becomes semi-transparent (0.7 opacity)
Follows cursor with slight lag for natural feel
Count badge shows number if multiple selected
Other folders show hover state when valid drop target
Valid Drop State
Target folder expands with spring animation
Blue insertion line shows exact drop position
Target folder highlights with purple glow
Preview of new structure in real-time
Auto-scroll activates near viewport edges
Invalid Drop State
Red tint overlay on invalid targets
Subtle shake animation on attempt
Cursor shows not-allowed symbol
Original position pulses to indicate return
Drop Success State
Smooth slide animation to final position
Brief purple flash on moved items
Success toast with undo option
Tree structure reflows with stagger animation
Auto-save indicator pulses in corner
Prompt Creation & Editing
Rich Text Editor Interface
Split View Mode
Vertical divider with drag handle
Synchronized scrolling between panes
Live preview updates with 100ms debounce
Syntax highlighting in source view
Resizable panes with min/max constraints
Double-click divider to reset 50/50
Editor Focus State
Toolbar fades in at top with formatting options
Word count and read time in bottom bar
Auto-save indicator with timestamp
Zen mode button in top-right corner
Format painter tool for style copying
Variable Input State
Type {{ to trigger variable dropdown
Autocomplete menu with fuzzy search
Variables appear as purple pills inline
Hover shows variable definition tooltip
Click to edit variable properties
Delete with backspace or X button
Markdown Rendering State
Real-time preview with GitHub-flavored markdown
Code blocks with syntax highlighting
Copy button appears on code block hover
Tables with alternating row colors
Checkboxes interactive in preview
Full Screen / Zen Mode
Smooth transition with fade to black
All UI elements fade out except editor
ESC or F11 to exit
Subtle breathing animation on cursor
Focus mode highlights current paragraph
Version Control Interface
Version Timeline View
Horizontal timeline with version dots
Hover shows preview of changes
Click to expand version details
Major versions shown with larger dots
Branch points clearly indicated
Current version highlighted in purple
Version Comparison View
Side-by-side diff with color coding
Added content in green background
Removed content in red strikethrough
Changed content in yellow highlight
Line numbers for reference
Unified diff option available
Version List View
Compact list with key metadata
Author avatar and name
Relative timestamps ("2 hours ago")
Change summary in gray text
Revert button on hover
Star important versions
Restore Confirmation State
Modal with comparison preview
"Are you sure?" with consequences explained
Show what will be lost/gained
Confirm button requires 3s hold
Cancel prominent to prevent accidents
Auto-save Indicator States
Idle: Gray text "All changes saved"
Saving: Pulsing dot with "Saving..."
Saved: Green checkmark fades in
Error: Red warning with retry button
Offline: Orange indicator with queue count

</app-screen-states>
</design-considerations>

Begin your response with detailed specification planning in <brainstorm> tags, then provide the complete technical specification following the prescribed format.
</context>
