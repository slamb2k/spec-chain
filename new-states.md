<goal>
You are an industry-veteran SaaS product designer. You’ve built high-touch UIs for FANG-style companies.

Your goal is to take the context below, the guidelines, the practicalities, the style guide, and the user inspiration, and turn it into a “State” Brief, or snapshots of different features at different points in time in the user’s journey
</goal>


<guidelines>
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

</guidelines>

<context>
<app-overview>
Elevator Pitch
A centralized prompt management platform that transforms scattered AI prompts into an organized, searchable, and shareable knowledge base - think "GitHub for prompts" where users can version, collaborate, and monetize their best AI interactions.
Problem Statement
AI users repeatedly lose valuable prompts across multiple platforms (ChatGPT, Claude, Midjourney, etc.), struggle to find and reuse their best work, and lack ways to collaborate or learn from others' proven prompts. This leads to duplicated effort, inconsistent results, and missed opportunities for knowledge sharing.
Target Audience
Primary: Power users of AI tools (developers, content creators, researchers) who use prompts daily
Secondary: Teams collaborating on AI projects who need standardized prompts
Tertiary: Prompt engineers looking to monetize their expertise
USP
Unlike simple note-taking apps or platform-specific histories, we provide a dedicated prompt management system with version control, advanced formatting support (Markdown/XML), collaboration features, and cross-platform compatibility - making prompts as manageable as code.
</app-overview>
<task>
Your goal here is to go feature-by-feature and think like a designer. Here is a list of things you’d absolutely need to think about:

User goals and tasks - Understanding what users need to accomplish and designing to make those primary tasks seamless and efficient
Information architecture - Organizing content and features in a logical hierarchy that matches users' mental models
Progressive disclosure - Revealing complexity gradually to avoid overwhelming users while still providing access to advanced features
Visual hierarchy - Using size, color, contrast, and positioning to guide attention to the most important elements first
Affordances and signifiers - Making interactive elements clearly identifiable through visual cues that indicate how they work
Consistency - Maintaining uniform patterns, components, and interactions across screens to reduce cognitive load
Accessibility - Ensuring the design works for users of all abilities (color contrast, screen readers, keyboard navigation)
Error prevention - Designing to help users avoid mistakes before they happen rather than just handling errors after they occur
Feedback - Providing clear signals when actions succeed or fail, and communicating system status at all times
Performance considerations - Accounting for loading times and designing appropriate loading states
Mobile vs. desktop considerations - Adapting layouts and interactions for different device capabilities and contexts
Responsive design - Ensuring the interface works well across various screen sizes and orientations
User testing feedback loops - Incorporating iterative testing to validate assumptions and improve the design
Platform conventions - Following established patterns from iOS/Android/Web to meet user expectations
Microcopy and content strategy - Crafting clear, concise text that guides users through the experience
Aesthetic appeal - Creating a visually pleasing design that aligns with brand identity while prioritizing usability
Animations - Crafting beautiful yet subtle animations and transitions that make the app feel professional

I need you to take EACH FEATURE below, and give me a cohesive Design Brief. Here’s how I want it formatted. You repeat this for each feature:

<format>
## Feature Name
### Screen X
#### Screen X State N
* description
* of
* UI & UX
* in detail
* including animations
* any anything else
* and colors based on the style-guide below
#### Screen X State N+1

Repeat for as many N+# as needed based on the function of the state

</format>
</task>

