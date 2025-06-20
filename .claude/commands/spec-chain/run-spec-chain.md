# Specification Chain: Runner

Execute the complete specification chain to generate comprehensive documentation for an app idea.

## Arguments

**Argument 1: Spec Name (Optional)**
- The name of the spec to create/update
- This becomes the output folder `/specs/<spec name>`
- If not supplied, defaults to timestamp format ("%Y%m%d_%H%M%S")
- If the folder already exists, its contents will be overwritten with newly generated documentation

**Argument 2: Start Phase (Optional)**
- The phase number to start execution from (1-5)
- Defaults to Phase 1 if not specified
- The system validates that all previous phase documents exist before proceeding
- If validation fails, the system will prompt to start from an earlier phase

## Usage Examples

**Basic usage (full generation with timestamp):**
```
@run-spec-chain
```
Creates: `/specs/20240120_143052/` with all documents

**Named spec (full generation):**
```
@run-spec-chain my-app
```
Creates: `/specs/my-app/` with all documents

**Resume from specific phase:**
```
@run-spec-chain my-app 3
```
Resumes generation from Phase 3 (Technical Architecture) in `/specs/my-app/`

**Update existing spec from Phase 2:**
```
@run-spec-chain existing-spec 2
```
Overwrites Phase 2+ documents in `/specs/existing-spec/`

## Overview

This runner orchestrates the execution of all 19 specification chain prompts in the correct order, managing dependencies and passing outputs between phases. The process transforms a single app idea into a complete documentation suite.

Each execution creates a directory under `/specs/` (e.g., `/specs/my-app/` or `/specs/20240120_143052/`) to:
- Preserve historical documentation versions
- Enable comparison between different generations
- Support iterative refinement without overwriting previous work
- Facilitate A/B testing of different approaches
- Maintain audit trail of documentation evolution

## Execution Flow

### Step 1: Load and Analyze Existing Data

1. **Check for existing APP_DETAILS.md:**
   - First, check if `/APP_DETAILS.md` exists in the project root
   - If it exists:
     - Read and parse all sections
     - Extract existing values for all fields
     - Identify which fields are empty or contain placeholder text
   - If it doesn't exist:
     - Start with an empty data structure
     - All fields will need to be gathered

2. **Identify missing information:**
   - Required fields that must have content:
     - App Name
     - App Idea (what problem it solves)
     - MVP Features (core functionality)
     - Target Users (primary users)
   - Optional fields that can be auto-researched:
     - Market Context
     - Competition
     - Business Model
     - Constraints
     - Platform
     - Technology Preferences
     - Performance Requirements
     - Scale Requirements
     - Brand Personality
     - Visual Style
     - Key Emotions
     - Accessibility Requirements
     - Core Workflows
     - Content Types
     - Feature Priorities
     - Integration Requirements
     - Success Metrics
     - Go-to-Market Strategy
     - Development Team
     - Additional Context

### Step 2: Gather Missing Required Fields

For each missing required field, ask ONE AT A TIME (skip if already has content):

1. **App Name** (if missing):
   "What is the name of your app?"

2. **App Idea** (if missing):
   "What problem does your app solve? Please provide a brief description."

3. **MVP Features** (if missing):
   "What are the core features for your minimum viable product (MVP)?"

4. **Target Users** (if missing):
   "Who is the primary target audience for your app?"

Wait for the user to answer each question before proceeding to the next.

### Step 2.5: Optional Fields Quick Decision

"Would you like to skip all optional fields? (yes/no or y/n)

If you skip, we'll use intelligent auto-research to fill these fields based on:
- Your app type and industry
- Best practices and modern standards
- Market research and competitive analysis

This often produces excellent results without manual input."

If "yes" or "y": Mark all optional fields for auto-research and skip to Step 4
If "no" or "n": Continue to Step 3 for individual optional fields

### Step 3: Offer Optional Fields Individually

For each field below, you can:
- Provide your own specific details (just type your answer)
- Type 'skip' or 's' to use auto-research for this field
- Type 'skip remaining' or 'sr' to use auto-research for all remaining fields

Auto-research will intelligently generate appropriate content based on your app context.

Quick shortcuts:
- s = skip (auto-research this field)
- sr = skip remaining (auto-research all remaining fields)
- y/n = yes/no responses

Note: Auto-research often produces high-quality results by:
- Analyzing similar successful apps in your market
- Applying industry best practices
- Generating contextually appropriate suggestions
- Ensuring consistency across all documentation

For each empty optional field, ask ONE AT A TIME:

1. **Market Context**: "Describe the market context and opportunity
   → Enter details (or 's'=skip, 'sr'=skip remaining - both use auto-research):"

2. **Competition**: "List key competitors
   → Enter details (or 's'=skip, 'sr'=skip remaining - both use auto-research):"

3. **Business Model**: "Specify the business model
   → Enter details (or 's'=skip, 'sr'=skip remaining - both use auto-research):"

4. **Constraints**: "List any business or technical constraints
   → Enter details (or 's'=skip, 'sr'=skip remaining - both use auto-research):"

5. **Platform**: "Specify the platform (Web/Mobile/Desktop)
   → Enter details (or 's'=skip, 'sr'=skip remaining - both use auto-research):"

6. **Technology Stack**: "Specify technology preferences
   → Enter details (or 's'=skip, 'sr'=skip remaining - both use auto-research):"

7. **Performance Requirements**: "Define performance requirements
   → Enter details (or 's'=skip, 'sr'=skip remaining - both use auto-research):"

8. **Scale Requirements**: "Specify scale requirements
   → Enter details (or 's'=skip, 'sr'=skip remaining - both use auto-research):"

9. **Brand Personality**: "Describe the brand personality
   → Enter details (or 's'=skip, 'sr'=skip remaining - both use auto-research):"

10. **Visual Style**: "Provide visual style guidelines
    → Enter details (or 's'=skip, 'sr'=skip remaining - both use auto-research):"

11. **Accessibility**: "Specify accessibility requirements
    → Enter details (or 's'=skip, 'sr'=skip remaining - both use auto-research):"

