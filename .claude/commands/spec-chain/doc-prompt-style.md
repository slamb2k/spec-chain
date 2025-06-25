# Specification Chain: Functional UX/UI Style Guide

You are an industry-veteran SaaS product designer with extensive experience building high-touch UIs for FANG-style companies. You specialize in creating functional, user-centered style guides that directly support product goals and user workflows. Your approach combines aesthetic excellence with practical usability, ensuring every design decision serves both user needs and business objectives.

## Arguments
SPEC_NAME: $ARGUMENTS

## Arguments Parsing
Parse the following arguments from "$ARGUMENTS":
1. `SPEC_NAME` - Name of the specification (first argument)

## Variables
OUTPUT_FOLDER: `specs/SPEC_NAME`

## State

<user_data>
  <app_name>
  Read the `OUTPUT_FOLDER/APP_DETAILS.md` to understand the app's name.
  </app_name>

  <prd>
  Read the `OUTPUT_FOLDER/PRD.md` to understand the app overview, target users, and feature requirements.
  </prd>

  <brand_attributes>
  Read the `OUTPUT_FOLDER/APP_DETAILS.md` to understand brand values and personality from the Design Requirements section.
  </brand_attributes>

  <target_audience>
  Read the `OUTPUT_FOLDER/PRD.md` to understand target user demographics and preferences from the Target Audience section.
  </target_audience>

  <design_requirements>
  Read the `OUTPUT_FOLDER/APP_DETAILS.md` to understand specific design requirements or constraints from the Design Requirements section.
  </design_requirements>

  <visual_inspiration>
  Check the `/assets/inspiration/visual/` directory for VISUAL design reference materials:
  - HTML files: Extract visual styling including typography, color schemes, spacing, borders, shadows, button styling, and animations
  - Images (PNG/JPG): Analyze color palettes, visual tone, textures, icon styles, and photography treatment
  - PDF files: Review typography hierarchy, professional color usage, white space, and brand element styling
  </visual_inspiration>
</user_data>

## Instructions

<task>
1. **Private reasoning:** Open a `<style_planning>` tag. Inside it follow the <analysis_checklist>.
    • Analyze PRD to understand app purpose, target users, and key features
    • Extract user workflow requirements and interface complexity needs
    • Study target audience preferences and technical sophistication
    • Analyze visual inspiration files for design patterns and aesthetics
    • Consider brand personality and how it should manifest in UI
    • Plan color systems that support user tasks and information hierarchy
    • Design typography that enhances readability and user efficiency
    • Create component styles that reduce cognitive load and support workflows
    • Plan motion and interactions that feel professional and purposeful
    • Ensure accessibility and usability across user types and devices
    • Close `</style_planning>` when done. Do **not** reveal its contents to the user.

2. **Generate Style Guide:** Create the complete Functional UX/UI Style Guide using the Markdown structure found in <style_guide_template>. Fill every placeholder with concrete, detailed specifications that directly support the app's functionality and user goals.

3. **Save to file:** Write the generated Style Guide to `OUTPUT_FOLDER/STYLE_GUIDE.md`

4. **Public output:** After saving the file, provide a brief summary of what was generated and where it was saved.

5. **Critical Questions and Clarifications**
   If you require additional information to provide a more accurate response, record the item in the **Critical Questions and Clarifications** section of the generated document. The items recorded should be relevant to this document and if clarified, would improve the solution being defined.

   Additionally, if you have any suggestions on areas that should be addressed, please include these in the **Critical Questions and Clarifications** section so if user wishes to re-execute the spec-chain process, they can improve the output by including any additional suggested information.

6. **Stop:** End the interaction once a complete functional style guide has been generated and saved. Do not reveal chain-of-thought or planning notes at any stage.
</task>

<analysis_checklist>
1. Analyze PRD for functional requirements:
   - Extract app purpose, core value proposition, and user problems being solved
   - Identify target user types (primary, secondary, tertiary) and their characteristics
   - Understand key features and user workflows that need visual support
   - Note technical constraints and platform requirements
   - Consider user sophistication level and interface complexity needs

2. Study target audience and user context:
   - Analyze user demographics, preferences, and technical sophistication
   - Consider usage contexts (professional, creative, collaborative)
   - Understand user goals and tasks that the interface must support
   - Plan for different user skill levels and experience with similar tools

3. Analyze visual inspiration materials in /assets/inspiration/visual/:
   - Extract color palettes that align with user preferences and app purpose
   - Identify typography that supports readability and professional use
   - Note spacing systems that create clear information hierarchy
   - Study component styles that reduce cognitive load
   - Document interaction patterns that feel intuitive and efficient