<feature-list>
Features List
Authentication & User Management
User Registration with Email Verification
User Stories
As a new user, I want to sign up quickly with just my email, so that I can start organizing my prompts immediately
As a security-conscious user, I want email verification, so that my account is protected from unauthorized access
As a returning user, I want social login options (Google/GitHub), so that I can sign in with one click
As a team lead, I want to invite team members via email, so that we can collaborate on prompts
UX/UI Considerations
Landing Page
Hero section with clear value proposition and "Get Started" CTA
Animated preview showing prompt organization in action
Social proof indicators (user count, prompts saved)
Registration Modal
Initial State: Email input with real-time validation
Loading State: Subtle spinner replacing submit button
Success State: Confirmation message with email icon animation
Progressive disclosure: Only ask for email first, then password on next step
Password strength indicator with dynamic feedback
Terms acceptance with inline expandable privacy policy
Email Verification Screen
Pending State: Animated email icon with "Check your inbox" message
Resend State: Countdown timer before allowing resend (prevents spam)
Success State: Smooth transition to onboarding flow
Magic link option for passwordless entry
Deep link handling for mobile app verification
Password Reset Functionality
User Stories
As a forgetful user, I want to reset my password easily, so that I don't lose access to my prompts
As a security-aware user, I want secure password reset with time limits, so that my account stays protected
As a mobile user, I want the reset process to work seamlessly on my phone, so that I can regain access anywhere
UX/UI Considerations
Password Reset Request
Initial State: Clean form with just email field
Loading State: Button transforms to progress indicator
Success State: Full-screen confirmation with next steps
Inline validation with helpful error messages
Rate limiting indicator if too many attempts
Reset Password Screen
Token Validation: Automatic check with loading skeleton
Form State: New password fields with requirements checklist
Success State: Auto-redirect to login with success toast
Password visibility toggle with smooth icon transition
Automatic login option after successful reset
Prompt Organization
Create Folder/Tag Hierarchy
User Stories
As a content creator, I want to organize prompts by project, so that I can quickly find relevant prompts for each client
As a researcher, I want nested folders for topics and subtopics, so that I can maintain a knowledge hierarchy
As a visual thinker, I want color-coded folders, so that I can quickly identify different categories
As a power user, I want keyboard shortcuts for folder creation, so that I can organize efficiently
UX/UI Considerations
Sidebar Navigation
Collapsed State: Icon-only view with tooltips on hover
Expanded State: Full folder tree with smooth accordion animations
Drag State: Ghost element preview with valid drop zones highlighted
Contextual menu on right-click with common actions
Breadcrumb navigation showing current location
Folder Creation Modal
Input State: Auto-focused name field with suggested names
Color Picker State: Compact palette with custom color option
Icon Selection State: Searchable icon grid with categories
Parent folder selector with visual hierarchy preview
Real-time preview of how folder will appear in sidebar
Nested Folders with Drag-and-Drop
User Stories
As an organized user, I want to restructure my folders easily, so that I can adapt my organization as needs change
As a visual organizer, I want to see where items will land before dropping, so that I can organize confidently
As a bulk organizer, I want to select multiple items to move, so that I can reorganize efficiently
UX/UI Considerations
Drag Interaction
Hover State: Subtle scale and shadow elevation on draggable items
Dragging State: Semi-transparent ghost following cursor with count badge for multiple items
Valid Drop State: Target folder expands with insertion line indicator
Invalid Drop State: Red tint with shake animation on invalid targets
Spring physics for natural-feeling drag movements
Auto-scroll when dragging near viewport edges
Undo/redo support with toast notifications
Prompt Creation & Editing
Rich Text Editor with Markdown/XML Support
User Stories
As a developer, I want syntax highlighting for code blocks, so that I can write technical prompts clearly
As a content writer, I want WYSIWYG editing, so that I can focus on content without markup
As a power user, I want to switch between visual and source modes, so that I have full control
As a template creator, I want to use variables and placeholders, so that I can create reusable prompts
UX/UI Considerations
Editor Interface
Split View Mode: Resizable panes with synchronized scrolling
Preview Mode: Live rendering with syntax highlighting
Source Mode: Monaco-style editor with autocomplete
Zen Mode: Distraction-free writing with fade-in toolbar
Floating formatting toolbar appearing on text selection
Smart indent and bracket matching
Command palette (Cmd/Ctrl + K) for quick actions
Variable System
Variable Input State: Inline pills with edit-on-click
Variable Preview State: Highlighted with sample data
Variable Error State: Red underline with tooltip explanation
Autocomplete dropdown for existing variables
Variable definition sidebar with test values
Real-time preview with variable substitution
Version Control for Prompts
User Stories
As a prompt engineer, I want to track changes over time, so that I can see how prompts evolved
As a experimenter, I want to compare versions side-by-side, so that I can identify improvements
As a cautious user, I want to restore previous versions, so that I can recover from mistakes
As a collaborator, I want to see who made changes, so that I can understand modifications
UX/UI Considerations
Version History Panel
Timeline View: Visual timeline with version dots and connecting lines
List View: Compact list with diff indicators (+/- lines)
Comparison View: Side-by-side diff with highlighted changes
Version metadata (author, timestamp, change summary)
One-click restore with confirmation dialog
Auto-save Indicator
Saving State: Subtle pulse animation on save icon
Saved State: Checkmark with timestamp
Error State: Warning icon with retry option
Debounced saves to prevent excessive versions
Manual checkpoint creation for major versions
Branch creation for experimental changes



</feature-list>

<style-guide>

Prompt Management Platform Design Brief
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



</style-guide>
</context>