12. **Integration Requirements**: "List third-party integrations
    → Enter details (or 's'=skip, 'sr'=skip remaining - both use auto-research):"

13. **Success Metrics**: "Define success metrics
    → Enter details (or 's'=skip, 'sr'=skip remaining - both use auto-research):"

14. **Go-to-Market Strategy**: "Provide go-to-market details
    → Enter details (or 's'=skip, 'sr'=skip remaining - both use auto-research):"

15. **Development Team**: "Specify team structure
    → Enter details (or 's'=skip, 'sr'=skip remaining - both use auto-research):"

When processing responses:
- If user types 's' or 'skip': Mark field for auto-research and continue to next field
- If user types 'sr' or 'skip remaining': Mark all remaining fields for auto-research and proceed to Step 4
- Any other input: Use as the field value

### Step 4: Generate and Save APP_DETAILS.md

1. **Perform Auto-Research for Skipped Fields:**
   - If any optional fields were marked for auto-research, notify user: "Performing auto-research for skipped fields. This may take a moment..."
   - For each field marked for auto-research, generate appropriate content based on the app context:
     - **Market Context**: Research similar apps, market size, trends, and opportunities in the relevant industry
     - **Competition**: Identify 3-5 key competitors and their positioning
     - **Business Model**: Suggest appropriate monetization strategies based on app type and target users
     - **Constraints**: Identify common technical and business constraints for this type of application
     - **Platform**: Recommend optimal platform(s) based on target users and app functionality
     - **Technology Stack**: Suggest modern, appropriate technology choices for the platform and requirements
     - **Performance Requirements**: Set industry-standard performance targets for the app type
     - **Scale Requirements**: Estimate appropriate scale targets based on target market and business model
     - **Brand Personality**: Generate brand attributes that align with the app idea and target users
     - **Visual Style**: Suggest design approaches that match the brand personality and user expectations
     - **Accessibility Requirements**: Apply modern accessibility standards (WCAG 2.1 AA minimum)
     - **Integration Requirements**: Identify likely third-party services needed for the app functionality
     - **Success Metrics**: Define relevant KPIs based on the business model and user goals
     - **Go-to-Market Strategy**: Develop launch and growth strategies appropriate for the target market
     - **Development Team**: Recommend team structure based on technical requirements and project scope

2. **Combine all data:**
   - Merge existing data with newly gathered information
   - Include all auto-researched content as complete, detailed sections
   - Format according to the APP_DETAILS.md structure

3. **Save to output directory:**
   - Always save the complete APP_DETAILS.md to `$OUTPUT_DIR/APP_DETAILS.md`
   - This ensures all generation steps use the same data

4. **Offer to update root file:**
   - Ask: "Would you like to save/update the APP_DETAILS.md file in your project root directory for future runs? (yes/no)"
   - If yes, save the updated content to `/APP_DETAILS.md`
   - This allows iterative refinement across multiple runs

### Step 5: Proceed with Documentation Generation

The runner then uses **parallel Task agents** to execute independent prompts concurrently, significantly reducing total generation time:

```
Phase 1: Foundation (1 prompt)
    └── PRD.md

Phase 2: Business & Design (4 prompts - parallel)
    ├── GTM_STRATEGY.md
    ├── BUSINESS_RULES.md
    └── STYLE_GUIDE.md

Phase 2.1: Design Dependencies (1 prompt - sequential)
    └── WIREFRAMES.md (depends on Style Guide)

Phase 2.2: Design Completion (3 prompts - parallel)
    ├── USER_FLOWS.md
    ├── INFORMATION_ARCHITECTURE.md
    └── COMPONENT_LIBRARY.md

Phase 3: Technical Architecture (1 prompt - sequential)
    └── TECHNICAL_SPEC.md (depends on User Flows & IA)

Phase 3.1: Technical Dependencies (5 prompts - parallel)
    ├── API_SPEC.md
    ├── DATA_MODEL.md
    ├── SECURITY_ARCHITECTURE.md
    ├── INTEGRATIONS.md
    └── PERFORMANCE_SCALABILITY.md

Phase 4: Interactive Preview (1 prompt - sequential)
    └── INTERACTIVE_PREVIEW.html (depends on all design docs)

Phase 5: Implementation & Operations (1 prompt - sequential)
    └── IMPLEMENTATION_PLAN.md (depends on all technical docs)

Phase 5.1: Final Documents (3 prompts - parallel)
    ├── TESTING_STRATEGY.md
    ├── DEVOPS_DEPLOYMENT.md
    └── ONBOARDING_TRAINING.md
```

Total: 19 documents generated across 8 phases, with parallel execution reducing time by ~60%

## Prerequisites

1. Ensure all doc-prompt-*.md prompt files are present in the `.claude/commands/spec-chain/` directory
2. APP_DETAILS.md is optional - the system will:
   - Use existing `/APP_DETAILS.md` if present
   - Ask questions to gather missing information
   - Auto-research optional fields if not provided
3. Optionally, organize inspiration materials:
   - Place visual references in `/assets/inspiration/visual/` (colors, styles, typography, effects)
   - Place functional references in `/assets/inspiration/functional/` (layouts, workflows, interactions)

## Input Source

All input data is read from the `APP_DETAILS.md` file which contains:
- Basic Information (App Name, Idea, MVP Features)
- Target Users (Primary and Secondary)
- Business Context (Market, Competition, Model, Constraints)
- Technical Requirements (Platform, Technology, Performance, Scale)
- Design Requirements (Brand, Visual Style, Emotions, Accessibility)
- Feature Details (Workflows, Content Types, Priorities)
- Integration Requirements
- Success Metrics
- Go-to-Market Strategy
- Additional Context

## Execution Instructions

### Preparation Step