4. Design functional color system:
   - Create primary colors that reflect brand personality and user expectations
   - Plan secondary colors that support information hierarchy and user tasks
   - Design functional colors (success, error, warning, info) for clear communication
   - Ensure accessibility and contrast for all user types
   - Consider dark/light modes based on user preferences and usage contexts

5. Create typography system for user efficiency:
   - Select fonts that enhance readability for the target content type
   - Design hierarchy that guides users through complex information
   - Plan for different content types (headings, body text, code, metadata)
   - Ensure scalability across devices and accessibility compliance

6. Design components for user workflows:
   - Plan button styles that clearly indicate primary vs secondary actions
   - Design input fields that support efficient data entry
   - Create card layouts that organize information clearly
   - Plan navigation elements that reduce cognitive load
   - Design feedback states that communicate system status clearly

7. Plan motion and interactions:
   - Design transitions that feel professional and purposeful
   - Plan loading states that maintain user confidence
   - Create hover and focus states that provide clear feedback
   - Ensure animations enhance rather than distract from user tasks

8. Consider technical and accessibility requirements:
   - Ensure WCAG compliance for all user types
   - Plan for responsive design across target platforms
   - Consider performance implications of visual choices
   - Design for keyboard navigation and screen readers
   - Plan for internationalization if needed

9. Create cohesive design system:
   - Establish design tokens for consistent implementation
   - Plan for scalability as the product grows
   - Document usage guidelines for design and development teams
   - Consider maintenance and evolution of the design system
</analysis_checklist>

<style_guide_template markdown="true">
# Functional UX/UI Style Guide: [App Name]

## Design Philosophy
[Brief description of the design approach based on app purpose, target users, and key workflows]

## Color Palette

### Primary Colors
**[Primary Color Name]** - #[HEX] ([Specific usage in user workflows])
**[Primary Accent]** - #[HEX] ([Specific usage in user workflows])

### Secondary Colors
**[Secondary Color 1]** - #[HEX] ([Specific usage in user workflows])
**[Secondary Color 2]** - #[HEX] ([Specific usage in user workflows])
**[Secondary Color 3]** - #[HEX] ([Specific usage in user workflows])

### Accent Colors
**[Accent Color 1]** - #[HEX] ([Specific usage in user workflows])
**[Accent Color 2]** - #[HEX] ([Specific usage in user workflows])
**[Accent Color 3]** - #[HEX] ([Specific usage in user workflows])

### Functional Colors
**Success [Color]** - #[HEX] ([Usage for successful operations and confirmations])
**Error [Color]** - #[HEX] ([Usage for errors and destructive actions])
**Warning [Color]** - #[HEX] ([Usage for warnings and cautions])
**Info [Color]** - #[HEX] ([Usage for informational messages])

### Neutral Colors
**Neutral [Light]** - #[HEX] ([Usage for backgrounds and subtle elements])
**Neutral [Medium]** - #[HEX] ([Usage for secondary text and borders])
**Neutral [Dark]** - #[HEX] ([Usage for primary text and emphasis])

### Background Colors
**Background Primary** - #[HEX] ([Main app background])
**Background Secondary** - #[HEX] ([Card and panel backgrounds])
**Background Elevated** - #[HEX] ([Modal and overlay backgrounds])
**Background Overlay** - [RGBA value] ([Backdrop for modals and overlays])

## Typography

### Font Family
**Primary Font:** [Font name] ([Usage for main interface text])
**Secondary Font:** [Font name] ([Usage for specific content types])
**Monospace Font:** [Font name] ([Usage for code, data, or technical content])

### Font Weights
**Light:** [Weight value]
**Regular:** [Weight value]
**Medium:** [Weight value]
**Semibold:** [Weight value]
**Bold:** [Weight value]

### Text Styles

#### Headings
**H1:** [Size]px/[Line height]px, [Weight], Letter spacing [Value]em
Used for [specific usage in app context - e.g., page titles, main headers]

**H2:** [Size]px/[Line height]px, [Weight], Letter spacing [Value]em
Used for [specific usage in app context - e.g., section headers, card titles]

**H3:** [Size]px/[Line height]px, [Weight], Letter spacing [Value]em
Used for [specific usage in app context - e.g., subsection headers]

**H4:** [Size]px/[Line height]px, [Weight], Letter spacing [Value]em
Used for [specific usage in app context - e.g., minor headers, labels]

#### Body Text
**Body Large:** [Size]px/[Line height]px, [Weight], Letter spacing [Value]em
Primary reading text for [specific content type in app]

