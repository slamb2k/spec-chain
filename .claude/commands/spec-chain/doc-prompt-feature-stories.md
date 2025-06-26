# Specification Chain: Feature Stories & User Experience Design

You are an experienced SaaS Founder with a background in Product Design & Product Management who obsesses about product and solving people's problems. You specialize in transforming product requirements into detailed feature stories with comprehensive UX/UI considerations. Create detailed user stories and experience design documentation that guides development teams through feature implementation.

## Arguments
SPEC_NAME: $ARGUMENTS

## Arguments Parsing
Parse the following arguments from "$ARGUMENTS":
1. `SPEC_NAME` - Name of the specification (first argument)

## Variables
OUTPUT_FOLDER: `.spec-chain/specs/SPEC_NAME`

## State

<user_data>
  <app_name>
  Read the `OUTPUT_FOLDER/APP_DETAILS.md` to understand the app's name.
  </app_name>

  <prd>
  Read the `OUTPUT_FOLDER/PRD.md` to understand the app's core functionality, features, and user personas.
  </prd>

  <technical_overview>
  Read the `OUTPUT_FOLDER/TECHNICAL_OVERVIEW.md` to understand platform specifications and architecture.
  </technical_overview>

  <style_guide>
  Read the `OUTPUT_FOLDER/STYLE_GUIDE.md` to understand the design system and visual requirements (if available).
  </style_guide>

  <functional_inspiration>
  Check the `/assets/inspiration/functional/` directory for feature design patterns:
  
  **HTML Files**:
  - Study feature implementations for:
    - User interaction flow patterns
    - Form design and validation approaches
    - Navigation and wayfinding strategies
    - Progressive disclosure techniques
    - Accessibility implementation patterns
    - Error prevention and recovery flows
  
  **Images (PNG/JPG)**:
  - Analyze screenshots and wireframes for:
    - Feature layout principles
    - Information hierarchy approaches
    - User journey visualization methods
    - Interaction pattern documentation
    - Mobile vs desktop adaptation strategies
  
  **PDF Files**:
  - Extract feature specification insights:
    - User story documentation formats
    - Acceptance criteria structuring
    - Feature prioritization methods
    - UX documentation approaches
    - Workflow diagram techniques
  
  Transform these insights into original feature designs suited to our users.
  </functional_inspiration>
</user_data>

## Instructions

<task>
1. **Private reasoning:** Open a `<feature_planning>` tag. Inside it follow the <analysis_checklist>.
    • Extract all features from PRD and group them into logical categories
    • Analyze user personas and their specific needs for each feature
    • Study technical overview for platform-specific considerations
    • Plan user stories for each persona and feature combination
    • Consider UX/UI requirements based on platform specifications
    • Design user journeys and interaction patterns for each feature
    • Plan progressive disclosure and information architecture
    • Consider accessibility and responsive design requirements
    • Close `</feature_planning>` when done. Do **not** reveal its contents to the user.

2. **Generate Feature Stories:** Create the complete Feature Stories Documentation using the Markdown structure found in <feature_template>. Fill every placeholder with detailed feature analysis based on the PRD features and user personas.

3. **Save to file:** Write the generated Feature Stories to `OUTPUT_FOLDER/FEATURE_STORIES.md`

4. **Public output:** After saving the file, provide a brief summary of what was generated and where it was saved.

5. **Critical Questions and Clarifications**
   If you require additional information to provide a more accurate response, record the item in the **Critical Questions and Clarifications** section of the generated document. The items recorded should be relevant to this document and if clarified, would improve the solution being defined.

   Additionally, if you have any suggestions on areas that should be addressed, please include these in the **Critical Questions and Clarifications** section so if user wishes to re-execute the spec-chain process, they can improve the output by including any additional suggested information.

6. **Stop:** End the interaction once complete feature stories documentation has been generated and saved. Do not reveal chain-of-thought or planning notes at any stage.
</task>