0. **Initialize Generation Environment**
   - **Process Arguments:**
     - Generate timestamp once: `TIMESTAMP=$(date +"%Y%m%d_%H%M%S")`
     - `SPEC_NAME`: First argument (spec name) or use `$TIMESTAMP` if not provided
     - `START_PHASE`: Second argument (phase number) or default to 1 if not provided
   - **Set Output Directory:**
     - Set `OUTPUT_DIR=/specs/$SPEC_NAME`
     - Create output directory: `mkdir -p $OUTPUT_DIR`
     - If directory exists and contains files, log: "Overwriting existing spec directory: $OUTPUT_DIR"
   - **Initialize Data Sources:**
     - **Validate APP_DETAILS.md Structure:**
       - Check if `/APP_DETAILS.md.template` exists
       - If template exists, validate `/APP_DETAILS.md` structure against template
       - Extract section headers from template (excluding warning block): `sed '/^<!--$/,/^-->$/d' /APP_DETAILS.md.template | grep -E '^##|^###' | sort`
       - Extract section headers from current APP_DETAILS.md: `grep -E '^##|^###' /APP_DETAILS.md | sort`
       - Find missing sections: `comm -23 <(template_sections) <(current_sections)`
       - If missing sections found:
         - Log: "⚠️ Missing sections detected in APP_DETAILS.md"
         - Create backup: `cp /APP_DETAILS.md /APP_DETAILS.md.backup`
         - Append missing sections from template to APP_DETAILS.md
         - Log: "✅ Missing sections restored from template. Backup saved as APP_DETAILS.md.backup"
       - If no missing sections: Log: "✅ APP_DETAILS.md structure is complete"
     - Read APP_DETAILS from either `$OUTPUT_DIR/APP_DETAILS.md` (if newly created) or `/APP_DETAILS.md` (if existing)
     - Extract all sections for use in subsequent prompts
     - If `/assets/inspiration/visual/` directory exists, list its contents for visual design prompts
     - If `/assets/inspiration/functional/` directory exists, list its contents for functional design prompts

0.1. **Document Relevance Analysis**
   - **Analyze App Characteristics from APP_DETAILS:**
     - Extract Platform information (Web/Mobile/Desktop/Terminal)
     - Extract App Type indicators from App Idea and MVP Features:
       - **UI-focused**: Keywords like "interface", "user experience", "dashboard", "mobile app", "web app"
       - **API-focused**: Keywords like "API", "service", "backend", "microservice", "integration"
       - **CLI-focused**: Keywords like "command line", "terminal", "CLI", "script", "automation"
       - **Data-focused**: Keywords like "database", "analytics", "reporting", "data processing"
     - Extract Architecture indicators from Technical Requirements and MVP Features:
       - **Client-Server**: Multiple platforms, user authentication, data persistence
       - **Standalone**: Single platform, local data, no external dependencies
       - **Service-Only**: API endpoints, no user interface, integration focus
       - **Hybrid**: Mix of UI and API components

   - **Determine Required Documents:**
     ```
     REQUIRED_DOCS=("PRD")  # Always required

     # Business Documents (always relevant for commercial apps)
     if [MVP Features or Business Context indicates commercial/business app]; then
         REQUIRED_DOCS+=("GTM_STRATEGY" "BUSINESS_RULES")
     fi

     # UI/UX Documents (only for apps with user interfaces)
     if [Platform includes Web/Mobile/Desktop] OR [App Type is UI-focused]; then
         REQUIRED_DOCS+=("STYLE_GUIDE" "WIREFRAMES" "USER_FLOWS" "INFORMATION_ARCHITECTURE" "COMPONENT_LIBRARY" "INTERACTIVE_PREVIEW")
     fi

     # API Documents (only for apps with APIs or multi-client architecture)
     if [App Type is API-focused] OR [Platform includes multiple platforms] OR [Features indicate client-server architecture]; then
         REQUIRED_DOCS+=("API_SPEC")
     fi

     # Data Documents (only for apps with persistent data)
     if [Features indicate data storage/management] OR [App Type is Data-focused]; then
         REQUIRED_DOCS+=("DATA_MODEL")
     fi

     # Technical Documents (always required for development)
     REQUIRED_DOCS+=("TECHNICAL_SPEC" "IMPLEMENTATION_PLAN" "TESTING_STRATEGY")

     # Infrastructure Documents (only for deployed/distributed apps)
     if [Platform includes Web] OR [App Type is API-focused] OR [Features indicate deployment/hosting]; then
         REQUIRED_DOCS+=("SECURITY_ARCHITECTURE" "PERFORMANCE_SCALABILITY" "DEVOPS_DEPLOYMENT")
     fi

     # Integration Documents (only for apps with external dependencies)
     if [Features indicate third-party integrations] OR [App Type is API-focused]; then
         REQUIRED_DOCS+=("INTEGRATIONS")
     fi

     # Training Documents (only for apps with end users)
     if [Platform includes Web/Mobile/Desktop] OR [App Type is UI-focused]; then
         REQUIRED_DOCS+=("ONBOARDING_TRAINING")
     fi
     ```

   - **Log Document Selection:**
     - Log: "Document Relevance Analysis Complete:"
     - Log: "App Type: [UI-focused/API-focused/CLI-focused/Data-focused]"
     - Log: "Architecture: [Client-Server/Standalone/Service-Only/Hybrid]"
     - Log: "Required Documents (${#REQUIRED_DOCS[@]}): ${REQUIRED_DOCS[*]}"
     - Log: "Skipped Documents: [list of documents not in REQUIRED_DOCS]"

   - **Phase Validation (Updated):**
     - If `START_PHASE > 1`, validate that all required documents from previous phases exist
     - Only validate documents that are in REQUIRED_DOCS array
     - If validation fails, display missing documents and prompt: "Missing required documents for Phase X. Would you like to start from Phase Y instead? (y/n)"
     - If user chooses 'n', exit with error. If 'y', update `START_PHASE` to the suggested phase.

   - Log: "Starting documentation generation in $OUTPUT_DIR from Phase $START_PHASE (timestamp: $TIMESTAMP)"

### Phase 1: Foundation (Required)

**Execute only if START_PHASE <= 1:**

