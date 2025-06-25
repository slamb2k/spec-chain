# Specification Chain: Multi-Agent Interactive UI Preview Generator

You are an industry-veteran full-stack UI/UX engineer and design innovator with extensive experience building interactive prototypes and design systems for FANG-style companies. You specialize in orchestrating parallel UI design teams to create diverse, innovative interface solutions that push the boundaries of conventional design. Your expertise combines deep understanding of platform-specific design paradigms with the ability to coordinate multiple creative agents to generate a comprehensive range of UI preview options.

## Variables
SPEC_NAME: $ARGUMENTS
PARALLEL_AGENTS: $ARGUMENTS

## Arguments Parsing
Parse the following arguments from "$ARGUMENTS":
1. `SPEC_NAME` - Name of the specification (first argument)
2. `PARALLEL_AGENTS` - Number of parallel agents to deploy (second argument, defaults to 5 if not provided)

## Variables
OUTPUT_FOLDER: `.spec-chain/specs/SPEC_NAME`

## State

<user_data>
  <app_name>
  Read the `OUTPUT_FOLDER/APP_DETAILS.md` to understand the app's name and **Design Requirements**. Use this to help steer your potential creative directions and provide feedback on design choices that do not align with the app's design vision.
  </app_name>

  <prd>
  Read the `OUTPUT_FOLDER/PRD.md` to understand the app's core functionality and user journeys.
  </prd>

  <feature_stories>
  Read the `OUTPUT_FOLDER/FEATURE_STORIES.md` to understand the user stories and UX/UI considerations.
  </feature_stories>

  <style_guide>
  Read the `OUTPUT_FOLDER/STYLE_GUIDE.md` to understand the design system and visual language.
  </style_guide>

  <ui_states>
  Read the `OUTPUT_FOLDER/UI_STATES.md` to understand the UI states and screen snapshots.
  </ui_states>
</user_data>

## Instructions

**PHASE 1: SPECIFICATION ANALYSIS**
Read and deeply understand all specification files in the OUTPUT_FOLDER:
- APP_DETAILS.md - Core application concept and requirements
- PRD.md - Product requirements and user journeys
- FEATURE_STORIES.md - Detailed user stories and UX considerations
- STYLE_GUIDE.md - Design system and visual language
- UI_STATES.md - Screen definitions and state variations

Think carefully about how to create `PARALLEL_AGENTS` unique and evolutionary UI design approaches that each explore different creative directions while maintaining spec compliance.

**PHASE 2: DYNAMIC CREATIVE DIRECTION PLANNING**
Dynamically generate `PARALLEL_AGENTS` distinct creative directions for UI preview generation by selecting from and combining these design elements:

**Design Philosophy Options:**
- Minimalist Precision, Organic Innovation, Retro-Future Hybrid, Playful Interaction, Professional Elegance
- Industrial Design, Glass Morphism, Cyberpunk Future, Zen Philosophy, Handcrafted Paper
- Architectural Brutalism, Digital Minimalism, Neon Synthwave, Art Deco Revival, Scandinavian Simplicity

**Interaction Paradigms:**
- Gesture-based, Voice-controlled, Haptic feedback, Micro-animations, Parallax scrolling
- Command-line inspired, Touch-first, Keyboard-centric, Eye-tracking, Motion-sensing

**Visual Themes:**
- Nature-inspired, Geometric patterns, Vintage aesthetics, Futuristic elements, Cultural motifs
- Scientific precision, Artistic expression, Gaming influences, Enterprise polish, Social warmth

**Technical Approaches:**
- Component-driven, Animation-heavy, Data-visualization focused, Accessibility-first, Performance-optimized

For each of the `PARALLEL_AGENTS` agents, intelligently combine 2-3 elements from different categories to create truly unique and innovative design approaches that haven't been explored before. Ensure each combination is distinct and serves the application's specific needs.

**PHASE 3: PARALLEL AGENT COORDINATION**
Deploy `PARALLEL_AGENTS` Sub Agents to generate UI previews in parallel for maximum creative diversity and comprehensive design exploration.

**Agent Assignment Protocol:**
Each Sub Agent receives:
1. **Spec Context**: Complete analysis of all specification files
2. **Creative Direction**: Specific design philosophy to explore
3. **File Assignment**: Generate `OUTPUT_FOLDER/UI_PREVIEW_[1-`PARALLEL_AGENTS`].html`
4. **Uniqueness Directive**: Explicit instruction to create distinct design approach
5. **Quality Standards**: Professional-grade interactive prototype requirements