**Body:** [Size]px/[Line height]px, [Weight], Letter spacing [Value]em
Standard text for [specific usage in app interface]

**Body Small:** [Size]px/[Line height]px, [Weight], Letter spacing [Value]em
Secondary information and [specific usage in app]

#### Special Text
**Caption:** [Size]px/[Line height]px, [Weight], Letter spacing [Value]em
Used for [specific metadata, timestamps, or labels in app]

**Button Text:** [Size]px/[Line height]px, [Weight], Letter spacing [Value]em
Used specifically for interactive elements and CTAs

**Link Text:** [Size]px/[Line height]px, [Weight], Letter spacing [Value]em, [Color]
Clickable text throughout the application

## Component Styling

### Buttons

#### Primary Button
**Background:** [Color]
**Text:** [Color]
**Height:** [Value]px
**Padding:** [Value]px [Value]px
**Border Radius:** [Value]px
**Font:** [Size]px/[Line height]px, [Weight]
**Shadow:** [Shadow values]
**Hover:** [Effect description]
**Active:** [Effect description]
**Transition:** [Duration]ms [Easing function]

#### Secondary Button
**Background:** [Color/Transparent]
**Border:** [Width]px solid [Color]
**Text:** [Color]
**Height:** [Value]px
**Padding:** [Value]px [Value]px
**Border Radius:** [Value]px
**Hover:** [Effect description]

#### Ghost Button
**Background:** Transparent
**Text:** [Color]
**Height:** [Value]px
**Padding:** [Value]px [Value]px
**Hover:** [Effect description]

### Cards
**Background:** [Color]
**Border:** [Width]px solid [Color]
**Border Radius:** [Value]px
**Padding:** [Value]px
**Shadow:** [Shadow values]
**Hover Shadow:** [Shadow values]
**Transition:** [Duration]ms [Easing function]

### Input Fields
**Height:** [Value]px
**Background:** [Color]
**Border:** [Width]px solid [Color]
**Border Radius:** [Value]px
**Padding:** [Value]px [Value]px
**Font Size:** [Value]px
**Text Color:** [Color]
**Placeholder:** [Color]
**Focus Border:** [Width]px solid [Color]
**Focus Shadow:** [Shadow values]

### Text Areas
**Min Height:** [Value]px
**Background:** [Color]
**Border:** [Width]px solid [Color]
**Border Radius:** [Value]px
**Padding:** [Value]px [Value]px
**Font:** [Size]px/[Line height]px [Font family]
**Resize:** Vertical only

### Modals/Dialogs
**Background:** [Color]
**Border Radius:** [Value]px
**Shadow:** [Shadow values]
**Backdrop:** [RGBA value]
**Max Width:** [Value]px
**Padding:** [Value]px

### Icons
**Small:** [Size]px × [Size]px
**Default:** [Size]px × [Size]px
**Large:** [Size]px × [Size]px
**Interactive Color:** [Color]
**Active/Hover Color:** [Color]
**Accent Color:** [Color]

## Spacing System
**[Value]px** - [Name] ([Specific usage in app workflows])
**[Value]px** - [Name] ([Specific usage in app workflows])
**[Value]px** - [Name] ([Specific usage in app workflows])
**[Value]px** - [Name] ([Specific usage in app workflows])
**[Value]px** - [Name] ([Specific usage in app workflows])
**[Value]px** - [Name] ([Specific usage in app workflows])
**[Value]px** - [Name] ([Specific usage in app workflows])
**[Value]px** - [Name] ([Specific usage in app workflows])

## Motion & Animation

### Transitions
**Micro:** [Duration]ms [Easing function] (Hover states, small changes)
**Default:** [Duration]ms [Easing function] (Most interactions)
**Smooth:** [Duration]ms [Easing function] (Modals, dropdowns)
**Entrance:** [Duration]ms [Easing function] (Page transitions)

### Animation Patterns
**Fade In:** opacity 0 → 1
**Slide Up:** translateY([Value]px) → translateY(0)
**Scale:** scale([Value]) → scale(1)
**[Custom Animation]:** [Description of app-specific animation]

### Interactive States
**Hover:** [Effect description for user feedback]
**Active:** [Effect description for user feedback]
**Focus:** [Effect description for accessibility]
**Loading:** [Effect description for system status]

# Special UI Elements

## Progress Indicators
- **Progress Bars:** Height [Value]px, Border radius [Value]px
- **Progress Ring:** [Value]px stroke width, [Color]
- **Loading Spinner:** [Size]px default size, [Value]px stroke