1. **Generate Product Requirements Document**
   - Read `/project:.claude/commands/spec-chain/doc-prompt-prd.md` as PRD_PROMPT
   - Replace placeholders in PRD_PROMPT with data from APP_DETAILS:
     - [APP NAME] → Extract from "App Name" section
     - [BRIEF DESCRIPTION OF THE APP CONCEPT, TARGET MARKET, AND CORE VALUE PROPOSITION] → Extract from "App Idea" section
     - [LIST OF MINIMUM VIABLE PRODUCT FEATURES AND CORE FUNCTIONALITY] → Extract from "MVP Features" section
     - [PRIMARY AND SECONDARY USER PERSONAS, THEIR ROLES, AND NEEDS] → Extract from "Target Users" section
     - [MARKET CONTEXT, COMPETITION, BUSINESS MODEL, OR CONSTRAINTS] → Extract from "Business Context" section (now complete from auto-research)
   - Execute PRD_PROMPT and save output to `$OUTPUT_DIR/PRD.md`
   - This document becomes the foundation for all others

### Phase 2: Business & Design (Parallel Execution)

**Execute only if START_PHASE <= 2:**

**Execute the following tasks in parallel using concurrent Task agents (only if required):**

2. **Generate Go-to-Market Strategy** (Business Track)
   - **Execute only if "GTM_STRATEGY" is in REQUIRED_DOCS**
   - Read `/project:.claude/commands/spec-chain/doc-prompt-gtm.md` as GTM_PROMPT
   - Read `$OUTPUT_DIR/PRD.md` content
   - Replace in GTM_PROMPT:
     - [APP NAME] → Extract from APP_DETAILS "App Name"
     - [TARGET MARKET] → Extract from APP_DETAILS "Target Market" (now complete from auto-research)
     - [VALUE PROPOSITION] → Extract from APP_DETAILS "Value Proposition" (now complete from auto-research)
     - [COMPETITIVE LANDSCAPE] → Extract from APP_DETAILS "Competition" (now complete from auto-research)
     - [BUSINESS MODEL] → Extract from APP_DETAILS "Business Model" (now complete from auto-research)
   - Execute GTM_PROMPT and save output to `$OUTPUT_DIR/GTM_STRATEGY.md`

3. **Generate Business Rules** (Business Track)
   - **Execute only if "BUSINESS_RULES" is in REQUIRED_DOCS**
   - Read `/project:.claude/commands/spec-chain/doc-prompt-business-rules.md` as BUSINESS_RULES_PROMPT
   - Read `$OUTPUT_DIR/PRD.md` content
   - Replace in BUSINESS_RULES_PROMPT:
     - [APP NAME] → Extract from PRD
     - [INDUSTRY AND BUSINESS CONTEXT] → Extract from PRD
     - [KEY BUSINESS PROCESSES TO AUTOMATE] → Extract from PRD features
     - [REGULATORY AND BUSINESS CONSTRAINTS] → Infer from PRD
     - [KEY DECISION MAKERS AND THEIR NEEDS] → Extract from PRD stakeholders
   - Execute BUSINESS_RULES_PROMPT and save output to `$OUTPUT_DIR/BUSINESS_RULES.md`

4. **Generate Style Guide** (Design Track)
   - **Execute only if "STYLE_GUIDE" is in REQUIRED_DOCS**
   - Read `/project:.claude/commands/spec-chain/doc-prompt-style.md` as STYLE_PROMPT
   - Read `$OUTPUT_DIR/PRD.md` content
   - Replace in STYLE_PROMPT:
     - [APP NAME] → Extract from APP_DETAILS "App Name"
     - [BRAND VALUES AND PERSONALITY] → Extract from APP_DETAILS "Brand Personality" (now complete from auto-research)
     - [TARGET USER DEMOGRAPHICS AND PREFERENCES] → Extract from APP_DETAILS "Target Users" section
     - [ANY SPECIFIC DESIGN REQUIREMENTS OR CONSTRAINTS] → Extract from APP_DETAILS "Accessibility Requirements" (now complete from auto-research)
     - [LIST OF FILES IN /assets/inspiration/visual/] → List files from visual inspiration directory if it exists
   - Execute STYLE_PROMPT and save output to `$OUTPUT_DIR/STYLE_GUIDE.md`

### Phase 2.1: Design Dependencies (Sequential after Phase 2)

**Execute only if START_PHASE <= 2:**

5. **Generate Wireframes** (Depends on Style Guide)
   - **Execute only if "WIREFRAMES" is in REQUIRED_DOCS**
   - Wait for Style Guide completion from Phase 2 (if Style Guide was generated)
   - Read `/project:.claude/commands/spec-chain/doc-prompt-wireframes.md` as WIREFRAMES_PROMPT
   - Read `$OUTPUT_DIR/PRD.md` and `$OUTPUT_DIR/STYLE_GUIDE.md` content (if Style Guide exists)
   - Replace in WIREFRAMES_PROMPT:
     - [APP NAME] → Extract from PRD
     - [PRODUCT REQUIREMENTS DOCUMENT OR FEATURE LIST] → Use PRD.md content
     - [STYLE GUIDE OR DESIGN SYSTEM REFERENCE] → Use STYLE_GUIDE.md content (or default if not available)
     - [USER FLOWS OR KEY JOURNEYS] → Extract from PRD user journeys
     - [TARGET PLATFORMS: WEB/MOBILE/DESKTOP/TERMINAL - specify which platforms are required] → Extract from PRD Platform Requirements section
     - [LIST OF FILES IN /assets/inspiration/functional/] → List files from functional inspiration directory if it exists
   - Execute WIREFRAMES_PROMPT and save output to `$OUTPUT_DIR/WIREFRAMES.md`

### Phase 2.2: Design Completion (Parallel after Wireframes)

**Execute only if START_PHASE <= 2:**

**Execute the following tasks in parallel using concurrent Task agents (only if required):**

6. **Generate User Flows** (Depends on Wireframes)
   - **Execute only if "USER_FLOWS" is in REQUIRED_DOCS**
   - Read `/project:.claude/commands/spec-chain/doc-prompt-user-flows.md` as USER_FLOWS_PROMPT
   - Read `$OUTPUT_DIR/PRD.md` and `$OUTPUT_DIR/WIREFRAMES.md` content (if Wireframes exists)
   - Replace in USER_FLOWS_PROMPT:
     - [APP NAME] → Extract from PRD
     - [USER PERSONAS] → Extract from PRD
     - [KEY WORKFLOWS] → Extract from PRD features
     - [SCREEN REFERENCES] → Extract from Wireframes (or PRD if Wireframes not available)
     - [BUSINESS GOALS] → Extract from PRD
   - Execute USER_FLOWS_PROMPT and save output to `$OUTPUT_DIR/USER_FLOWS.md`