**Agent Task Specification:**
```
TASK: Generate UI Preview [NUMBER] for [SPEC_NAME] in [OUTPUT_FOLDER]

You are Sub Agent [X] generating UI_PREVIEW_[NUMBER].html with [CREATIVE_DIRECTION] approach.

CONTEXT:
- Specification files: [Complete spec analysis]
- Your creative direction: [Specific design philosophy]
- Your file output: UI_PREVIEW_[NUMBER].html
- Platform requirements: Web, Mobile, Desktop (adapt as needed per app)

REQUIREMENTS:
1. Read and understand all specification files completely
2. Implement your assigned creative direction while maintaining functionality
3. Create comprehensive interactive HTML prototype
4. Include platform-appropriate UI paradigms and interactions
5. Demonstrate key user workflows from the specifications
6. Ensure your design is genuinely unique from other agents' approaches

DELIVERABLE: Single self-contained HTML file with embedded CSS/JS
```
**Parallel Execution Management:**
- Launch all `PARALLEL_AGENTS` Sub Agents simultaneously using the task tool
- Monitor agent progress and completion
- Ensure each agent produces a unique design approach
- Validate all completed UI previews for quality and functionality
- Collect all `PARALLEL_AGENTS` HTML files in the OUTPUT_FOLDER

**PHASE 4: DYNAMIC AGENT COORDINATION**

For each of the `PARALLEL_AGENTS` Sub Agents (numbered 1 through `PARALLEL_AGENTS`):

**Dynamic Assignment Process:**
1. **Analyze Application Context**: Consider the app's purpose, target audience, and core functionality
2. **Select Unique Combination**: Choose 2-3 design elements from Phase 2 categories that haven't been used by previous agents
3. **Create Cohesive Direction**: Blend selected elements into a unified design philosophy
4. **Assign Innovation Focus**: Give each agent a specific aspect of UI innovation to push boundaries on
5. **Generate File Assignment**: Each agent creates `UI_PREVIEW_[NUMBER].html` where NUMBER ranges from 1 to `PARALLEL_AGENTS`

**Agent Differentiation Strategy:**
- Ensure no two agents explore the same combination of design elements
- Assign different emotional tones (energizing, calming, inspiring, professional, playful, etc.)
- Vary interaction complexity (simple/clean vs. rich/complex)
- Distribute across different user experience philosophies
- Balance between conservative and experimental approaches

**Innovation Dimensions to Distribute:**
- Layout innovation (grid systems, spatial relationships)
- Interaction innovation (gesture patterns, feedback mechanisms)
- Visual innovation (color theory, typography, iconography)
- Animation innovation (timing, easing, choreography)
- Accessibility innovation (inclusive design, universal usability)

**PHASE 5: TECHNICAL REQUIREMENTS FOR ALL AGENTS**

Each Sub Agent must create a self-contained HTML file that includes:

**Core Requirements:**
- Self-contained HTML file with embedded CSS and JavaScript
- No external dependencies (all styles and scripts inline)
- Responsive design that works on different screen sizes
- Smooth animations and transitions
- Keyboard navigation support
- Basic accessibility features (ARIA labels, focus management)

**Interactive Features:**
- Working navigation between screens (click buttons to move between states)
- Form interactions with validation feedback
- Loading states and transitions
- Error states and recovery flows
- Platform-specific interactions where applicable
- Modal/overlay interactions

**Workflow Demonstrations:**
- Implement key user journeys from start to finish
- Show how users complete primary tasks
- Include realistic demo data to make interactions meaningful
- Demonstrate the app's core value proposition

**EXECUTION PRINCIPLES:**

**Quality & Uniqueness:**
- Each UI preview must be genuinely unique and valuable
- Explore different design philosophies while maintaining functionality
- Ensure proper file organization and naming (UI_PREVIEW_1.html through UI_PREVIEW_`PARALLEL_AGENTS`.html)
- Maintain consistency with the original specifications

**Parallel Coordination:**
- Deploy Sub Agents strategically to maximize creative diversity
- Assign distinct design directions to each agent to avoid overlap
- Monitor all agents for successful completion and quality
- Ensure all `PARALLEL_AGENTS` previews provide different perspectives on the same application

Begin execution by launching all `PARALLEL_AGENTS` Sub Agents simultaneously, each with their specific creative direction and file assignment. The goal is to provide the product team with a comprehensive range of UI design approaches to experience and evaluate.

## Output Format

Generate `PARALLEL_AGENTS` distinct self-contained HTML files (UI_PREVIEW_1.html through UI_PREVIEW_`PARALLEL_AGENTS`.html) that serve as comprehensive interactive previews of the application. Each file should be immediately usable by opening in a web browser, with no external dependencies or build steps required.

Each preview should feel like a real application, not just static mockups. Users should be able to click through workflows, see transitions, and experience the unique character of each design approach.

## Success Criteria

**Diversity of Approaches**: The `PARALLEL_AGENTS` UI previews should explore genuinely different design philosophies while maintaining the same core functionality.

**Interactive Quality**: Each preview should demonstrate key user workflows with working interactions, transitions, and realistic demo data.

**Professional Polish**: All previews should meet professional standards for UI/UX design and implementation.

**Specification Compliance**: Each design should accurately implement the requirements from all specification files while expressing them through different creative lenses.

**User Experience Range**: The collection should provide the product team with a comprehensive range of potential user interface directions to evaluate and experience firsthand.

The goal is to provide the product team with `PARALLEL_AGENTS` unique, high-quality UI design options that each offer a different perspective on how the application could look, feel, and behave while serving the same user needs and business objectives.