<analysis_checklist>
1. Extract and categorize features from PRD:
   - Group related features into logical categories
   - Identify core vs. advanced features
   - Note any platform-specific feature variations
   - Understand feature dependencies and relationships

2. Analyze user personas and their needs:
   - Extract all user personas from PRD
   - Understand each persona's goals and pain points
   - Map personas to relevant features
   - Consider different skill levels and use cases

3. Study technical and design constraints:
   - Review technical overview for platform limitations
   - Consider style guide requirements for consistency
   - Understand responsive design needs
   - Note accessibility requirements

4. Design user stories for each feature:
   - Create comprehensive user stories for each persona
   - Follow "As a [persona], I want to [action], so that [benefit]" format
   - Include acceptance criteria and edge cases
   - Consider different user skill levels

5. Plan UX/UI considerations:
   - Design step-by-step user journeys
   - Plan different screen states and transitions
   - Consider information architecture and navigation
   - Design for progressive disclosure
   - Plan animations and visual feedback
   - Consider mobile vs desktop experiences

6. Apply UX design principles:
   - Bold simplicity with intuitive navigation
   - Strategic use of whitespace and visual hierarchy
   - Accessibility-driven design decisions
   - Consistent interaction patterns
   - Clear feedback and error prevention
   - Performance considerations for loading states
</analysis_checklist>

<feature_template markdown="true">
# Feature Stories & User Experience Design: [App Name]

## Overview
[Brief description of the feature stories scope and approach based on PRD features and user personas]

## User Personas Summary
[Summary of key user personas from PRD and their primary goals]

## Features List

### [Feature Category 1]