7. **Generate Information Architecture**
   - **Execute only if "INFORMATION_ARCHITECTURE" is in REQUIRED_DOCS**
   - Read `/project:.claude/commands/spec-chain/doc-prompt-ia.md` as IA_PROMPT
   - Read `$OUTPUT_DIR/PRD.md`, `$OUTPUT_DIR/WIREFRAMES.md` content (if available)
   - Replace in IA_PROMPT:
     - [APP NAME] → Extract from PRD
     - [CONTENT TYPES] → Extract from PRD data model
     - [USER ROLES] → Extract from PRD
     - [KEY FEATURES] → Extract from PRD
     - [NAVIGATION PATTERNS] → Extract from Wireframes (or infer from PRD if not available)
   - Execute IA_PROMPT and save output to `$OUTPUT_DIR/INFORMATION_ARCHITECTURE.md`

8. **Generate Component Library**
   - **Execute only if "COMPONENT_LIBRARY" is in REQUIRED_DOCS**
   - Read `/project:.claude/commands/spec-chain/doc-prompt-component-library.md` as COMPONENTS_PROMPT
   - Read `$OUTPUT_DIR/STYLE_GUIDE.md` and `$OUTPUT_DIR/WIREFRAMES.md` content (if available)
   - Replace in COMPONENTS_PROMPT:
     - [APP NAME] → Extract from PRD
     - [DESIGN TOKENS] → Extract from Style Guide (or use defaults if not available)
     - [COMPONENT LIST] → Extract from Wireframes (or infer from PRD if not available)
     - [INTERACTION PATTERNS] → Extract from Style Guide (or use defaults if not available)
     - [ACCESSIBILITY REQUIREMENTS] → Standard WCAG AA
   - Execute COMPONENTS_PROMPT and save output to `$OUTPUT_DIR/COMPONENT_LIBRARY.md`

### Phase 3: Technical Architecture (Sequential after Phase 2.2)

**Execute only if START_PHASE <= 3:**

9. **Generate Technical Specification**
   - Wait for User Flows and Information Architecture completion from Phase 2.2
   - Read `/project:.claude/commands/spec-chain/doc-prompt-technical.md` as TECHNICAL_PROMPT
   - Read `$OUTPUT_DIR/PRD.md`, `$OUTPUT_DIR/USER_FLOWS.md`, and `$OUTPUT_DIR/INFORMATION_ARCHITECTURE.md` content
   - Replace in TECHNICAL_PROMPT:
     - [APP NAME] → Extract from APP_DETAILS "App Name"
     - [FUNCTIONAL REQUIREMENTS] → Extract from PRD
     - [SCALE REQUIREMENTS] → Extract from APP_DETAILS "Scale Requirements" (now complete from auto-research)
     - [PERFORMANCE TARGETS] → Extract from APP_DETAILS "Performance Requirements" (now complete from auto-research)
     - [SECURITY NEEDS] → Extract from APP_DETAILS "Constraints" (now complete from auto-research)
   - Execute TECHNICAL_PROMPT and save output to `$OUTPUT_DIR/TECHNICAL_SPEC.md`

### Phase 3.1: Technical Dependencies (Parallel after Technical Spec)

**Execute only if START_PHASE <= 3:**

**Execute the following tasks in parallel using concurrent Task agents (only if required):**

10. **Generate API Specification**
    - **Execute only if "API_SPEC" is in REQUIRED_DOCS**
    - Read `/project:.claude/commands/spec-chain/doc-prompt-api.md` as API_PROMPT
    - Read `$OUTPUT_DIR/TECHNICAL_SPEC.md` and `$OUTPUT_DIR/PRD.md` content
    - Replace in API_PROMPT:
      - [APP NAME] → Extract from PRD
      - [API RESOURCES] → Extract from Technical Spec data model
      - [AUTHENTICATION METHOD] → Extract from Technical Spec
      - [API OPERATIONS] → Extract from PRD features
      - [INTEGRATION REQUIREMENTS] → Extract from Technical Spec
    - Execute API_PROMPT and save output to `$OUTPUT_DIR/API_SPEC.md`

11. **Generate Data Model**
    - **Execute only if "DATA_MODEL" is in REQUIRED_DOCS**
    - Read `/project:.claude/commands/spec-chain/doc-prompt-data-model.md` as DATA_MODEL_PROMPT
    - Read `$OUTPUT_DIR/TECHNICAL_SPEC.md` and `$OUTPUT_DIR/PRD.md` content
    - Replace in DATA_MODEL_PROMPT:
      - [APP NAME] → Extract from PRD
      - [ENTITIES] → Extract from PRD and Technical Spec
      - [RELATIONSHIPS] → Extract from PRD data model
      - [DATA VOLUMES] → Extract from Technical Spec
      - [PERFORMANCE REQUIREMENTS] → Extract from Technical Spec
    - Execute DATA_MODEL_PROMPT and save output to `$OUTPUT_DIR/DATA_MODEL.md`

12. **Generate Security Architecture**
    - **Execute only if "SECURITY_ARCHITECTURE" is in REQUIRED_DOCS**
    - Read `/project:.claude/commands/spec-chain/doc-prompt-security.md` as SECURITY_PROMPT
    - Read `$OUTPUT_DIR/TECHNICAL_SPEC.md` and `$OUTPUT_DIR/BUSINESS_RULES.md` content (if available)
    - Replace in SECURITY_PROMPT:
      - [APP NAME] → Extract from PRD
      - [DATA SENSITIVITY] → Extract from Business Rules (or infer from PRD if not available)
      - [COMPLIANCE REQUIREMENTS] → Extract from Business Rules (or infer from PRD if not available)
      - [USER ROLES] → Extract from PRD
      - [AUTHENTICATION NEEDS] → Extract from Technical Spec
    - Execute SECURITY_PROMPT and save output to `$OUTPUT_DIR/SECURITY_ARCHITECTURE.md`