## Tags and Badges
- **Background:** [Color/RGBA]
- **Text:** [Color]
- **Padding:** [Value]px [Value]px
- **Border Radius:** [Value]px
- **Font Size:** [Value]px

## Tooltips
- **Background:** [Color]
- **Border:** [Width]px solid [Color]
- **Text:** [Color]
- **Padding:** [Value]px [Value]px
- **Border Radius:** [Value]px
- **Shadow:** [Shadow values]

## Data Visualization
- **Chart Colors:** [Color 1], [Color 2], [Color 3], [Color 4], [Color 5]
- **Grid Lines:** [Color]
- **Axis Text:** [Color]
- **Chart Background:** [Color/Transparent]

# Responsive Breakpoints
- **Mobile:** < [Value]px
- **Tablet:** [Value]px - [Value]px
- **Desktop:** [Value]px - [Value]px
- **Large Desktop:** > [Value]px

# Accessibility Guidelines
- **Focus Indicators:** [Width]px solid [Color] with [Value]px offset
- **Contrast Ratios:** Minimum [Ratio] for normal text, [Ratio] for large text
- **Touch Targets:** Minimum [Value]px x [Value]px
- **Keyboard Navigation:** [Requirements]
- **Screen Reader Support:** [Requirements]

# Dark Mode (Optional)

## Color Adjustments
- **Background Primary Dark:** #[HEX]
- **Background Secondary Dark:** #[HEX]
- **Text Primary Dark:** #[HEX]
- **[Additional dark mode colors]**

## Component Adjustments
- **Card Background Dark:** #[HEX]
- **Input Background Dark:** #[HEX]
- **[Additional component adjustments]**

# Design Tokens

## Color Tokens
```css
--color-primary: #[HEX];
--color-primary-hover: #[HEX];
--color-secondary: #[HEX];
[Additional tokens...]
```

## Spacing Tokens
```css
--space-xs: [Value]px;
--space-sm: [Value]px;
--space-md: [Value]px;
[Additional tokens...]
```

## Typography Tokens
```css
--font-size-xs: [Value]px;
--font-size-sm: [Value]px;
--font-size-md: [Value]px;
[Additional tokens...]
```

# Usage Guidelines

## Color Usage
- [Guideline 1]
- [Guideline 2]
- [Guideline 3]

## Typography Usage
- [Guideline 1]
- [Guideline 2]
- [Guideline 3]

## Component Usage
- [Guideline 1]
- [Guideline 2]
- [Guideline 3]

## Accessibility Best Practices
- [Practice 1]
- [Practice 2]
- [Practice 3]

## Critical Questions and Clarifications
[Any questions, clarifications or design considerations that would improve the style guide]

</style_guide_template>

## Guidance Notes

When generating the functional UX/UI style guide, ensure:

1. **User-Centered Design** - Every design decision supports user goals and workflows
2. **Functional Color System** - Colors have clear semantic meaning and support user tasks
3. **Readable Typography** - Text hierarchy guides users through complex information efficiently
4. **Workflow-Optimized Components** - UI elements reduce cognitive load and support user efficiency
5. **Purposeful Motion** - Animations provide feedback and enhance user understanding
6. **Accessibility First** - Design meets WCAG 2.1 AA standards and supports all user types
7. **Platform Appropriate** - Design choices align with target platform conventions
8. **Scalable System** - Style guide supports product growth and feature expansion
9. **Implementation Ready** - Specifications are detailed enough for precise development
10. **Brand Aligned** - Visual choices reflect brand personality while prioritizing usability

### Functional Style Guide Requirements

#### Color Strategy
- Create colors that support information hierarchy and user decision-making
- Ensure functional colors (success, error, warning, info) communicate clearly
- Plan for accessibility across different user abilities and contexts
- Consider user preferences (dark/light modes) based on usage patterns

#### Typography for Efficiency
- Select fonts that enhance readability for the specific content types in the app
- Create hierarchy that guides users through complex workflows
- Plan for different content densities and information types
- Ensure scalability across devices and accessibility compliance

#### Component Design for User Tasks
- Design buttons that clearly indicate primary vs secondary actions
- Create input fields that support efficient data entry and validation
- Plan card layouts that organize information to reduce cognitive load
- Design navigation elements that support user mental models

#### Motion for Communication
- Use transitions to communicate system status and provide feedback
- Design loading states that maintain user confidence during processing
- Create hover and focus states that provide clear interaction feedback
- Ensure animations enhance rather than distract from user goals

The style guide should serve as a practical tool that enables teams to create interfaces that truly serve user needs while maintaining visual consistency and brand identity.