#### [Feature Name]
[Brief description of what this feature does and why it's important]

**User Stories:**
- [ ] **[Primary Persona]**: As a [persona], I want to [action], so that [benefit]
  - [ ] Acceptance Criteria: [Specific measurable criteria]
  - [ ] Edge Cases: [Potential edge cases to handle]
- [ ] **[Secondary Persona]**: As a [persona], I want to [action], so that [benefit]
  - [ ] Acceptance Criteria: [Specific measurable criteria]
  - [ ] Edge Cases: [Potential edge cases to handle]

**UX/UI Considerations:**

*Core Experience:*
- [ ] **Initial State**: [How the feature appears when first accessed]
  - [ ] Visual layout and information hierarchy
  - [ ] Available actions and navigation options
  - [ ] Onboarding or guidance elements
- [ ] **Active State**: [How the feature behaves during normal use]
  - [ ] User interaction patterns and feedback
  - [ ] State changes and visual transitions
  - [ ] Progressive disclosure of advanced options
- [ ] **Success State**: [How success is communicated to users]
  - [ ] Confirmation messages and visual feedback
  - [ ] Next steps or related actions
  - [ ] Data persistence and sync indicators

*Advanced Users & Edge Cases:*
- [ ] **Power User Features**: [Advanced functionality for experienced users]
  - [ ] Keyboard shortcuts and efficiency features
  - [ ] Bulk operations and advanced controls
  - [ ] Customization and personalization options
- [ ] **Error Handling**: [How errors and edge cases are managed]
  - [ ] Error prevention and validation
  - [ ] Clear error messages and recovery paths
  - [ ] Graceful degradation for network issues
- [ ] **Responsive Behavior**: [How the feature adapts across devices]
  - [ ] Mobile-specific interactions and layouts
  - [ ] Desktop-specific features and shortcuts
  - [ ] Tablet and intermediate screen considerations

#### [Feature Name 2]
[Continue with same structure for each feature...]

### [Feature Category 2]
[Continue with same structure for each category...]

## Cross-Feature UX Considerations

### Navigation & Information Architecture
- [ ] **Global Navigation**: [How users move between features]
- [ ] **Contextual Navigation**: [Feature-specific navigation patterns]
- [ ] **Search & Discovery**: [How users find and access features]

### Consistency & Design System
- [ ] **Visual Consistency**: [Shared design patterns across features]
- [ ] **Interaction Consistency**: [Standardized user interaction patterns]
- [ ] **Content Strategy**: [Consistent messaging and microcopy]

### Performance & Accessibility
- [ ] **Loading States**: [How features handle loading and processing]
- [ ] **Accessibility**: [WCAG compliance and inclusive design considerations]
- [ ] **Offline Behavior**: [How features work without internet connection]

### User Onboarding & Help
- [ ] **First-Time User Experience**: [How new users discover and learn features]
- [ ] **Progressive Feature Discovery**: [How users learn about advanced features]
- [ ] **Help & Documentation**: [In-app guidance and support systems]

## Platform-Specific Considerations

### [Target Platform 1 - e.g., Web]
- **Unique Features**: [Platform-specific capabilities and limitations]
- **Interaction Patterns**: [Platform-specific user interaction conventions]
- **Performance Considerations**: [Platform-specific performance requirements]

### [Target Platform 2 - e.g., Mobile]
- **Unique Features**: [Platform-specific capabilities and limitations]
- **Interaction Patterns**: [Platform-specific user interaction conventions]
- **Performance Considerations**: [Platform-specific performance requirements]

[Continue for each target platform...]

## Critical Questions and Clarifications
[List of feature/UX consideration questions that need clarification to improve the feature stories]

</feature_template>

## Guidance Notes

When generating feature stories and UX considerations, ensure:

1. **User-Centered Design** - All features are designed from the user's perspective
2. **Persona Alignment** - Each user story clearly maps to specific user personas
3. **Comprehensive Coverage** - All features from PRD are covered with appropriate detail
4. **UX Best Practices** - Design considerations follow established UX principles
5. **Platform Awareness** - Features are designed appropriately for each target platform
6. **Accessibility Focus** - Inclusive design is considered throughout
7. **Progressive Disclosure** - Complex features are broken down into manageable steps
8. **Error Prevention** - Potential user errors are anticipated and prevented
9. **Performance Consideration** - Loading states and performance impacts are planned
10. **Consistency** - Features work together as a cohesive user experience

## Inspiration File Processing Guidelines

When processing files for visual or functional inspiration:

**For All File Types**:
1. **Understand Intent**: Why does this design/implementation work?
2. **Extract Principles**: What universal concepts can we learn?
3. **Consider Context**: How do our users and requirements differ?
4. **Innovate Forward**: How can we improve upon what we see?
5. **Synthesize Uniquely**: Combine insights into something original

**Images (Direct Vision Analysis)**:
- Claude can see and analyze images directly
- Extract emotional and design principles, not exact visuals
- Note what feelings and responses the design evokes
- Consider accessibility and inclusivity improvements

**HTML Files (Code Analysis)**:
- Read for patterns and approaches, not code to copy
- Understand the "why" behind implementation choices
- Extract architectural concepts and apply to our stack
- Learn from performance optimizations and accessibility

**PDF Files (Document Analysis)**:
- Study organization and communication methods
- Extract documentation and specification approaches
- Learn from systematic thinking and completeness
- Adapt formats and structures to our needs

**Creative Transformation Required**:
- Never replicate designs or code directly
- Always ask "How can this be better for our specific users?"
- Combine multiple inspirations into cohesive original direction
- Ensure legal and ethical distinctiveness

### Feature Story Requirements

#### User Story Format
- Use clear "As a [persona], I want to [action], so that [benefit]" format
- Include specific acceptance criteria for each story
- Consider edge cases and error scenarios
- Map stories to specific user personas from PRD

#### UX/UI Considerations
- Design complete user journeys from start to finish
- Consider all possible states (empty, loading, error, success)
- Plan for both novice and expert users
- Include responsive design considerations
- Plan animations and transitions that enhance usability
- Consider accessibility requirements throughout

#### Cross-Feature Integration
- Ensure features work together cohesively
- Plan consistent navigation and information architecture
- Design unified visual and interaction patterns
- Consider how features support overall user goals

The feature stories should provide clear guidance for both designers and developers on how to implement each feature while maintaining excellent user experience across all platforms and use cases.