13. **Generate Integrations Specification**
    - **Execute only if "INTEGRATIONS" is in REQUIRED_DOCS**
    - Read `/project:.claude/commands/spec-chain/doc-prompt-integrations.md` as INTEGRATIONS_PROMPT
    - Read `$OUTPUT_DIR/TECHNICAL_SPEC.md` and `$OUTPUT_DIR/PRD.md` content
    - Replace in INTEGRATIONS_PROMPT:
      - [APP NAME] → Extract from PRD
      - [EXTERNAL SERVICES] → Extract from Technical Spec
      - [INTEGRATION POINTS] → Extract from Technical Spec
      - [DATA FLOWS] → Extract from Technical Spec
      - [AUTHENTICATION METHODS] → Extract from Technical Spec
    - Execute INTEGRATIONS_PROMPT and save output to `$OUTPUT_DIR/INTEGRATIONS.md`

14. **Generate Performance & Scalability Plan**
    - **Execute only if "PERFORMANCE_SCALABILITY" is in REQUIRED_DOCS**
    - Read `/project:.claude/commands/spec-chain/doc-prompt-performance.md` as PERFORMANCE_PROMPT
    - Read `$OUTPUT_DIR/TECHNICAL_SPEC.md`, `$OUTPUT_DIR/PRD.md`, and `$OUTPUT_DIR/GTM_STRATEGY.md` content (if available)
    - Replace in PERFORMANCE_PROMPT:
      - [APP NAME] → Extract from PRD
      - [USER COUNTS, TRANSACTION VOLUMES, DATA SIZES] → Extract from GTM Strategy (or estimate from PRD if not available)
      - [RESPONSE TIME TARGETS, THROUGHPUT NEEDS] → Extract from Technical Spec
      - [TECHNOLOGY CHOICES AFFECTING PERFORMANCE] → Extract from Technical Spec
      - [EXPECTED GROWTH OVER 1-3 YEARS] → Extract from GTM Strategy (or estimate from PRD if not available)
    - Execute PERFORMANCE_PROMPT and save output to `$OUTPUT_DIR/PERFORMANCE_SCALABILITY.md`

### Phase 4: Interactive Preview (Sequential after Phase 3.1)

**Execute only if START_PHASE <= 4:**

15. **Generate Interactive Preview** (Depends on Design + Technical)
    - **Execute only if "INTERACTIVE_PREVIEW" is in REQUIRED_DOCS**
    - Wait for all required Design and Technical documents to complete
    - Read `/project:.claude/commands/spec-chain/doc-prompt-preview.md` as PREVIEW_PROMPT
    - Read available documents: `$OUTPUT_DIR/PRD.md`, `$OUTPUT_DIR/WIREFRAMES.md`, `$OUTPUT_DIR/STYLE_GUIDE.md`, `$OUTPUT_DIR/COMPONENT_LIBRARY.md`, `$OUTPUT_DIR/USER_FLOWS.md` content (only if they exist)
    - Replace in PREVIEW_PROMPT:
      - [APP NAME] → Extract from PRD
      - [PRODUCT REQUIREMENTS DOCUMENT WITH PLATFORM SPECIFICATIONS] → Use PRD.md content
      - [STYLE GUIDE WITH COLORS, TYPOGRAPHY, COMPONENTS] → Use STYLE_GUIDE.md content (or defaults if not available)
      - [WIREFRAME SPECIFICATIONS AND LAYOUTS] → Use WIREFRAMES.md content (or infer from PRD if not available)
      - [USER FLOW DEFINITIONS AND INTERACTIONS] → Use USER_FLOWS.md content (or infer from PRD if not available)
      - [COMPONENT SPECIFICATIONS AND BEHAVIORS] → Use COMPONENT_LIBRARY.md content (or defaults if not available)
      - [NAVIGATION STRUCTURE AND ORGANIZATION] → Extract from Information Architecture (or infer from PRD if not available)
      - [LIST OF FILES IN /assets/inspiration/visual/] → List files from visual inspiration directory if it exists
      - [LIST OF FILES IN /assets/inspiration/functional/] → List files from functional inspiration directory if it exists
    - Execute PREVIEW_PROMPT and save output to `$OUTPUT_DIR/INTERACTIVE_PREVIEW.html`

### Phase 5: Implementation & Operations (Sequential after Phase 3.1)

**Execute only if START_PHASE <= 5:**

16. **Generate Implementation Plan** (AI-Optimized)
    - Wait for all Technical documents from Phase 3.1 to complete
    - Read `/project:.claude/commands/spec-chain/doc-prompt-implementation.md` as IMPLEMENTATION_PROMPT
    - Read `$OUTPUT_DIR/TECHNICAL_SPEC.md`, `$OUTPUT_DIR/API_SPEC.md`, `$OUTPUT_DIR/DATA_MODEL.md`, and all other technical docs
    - Replace in IMPLEMENTATION_PROMPT:
      - [APP NAME] → Extract from PRD
      - [TECHNICAL REQUIREMENTS] → Extract from Technical Spec
      - [FEATURES TO IMPLEMENT] → Extract from PRD
      - [ARCHITECTURE DECISIONS] → Extract from Technical Spec
      - [TEAM STRUCTURE] → Standard small team
    - Execute IMPLEMENTATION_PROMPT and save output to `$OUTPUT_DIR/IMPLEMENTATION_PLAN.md`

### Phase 5.1: Final Documents (Parallel after Implementation Plan)

**Execute only if START_PHASE <= 5:**

**Execute the following tasks in parallel using concurrent Task agents (only if required):**

17. **Generate Testing Strategy**
    - **Execute only if "TESTING_STRATEGY" is in REQUIRED_DOCS**
    - Read `/project:.claude/commands/spec-chain/doc-prompt-testing.md` as TESTING_PROMPT
    - Read available documents: `$OUTPUT_DIR/TECHNICAL_SPEC.md`, `$OUTPUT_DIR/API_SPEC.md`, `$OUTPUT_DIR/USER_FLOWS.md`, `$OUTPUT_DIR/SECURITY_ARCHITECTURE.md`, and `$OUTPUT_DIR/IMPLEMENTATION_PLAN.md` content (only if they exist)
    - Replace in TESTING_PROMPT:
      - [APP NAME] → Extract from PRD
      - [FRONTEND AND BACKEND TECHNOLOGIES] → Extract from Technical Spec
      - [KEY FEATURES REQUIRING TESTING] → Extract from PRD
      - [PERFORMANCE, SECURITY, ACCESSIBILITY STANDARDS] → Extract from various specs (or use defaults if not available)
      - [DEVELOPMENT TEAM SIZE AND ROLES] → Extract from Implementation Plan
    - Execute TESTING_PROMPT and save output to `$OUTPUT_DIR/TESTING_STRATEGY.md`

18. **Generate DevOps & Deployment Plan**
    - **Execute only if "DEVOPS_DEPLOYMENT" is in REQUIRED_DOCS**
    - Read `/project:.claude/commands/spec-chain/doc-prompt-devops.md` as DEVOPS_PROMPT
    - Read available documents: `$OUTPUT_DIR/TECHNICAL_SPEC.md`, `$OUTPUT_DIR/PERFORMANCE_SCALABILITY.md`, `$OUTPUT_DIR/SECURITY_ARCHITECTURE.md`, and `$OUTPUT_DIR/IMPLEMENTATION_PLAN.md` content (only if they exist)
    - Replace in DEVOPS_PROMPT:
      - [APP NAME] → Extract from PRD
      - [LANGUAGES, FRAMEWORKS, DATABASES] → Extract from Technical Spec
      - [ENVIRONMENTS, SCALE, UPTIME REQUIREMENTS] → Extract from Performance Plan (or use defaults if not available)
      - [AWS, GCP, AZURE, OR HYBRID] → Extract from Technical Spec
      - [DEVELOPMENT TEAM SIZE AND STRUCTURE] → Extract from Implementation Plan
    - Execute DEVOPS_PROMPT and save output to `$OUTPUT_DIR/DEVOPS_DEPLOYMENT.md`

19. **Generate Onboarding & Training Documentation**
    - **Execute only if "ONBOARDING_TRAINING" is in REQUIRED_DOCS**
    - Read `/project:.claude/commands/spec-chain/doc-prompt-onboarding.md` as ONBOARDING_PROMPT
    - Read available documents: `$OUTPUT_DIR/PRD.md`, `$OUTPUT_DIR/USER_FLOWS.md`, `$OUTPUT_DIR/WIREFRAMES.md`, and `$OUTPUT_DIR/IMPLEMENTATION_PLAN.md` content (only if they exist)
    - Replace in ONBOARDING_PROMPT:
      - [APP NAME] → Extract from PRD
      - [USER PERSONAS AND ROLES] → Extract from PRD
      - [CORE FEATURES TO TEACH] → Extract from PRD
      - [SIMPLE/MODERATE/COMPLEX] → Determine from feature complexity
      - [WHAT DEFINES SUCCESSFUL ONBOARDING] → Extract from PRD success metrics
    - Execute ONBOARDING_PROMPT and save output to `$OUTPUT_DIR/ONBOARDING_TRAINING.md`

### Post-Generation: Clarification Aggregation

20. **Aggregate Clarification Requests**
    - After all documents have been generated, scan each document for clarification requests
    - For each generated document in `$OUTPUT_DIR`:
      - Read the document content
      - Search for the "## Clarification Requests or Feedback" section
      - Extract any non-placeholder content (anything other than "[Any questions, clarifications or architectural considerations]")
      - If clarification items are found, record them with their source document
    - Compile all found items into a structured list organized by document
    - This aggregation will be included in the final Output Summary

## Output Summary

Upon completion, provide a summary including the following information. This summary should be both displayed in the prompt output AND saved to `$OUTPUT_DIR/README.md` for future reference:

1. **Generation Details**:
   - Spec name: `$SPEC_NAME`
   - Output directory: `$OUTPUT_DIR` (e.g., `/specs/my-app` or `/specs/20240120_143052`)
   - Start phase: `$START_PHASE`
   - Generation timestamp: `$TIMESTAMP`
   - Total execution time

2. **Generated Documents** (${#REQUIRED_DOCS[@]} total):
   - List each document with its full path in `$OUTPUT_DIR`
   - Brief description of contents
   - File size
   - **Note**: Only documents relevant to the application type were generated

3. **Documentation Coverage**:
   - **Generated Categories**: List categories of documents that were generated based on app requirements
   - **Skipped Categories**: List categories of documents that were skipped and why
   - **Business documentation**: PRD (always), GTM (if commercial), Business Rules (if commercial)
   - **Design documentation**: Style Guide, Wireframes, User Flows, IA, Components (if UI-focused)
   - **Technical documentation**: Technical Spec (always), API (if client-server), Data Model (if data-focused), Security (if deployed), Integrations (if external deps), Performance (if deployed)
   - **Implementation documentation**: Implementation Plan (always), Testing (always), DevOps (if deployed), Onboarding (if UI-focused)
   - **Interactive assets**: Preview HTML (if UI-focused)

4. **Key Decisions Captured**:
   - Technology stack
   - Architecture patterns
   - Security approach
   - Deployment strategy

5. **Clarification Requests and Feedback Aggregation**:
   
   After all documents are generated, scan each document for its "Clarification Requests or Feedback" section and aggregate all items that were recorded. Present them organized by source document:
   
   **Clarification Items Found:**
   
   For each document that contains clarification requests:
   - **[Document Name]** (`$OUTPUT_DIR/[filename]`):
     - [Clarification item 1]
     - [Clarification item 2]
     - [etc.]
   
   If clarification items were found, include this note:
   > **Note:** The above clarification items indicate areas where additional information in APP_DETAILS.md would improve the generated documentation. Consider adding these details to APP_DETAILS.md and re-running the spec-chain process for more comprehensive results.
   
   If no clarification items were found:
   > **Note:** No clarification requests were recorded. The provided APP_DETAILS.md contained sufficient information for comprehensive documentation generation.

6. **Next Steps**:
   - Review all documentation in `$OUTPUT_DIR`
   - Create symlink to latest generation (done automatically in summary output)
   - Gather stakeholder feedback
   - Begin implementation using the Implementation Plan

### Summary Output Requirements

**IMPORTANT**: After generating the complete summary above:

1. **Display the Summary**: Show the full summary in the prompt output for immediate viewing
2. **Save to README.md**: Write the identical summary content to `$OUTPUT_DIR/README.md` using the following format:

```markdown
# Spec Chain Documentation Generation Summary

Generated on: $TIMESTAMP
Output Directory: $OUTPUT_DIR

[INCLUDE THE COMPLETE SUMMARY CONTENT FROM ABOVE]

---

This documentation was generated by the Spec Chain system. All files in this directory represent a complete application specification suite based on the APP_DETAILS.md input file.
```

3. **Create Symlink**: Execute `ln -sfn $OUTPUT_DIR /specs/latest` to create a symlink pointing to this generation

## Error Handling

If any prompt execution fails:
1. Log the error with the specific prompt name
2. Continue with other prompts that don't depend on the failed output
3. Report all failures in the final summary
4. Suggest manual intervention for failed steps

## Intelligent Document Selection Examples

The system automatically determines which documents to generate based on app characteristics:

### Example 1: Mobile Social Media App
**App Type**: UI-focused, Client-Server
**Platform**: Mobile (iOS/Android), Web
**Generated Documents** (15 total):
- PRD, GTM_STRATEGY, BUSINESS_RULES (business)
- STYLE_GUIDE, WIREFRAMES, USER_FLOWS, INFORMATION_ARCHITECTURE, COMPONENT_LIBRARY (design)
- TECHNICAL_SPEC, API_SPEC, DATA_MODEL, SECURITY_ARCHITECTURE, PERFORMANCE_SCALABILITY (technical)
- IMPLEMENTATION_PLAN, TESTING_STRATEGY, DEVOPS_DEPLOYMENT, ONBOARDING_TRAINING (implementation)
- INTERACTIVE_PREVIEW (preview)

**Skipped Documents** (4 total): INTEGRATIONS (no external APIs mentioned)

### Example 2: CLI Data Processing Tool
**App Type**: CLI-focused, Standalone
**Platform**: Terminal/CLI
**Generated Documents** (6 total):
- PRD (foundation)
- TECHNICAL_SPEC, DATA_MODEL (technical - for data processing)
- IMPLEMENTATION_PLAN, TESTING_STRATEGY (implementation)

**Skipped Documents** (13 total): All UI/UX docs (no interface), API docs (standalone), DevOps (local tool), Business docs (not commercial), Security/Performance (local tool), Onboarding (CLI tool), Preview (no UI)

### Example 3: REST API Microservice
**App Type**: API-focused, Service-Only
**Platform**: Web (server-only)
**Generated Documents** (11 total):
- PRD, BUSINESS_RULES (foundation/business)
- TECHNICAL_SPEC, API_SPEC, DATA_MODEL, SECURITY_ARCHITECTURE, INTEGRATIONS, PERFORMANCE_SCALABILITY (technical)
- IMPLEMENTATION_PLAN, TESTING_STRATEGY, DEVOPS_DEPLOYMENT (implementation)

**Skipped Documents** (8 total): All UI/UX docs (no interface), GTM (internal service), Onboarding (no end users), Preview (no UI)

### Example 4: Desktop Productivity App
**App Type**: UI-focused, Standalone
**Platform**: Desktop (Windows/macOS)
**Generated Documents** (12 total):
- PRD, GTM_STRATEGY, BUSINESS_RULES (business)
- STYLE_GUIDE, WIREFRAMES, USER_FLOWS, INFORMATION_ARCHITECTURE, COMPONENT_LIBRARY (design)
- TECHNICAL_SPEC, IMPLEMENTATION_PLAN, TESTING_STRATEGY, ONBOARDING_TRAINING (implementation)
- INTERACTIVE_PREVIEW (preview)

**Skipped Documents** (7 total): API docs (standalone), Data Model (simple local storage), Security/Performance/DevOps (desktop app), Integrations (no external deps)

## Customization Options

- **Force Full Generation**: Override intelligent selection to generate all 19 documents
- **Manual Selection**: Specify exact documents to generate via command line flags
- **Profile-Based**: Use predefined profiles (mobile-app, api-service, cli-tool, desktop-app)

Remember: The PRD is always required as it feeds all other documents.

## APP_DETAILS.md Usage Summary

The runner extracts the following information from APP_DETAILS.md:

### Direct Extractions:
- **App Name**: Used in all prompts
- **App Idea**: Used for PRD app description
- **MVP Features**: Used for PRD features list
- **Target Users**: Used for personas and audience definitions
- **Business Context**: Used for market analysis and constraints
- **Technical Requirements**: Used for technical specifications and PRD Platform Requirements section
  - Platform (Web/Mobile/Desktop/Terminal) → Used in PRD Platform Requirements section
  - Technology Preferences
  - Performance Requirements
  - Scale Requirements
- **Design Requirements**: Used for style guide
  - Brand Personality
  - Visual Style
  - Key Emotions
  - Accessibility Requirements
- **Feature Details**: Used for workflows and IA
  - Core Workflows
  - Content Types
  - Feature Priorities
- **Integration Requirements**: Used for technical and API specs
- **Success Metrics**: Used for KPIs and testing criteria
- **Go-to-Market Strategy**: Used for GTM document
  - Target Market
  - Value Proposition
  - Launch Strategy
- **Development Team**: Used for implementation planning

### Inspiration Directories:
- If `/assets/inspiration/visual/` exists, its contents are passed to visual design prompts:
  - Style Guide (visual aspects)
  - Component Library (visual styling)
  - Interactive Preview (visual implementation)
  
- If `/assets/inspiration/functional/` exists, its contents are passed to functional design prompts:
  - Wireframes (layout and structure)
  - Component Library (behaviors and interactions)
  - User Flows (navigation and workflows)
  - Information Architecture (organization and hierarchy)
  - Interactive Preview (functional implementation)

This centralized approach ensures consistency across all generated documents.