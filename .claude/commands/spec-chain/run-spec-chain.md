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

**Update existing spec from Phase 3:**
```
@run-spec-chain existing-spec 3
```
Overwrites Phase 3+ documents in `/specs/existing-spec/`

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

### Step 2: Mode Detection and Initial Gathering

**Mode Detection Logic:**
- **COLLABORATIVE MODE**: If user provides only basic idea/concept (minimal APP_DETAILS.md or mostly empty fields)
- **COMPREHENSIVE MODE**: If user has detailed requirements (complete APP_DETAILS.md with substantial content)

**Auto-detect based on APP_DETAILS.md completeness:**
- Count filled vs. empty required fields
- If < 50% of required fields have substantial content → **COLLABORATIVE MODE**
- If ≥ 50% of required fields have substantial content → **COMPREHENSIVE MODE**

### Step 2.1: COLLABORATIVE MODE Path

**Execute if COLLABORATIVE MODE detected:**

1. **Gather Basic Required Information** (ask ONE AT A TIME):

   **App Name** (if missing):
   "What is the name of your app?"

   **App Idea** (if missing):
   "What problem does your app solve? Please provide a brief description of your app concept."

   **MVP Features** (if missing):
   "What are the core features for your minimum viable product (MVP)? Just list the essential functionality."

2. **Generate Initial Collaborative PRD:**
   - Use the collaborative template from doc-prompt-prd.md
   - Focus on problem-solution fit
   - Create initial specification with critical questions
   - Save to `$OUTPUT_DIR/PRD_COLLABORATIVE.md`

3. **Enter Collaborative Iteration Loop:**
   - Present the collaborative PRD to user
   - Ask: "Please review this initial specification. What would you like to clarify, change, or add? (Type 'continue' when ready to proceed to comprehensive documentation)"
   - For each user response:
     - Integrate feedback into the collaborative PRD
     - Regenerate and present the COMPLETE updated collaborative PRD
     - Ask follow-up questions based on their input
     - Continue until user types 'continue' or equivalent

4. **Graduation Decision:**
   - Ask: "Would you like to generate the complete comprehensive documentation suite based on this refined specification? (yes/no)"
   - If yes: Convert collaborative PRD to comprehensive format and proceed to Step 2.2
   - If no: End with collaborative PRD only

### Step 2.2: COMPREHENSIVE MODE Path

**Execute if COMPREHENSIVE MODE detected OR graduating from collaborative:**

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

### Step 2.3: Optional Fields Quick Decision (COMPREHENSIVE MODE Only)

**Execute only if in COMPREHENSIVE MODE:**

"Would you like to skip all optional fields? (yes/no or y/n)

If you skip, we'll use intelligent auto-research to fill these fields based on:
- Your app type and industry
- Best practices and modern standards
- Market research and competitive analysis

This often produces excellent results without manual input."

If "yes" or "y": Mark all optional fields for auto-research and skip to Step 4
If "no" or "n": Continue to Step 3 for individual optional fields

**Note**: In COLLABORATIVE MODE, optional fields are handled through the iterative conversation process.

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

Phase 2: Feature Analysis & Technical Overview (2 prompts - parallel)
    ├── FEATURE_STORIES.md
    └── TECHNICAL_OVERVIEW.md (depends on PRD)

Phase 3: Design & UI/UX (2 prompts - sequential)
    ├── STYLE_GUIDE.md
    └── UI_STATES.md (depends on Style Guide)

Phase 4: Technical Architecture (1 prompt - sequential)
    └── TECHNICAL_SPEC.md (depends on Technical Overview)

Phase 5: Planning & Implementation Rules (1 step - sequential)
    └── Load Playbooks and Rules (depends on Technical Spec)
```

Total: 6 documents generated across 5 phases

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

     # Feature Analysis (always generated for comprehensive understanding)
     REQUIRED_DOCS+=("FEATURE_STORIES" "TECHNICAL_OVERVIEW")

     # UI/UX Documents (only for apps with user interfaces)
     if [Platform includes Web/Mobile/Desktop] OR [App Type is UI-focused]; then
         REQUIRED_DOCS+=("STYLE_GUIDE" "UI_STATES")
     fi

     # Technical Documents (always required for development)
     REQUIRED_DOCS+=("TECHNICAL_SPEC")
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

   **For COLLABORATIVE MODE:**
   - If `PRD_COLLABORATIVE.md` exists from collaborative iteration, convert it to comprehensive format
   - Read `/project:.claude/commands/spec-chain/doc-prompt-prd.md` as PRD_PROMPT
   - Use COMPREHENSIVE MODE task from PRD_PROMPT
   - Replace placeholders with refined data from collaborative process
   - Execute PRD_PROMPT and save output to `$OUTPUT_DIR/PRD.md`

   **For COMPREHENSIVE MODE:**
   - Read `/project:.claude/commands/spec-chain/doc-prompt-prd.md` as PRD_PROMPT
   - Use COMPREHENSIVE MODE task from PRD_PROMPT
   - Replace placeholders in PRD_PROMPT with data from APP_DETAILS:
     - [APP NAME] → Extract from "App Name" section
     - [BRIEF DESCRIPTION OF THE APP CONCEPT, TARGET MARKET, AND CORE VALUE PROPOSITION] → Extract from "App Idea" section
     - [LIST OF MINIMUM VIABLE PRODUCT FEATURES AND CORE FUNCTIONALITY] → Extract from "MVP Features" section
     - [PRIMARY AND SECONDARY USER PERSONAS, THEIR ROLES, AND NEEDS] → Extract from "Target Users" section
     - [MARKET CONTEXT, COMPETITION, BUSINESS MODEL, OR CONSTRAINTS] → Extract from "Business Context" section (now complete from auto-research)
   - Execute PRD_PROMPT and save output to `$OUTPUT_DIR/PRD.md`

   **Note**: This document becomes the foundation for all subsequent documents

### Phase 2: Feature Analysis & Technical Overview (Parallel after Phase 1)

**Execute only if START_PHASE <= 2:**

**Execute the following tasks in parallel using concurrent Task agents (only if required):**

2. **Generate Feature Stories** (Depends on PRD)
   - **Execute only if "FEATURE_STORIES" is in REQUIRED_DOCS**
   - Read `/project:.claude/commands/spec-chain/doc-prompt-feature-stories.md` as FEATURE_STORIES_PROMPT
   - Read `$OUTPUT_DIR/PRD.md` content
   - Replace in FEATURE_STORIES_PROMPT:
     - [APP NAME] → Extract from PRD
     - [PRODUCT REQUIREMENTS DOCUMENT WITH FEATURES AND USER PERSONAS] → Use PRD.md content
     - [TECHNICAL OVERVIEW WITH PLATFORM SPECIFICATIONS AND ARCHITECTURE] → Use placeholder (will be filled after technical overview is generated)
     - [STYLE GUIDE OR DESIGN SYSTEM REFERENCE - for understanding visual design requirements] → Use default if not available
     - [LIST OF FILES IN /assets/inspiration/functional/] → List files from functional inspiration directory if it exists
   - Execute FEATURE_STORIES_PROMPT and save output to `$OUTPUT_DIR/FEATURE_STORIES.md`

3. **Generate Technical Overview** (Depends on PRD)
   - **Execute only if "TECHNICAL_OVERVIEW" is in REQUIRED_DOCS**
   - Read `/project:.claude/commands/spec-chain/doc-prompt-technical-overview.md` as TECHNICAL_OVERVIEW_PROMPT
   - Read `$OUTPUT_DIR/PRD.md` content and APP_DETAILS.md technical requirements
   - Replace in TECHNICAL_OVERVIEW_PROMPT:
     - [APP NAME] → Extract from PRD
     - [PRODUCT REQUIREMENTS DOCUMENT WITH FEATURES AND PLATFORM SPECIFICATIONS] → Use PRD.md content
     - [TECHNICAL REQUIREMENTS FROM APP_DETAILS INCLUDING: - Platform specifications (Web/Mobile/Desktop/Terminal) - Technology preferences and constraints - Performance requirements and targets - Scale requirements and growth projections - Security needs and compliance requirements] → Extract from APP_DETAILS.md technical requirements section
     - [STYLE GUIDE OR DESIGN SYSTEM REFERENCE - for understanding UI/UX technical requirements] → Use default if not available
     - [LIST OF FILES IN /assets/inspiration/functional/] → List files from functional inspiration directory if it exists
   - Execute TECHNICAL_OVERVIEW_PROMPT and save output to `$OUTPUT_DIR/TECHNICAL_OVERVIEW.md`

### Phase 3: Design & UI/UX (Sequential after Phase 2)

**Execute only if START_PHASE <= 3:**

4. **Generate Functional UX/UI Style Guide** (Design Track)
   - **Execute only if "STYLE_GUIDE" is in REQUIRED_DOCS**
   - Read `/project:.claude/commands/spec-chain/doc-prompt-style.md` as STYLE_PROMPT
   - Read `$OUTPUT_DIR/PRD.md` content
   - Replace in STYLE_PROMPT:
     - [APP NAME] → Extract from APP_DETAILS "App Name"
     - [PRODUCT REQUIREMENTS DOCUMENT WITH APP OVERVIEW, TARGET USERS, AND FEATURE REQUIREMENTS] → Use PRD.md content
     - [BRAND VALUES AND PERSONALITY] → Extract from APP_DETAILS "Brand Personality" (now complete from auto-research)
     - [TARGET USER DEMOGRAPHICS AND PREFERENCES] → Extract from APP_DETAILS "Target Users" section
     - [ANY SPECIFIC DESIGN REQUIREMENTS OR CONSTRAINTS] → Extract from APP_DETAILS "Accessibility Requirements" (now complete from auto-research)
     - [LIST OF FILES IN /assets/inspiration/visual/] → List files from visual inspiration directory if it exists
   - Execute STYLE_PROMPT and save output to `$OUTPUT_DIR/STYLE_GUIDE.md`

5. **Generate UI States & Screen Snapshots** (Depends on Style Guide)
   - **Execute only if "UI_STATES" is in REQUIRED_DOCS**
   - Wait for Style Guide completion from step 4
   - Read `/project:.claude/commands/spec-chain/doc-prompt-states.md` as UI_STATES_PROMPT
   - Read `$OUTPUT_DIR/PRD.md`, `$OUTPUT_DIR/FEATURE_STORIES.md`, and `$OUTPUT_DIR/STYLE_GUIDE.md` content
   - Replace in UI_STATES_PROMPT:
     - [APP NAME] → Extract from APP_DETAILS "App Name"
     - [PRODUCT REQUIREMENTS DOCUMENT WITH APP OVERVIEW, FEATURES, AND USER WORKFLOWS] → Use PRD.md content
     - [FEATURE STORIES WITH USER STORIES AND UX/UI CONSIDERATIONS] → Use FEATURE_STORIES.md content
     - [STYLE GUIDE WITH COLORS, TYPOGRAPHY, COMPONENTS, AND DESIGN SYSTEM] → Use STYLE_GUIDE.md content
     - [LIST OF FILES IN /assets/inspiration/visual/] → List files from visual inspiration directory if it exists
   - Execute UI_STATES_PROMPT and save output to `$OUTPUT_DIR/UI_STATES.md`

### Phase 4: Technical Architecture (Sequential after Phase 3)

**Execute only if START_PHASE <= 4:**

6. **Generate Comprehensive Technical Specification**
   - Wait for UI States completion from Phase 3
   - Read `/project:.claude/commands/spec-chain/doc-prompt-technical.md` as TECHNICAL_PROMPT
   - Read `$OUTPUT_DIR/PRD.md`, `$OUTPUT_DIR/FEATURE_STORIES.md`, `$OUTPUT_DIR/TECHNICAL_OVERVIEW.md`, `$OUTPUT_DIR/STYLE_GUIDE.md`, and `$OUTPUT_DIR/UI_STATES.md` content
   - Replace in TECHNICAL_PROMPT:
     - [APP NAME] → Extract from APP_DETAILS "App Name"
     - [PRODUCT REQUIREMENTS DOCUMENT WITH FEATURES, USER WORKFLOWS, AND BUSINESS OBJECTIVES] → Use PRD.md content
     - [FEATURE STORIES WITH USER STORIES AND UX/UI CONSIDERATIONS] → Use FEATURE_STORIES.md content
     - [TECHNICAL OVERVIEW WITH ARCHITECTURE AND PLATFORM SPECIFICATIONS] → Use TECHNICAL_OVERVIEW.md content
     - [STYLE GUIDE WITH COLORS, TYPOGRAPHY, COMPONENTS, AND DESIGN SYSTEM] → Use STYLE_GUIDE.md content
     - [UI STATES WITH SCREEN SNAPSHOTS AND INTERACTION SPECIFICATIONS] → Use UI_STATES.md content
     - [SCALE REQUIREMENTS AND GROWTH PROJECTIONS] → Extract from APP_DETAILS "Scale Requirements" (now complete from auto-research)
     - [PERFORMANCE TARGETS AND OPTIMIZATION REQUIREMENTS] → Extract from APP_DETAILS "Performance Requirements" (now complete from auto-research)
     - [SECURITY NEEDS AND COMPLIANCE REQUIREMENTS] → Extract from APP_DETAILS "Constraints" (now complete from auto-research)
   - Execute TECHNICAL_PROMPT and save output to `$OUTPUT_DIR/TECHNICAL_SPEC.md`

### Phase 5: Planning & Implementation Rules (Sequential after Phase 4)

**Execute only if START_PHASE <= 5:**

5.1. **Load Playbooks and Rules**
   - **Check for Playbook Directory:**
     - If `/assets/playbooks/` directory exists, proceed with loading
     - If directory doesn't exist, log: "No playbooks directory found, skipping rule loading"
     - Continue to Post-Generation phase

   - **Scan Playbook Files:**
     - List all files in `/assets/playbooks/` directory
     - Include subdirectories and organize by category
     - Supported file types: `.md`, `.txt`, `.json`, `.yaml`, `.yml`
     - Log: "Found playbook files: [list of files with paths]"

   - **Load and Categorize Rules:**
     - **Planning Rules**: Files containing planning methodologies, project structure guidelines, estimation techniques
     - **Implementation Rules**: Files containing coding standards, architecture patterns, best practices
     - **Quality Rules**: Files containing testing strategies, code review guidelines, quality gates
     - **Deployment Rules**: Files containing deployment procedures, infrastructure guidelines, operational practices
     - **Team Rules**: Files containing collaboration guidelines, communication protocols, workflow procedures

   - **Parse Rule Content:**
     - Read each file and extract key rules and guidelines
     - Identify rule categories based on file names and content
     - Create structured summary of available rules
     - Note any dependencies or prerequisites mentioned in rules

   - **Output Loaded Rules Summary:**
     ```
     **Playbooks and Rules Loaded for Planning/Implementation:**

     **Planning Rules:**
     - [Rule Set Name]: [Brief description] (Source: /assets/playbooks/[filename])
     - [Additional planning rule sets...]

     **Implementation Rules:**
     - [Rule Set Name]: [Brief description] (Source: /assets/playbooks/[filename])
     - [Additional implementation rule sets...]

     **Quality Assurance Rules:**
     - [Rule Set Name]: [Brief description] (Source: /assets/playbooks/[filename])
     - [Additional quality rule sets...]

     **Deployment & Operations Rules:**
     - [Rule Set Name]: [Brief description] (Source: /assets/playbooks/[filename])
     - [Additional deployment rule sets...]

     **Team & Collaboration Rules:**
     - [Rule Set Name]: [Brief description] (Source: /assets/playbooks/[filename])
     - [Additional team rule sets...]

     **Custom/Specialized Rules:**
     - [Rule Set Name]: [Brief description] (Source: /assets/playbooks/[filename])
     - [Additional custom rule sets...]

     **Total Rule Sets Loaded**: [Number] rule sets from [Number] files
     **Coverage Areas**: [List of areas covered by the loaded rules]
     **Integration Points**: [How these rules integrate with generated specifications]
     ```

   - **Prepare Rules for Integration:**
     - Make loaded rules available for subsequent planning and implementation phases
     - Create rule reference index for easy lookup during implementation
     - Note any conflicts or overlaps between different rule sets
     - Prepare rule application guidelines for development teams

5.2. **Generate Comprehensive Implementation Plan** (Iterative with Validation)
   - **Initialize Planning Loop:**
     - Set ITERATION_COUNT = 1
     - Set MAX_ITERATIONS = 5
     - Set VALIDATION_THRESHOLD = 85% (minimum completion score for approval)

   - **Planning and Validation Loop:**
     ```
     WHILE (ITERATION_COUNT <= MAX_ITERATIONS) AND (PLAN_STATUS != "APPROVED"):

       // Generate Implementation Plan
       - Read `/project:.claude/commands/spec-chain/doc-prompt-planner.md` as PLANNER_PROMPT
       - Read all available documents: `$OUTPUT_DIR/PRD.md`, `$OUTPUT_DIR/FEATURE_STORIES.md`,
         `$OUTPUT_DIR/TECHNICAL_OVERVIEW.md`, `$OUTPUT_DIR/STYLE_GUIDE.md`, `$OUTPUT_DIR/UI_STATES.md`,
         `$OUTPUT_DIR/TECHNICAL_SPEC.md`, and loaded playbooks summary
       - If ITERATION_COUNT > 1, also read previous plan and validation feedback
       - Replace in PLANNER_PROMPT:
         - [APP NAME] → Extract from APP_DETAILS "App Name"
         - [PRODUCT REQUIREMENTS DOCUMENT WITH FEATURES, USER WORKFLOWS, AND BUSINESS OBJECTIVES] → Use PRD.md content
         - [FEATURE STORIES WITH USER STORIES AND UX/UI CONSIDERATIONS] → Use FEATURE_STORIES.md content
         - [TECHNICAL OVERVIEW WITH ARCHITECTURE AND PLATFORM SPECIFICATIONS] → Use TECHNICAL_OVERVIEW.md content
         - [STYLE GUIDE WITH COLORS, TYPOGRAPHY, COMPONENTS, AND DESIGN SYSTEM] → Use STYLE_GUIDE.md content
         - [UI STATES WITH SCREEN SNAPSHOTS AND INTERACTION SPECIFICATIONS] → Use UI_STATES.md content
         - [COMPREHENSIVE TECHNICAL SPECIFICATION WITH ARCHITECTURE AND IMPLEMENTATION DETAILS] → Use TECHNICAL_SPEC.md content
         - [LOADED PLAYBOOKS AND RULES FROM ASSETS/PLAYBOOKS DIRECTORY] → Use loaded playbooks summary
         - [PREVIOUS IMPLEMENTATION PLAN IF THIS IS A REFINEMENT ITERATION] → Use previous plan if ITERATION_COUNT > 1
         - [VALIDATION FEEDBACK FROM PREVIOUS ITERATION IF APPLICABLE] → Use validation feedback if ITERATION_COUNT > 1
       - Execute PLANNER_PROMPT and save output to `$OUTPUT_DIR/IMPLEMENTATION_PLAN_v${ITERATION_COUNT}.md`

       // Validate Implementation Plan
       - Read `/project:.claude/commands/spec-chain/doc-prompt-planner-validator.md` as VALIDATOR_PROMPT
       - Read all input documents and the newly generated implementation plan
       - Replace in VALIDATOR_PROMPT:
         - [APP NAME] → Extract from APP_DETAILS "App Name"
         - [PRODUCT REQUIREMENTS DOCUMENT WITH FEATURES, USER WORKFLOWS, AND BUSINESS OBJECTIVES] → Use PRD.md content
         - [FEATURE STORIES WITH USER STORIES AND UX/UI CONSIDERATIONS] → Use FEATURE_STORIES.md content
         - [TECHNICAL OVERVIEW WITH ARCHITECTURE AND PLATFORM SPECIFICATIONS] → Use TECHNICAL_OVERVIEW.md content
         - [STYLE GUIDE WITH COLORS, TYPOGRAPHY, COMPONENTS, AND DESIGN SYSTEM] → Use STYLE_GUIDE.md content
         - [UI STATES WITH SCREEN SNAPSHOTS AND INTERACTION SPECIFICATIONS] → Use UI_STATES.md content
         - [COMPREHENSIVE TECHNICAL SPECIFICATION WITH ARCHITECTURE AND IMPLEMENTATION DETAILS] → Use TECHNICAL_SPEC.md content
         - [LOADED PLAYBOOKS AND RULES FROM ASSETS/PLAYBOOKS DIRECTORY] → Use loaded playbooks summary
         - [CURRENT IMPLEMENTATION PLAN TO VALIDATE] → Use IMPLEMENTATION_PLAN_v${ITERATION_COUNT}.md content
         - [CURRENT ITERATION NUMBER (1-5)] → Use ITERATION_COUNT
       - Execute VALIDATOR_PROMPT and save output to `$OUTPUT_DIR/VALIDATION_REPORT_v${ITERATION_COUNT}.md`

       // Check Validation Results
       - Extract VALIDATION_DECISION from validation report (APPROVED/NEEDS_REFINEMENT/MAJOR_REVISION_REQUIRED)
       - Extract COMPLETION_SCORE from validation report
       - Log: "Iteration ${ITERATION_COUNT}: ${VALIDATION_DECISION} (${COMPLETION_SCORE}% complete)"

       // Determine Next Action
       IF (VALIDATION_DECISION == "APPROVED") OR (COMPLETION_SCORE >= VALIDATION_THRESHOLD):
         - Set PLAN_STATUS = "APPROVED"
         - Copy `IMPLEMENTATION_PLAN_v${ITERATION_COUNT}.md` to `$OUTPUT_DIR/IMPLEMENTATION_PLAN.md`
         - Log: "Implementation plan approved after ${ITERATION_COUNT} iterations"
         - BREAK from loop
       ELSE:
         - Set PLAN_STATUS = "NEEDS_REFINEMENT"
         - Store validation feedback for next iteration
         - INCREMENT ITERATION_COUNT
         - Log: "Implementation plan needs refinement, proceeding to iteration ${ITERATION_COUNT}"

     END WHILE
     ```

   - **Final Status Check:**
     ```
     IF (PLAN_STATUS != "APPROVED"):
       - Log: "Maximum iterations (${MAX_ITERATIONS}) reached without approval"
       - Copy the best plan (highest completion score) to `$OUTPUT_DIR/IMPLEMENTATION_PLAN.md`
       - Create summary of remaining gaps in `$OUTPUT_DIR/IMPLEMENTATION_GAPS.md`
       - Log: "Using best available plan with ${HIGHEST_COMPLETION_SCORE}% completion"
     ```

   - **Output Summary:**
     ```
     **Implementation Planning Summary:**
     - **Total Iterations**: ${ITERATION_COUNT}
     - **Final Status**: ${PLAN_STATUS}
     - **Completion Score**: ${FINAL_COMPLETION_SCORE}%
     - **Plan File**: IMPLEMENTATION_PLAN.md
     - **Validation Reports**: VALIDATION_REPORT_v1.md through VALIDATION_REPORT_v${ITERATION_COUNT}.md
     - **All Plan Versions**: IMPLEMENTATION_PLAN_v1.md through IMPLEMENTATION_PLAN_v${ITERATION_COUNT}.md
     ```

### Post-Generation: Clarification Aggregation

6. **Aggregate Clarification Requests**
    - After all documents have been generated, scan each document for clarification requests
    - For each generated document in `$OUTPUT_DIR`:
      - Read the document content
      - Search for the "## Clarification Requests or Feedback" section or "## Critical Questions and Clarifications" section
      - Extract any non-placeholder content (anything other than "[Any questions, clarifications or architectural considerations]")
      - If clarification items are found, record them with their source document
    - Compile all found items into a structured list organized by document
    - This aggregation will be included in the final Output Summary

## Output Summary

Upon completion, provide a summary including the following information. This summary should be both displayed in the prompt output AND saved to `$OUTPUT_DIR/README.md` for future reference:

1. **Generation Details**:
   - Spec name: `$SPEC_NAME`
   - Output directory: `$OUTPUT_DIR` (e.g., `/specs/my-app` or `/specs/20240120_143052`)
   - Generation mode: `[COLLABORATIVE/COMPREHENSIVE]` - indicates which approach was used
   - Start phase: `$START_PHASE`
   - Generation timestamp: `$TIMESTAMP`
   - Total execution time
   - Collaborative iterations: `[number]` (if COLLABORATIVE MODE was used)

2. **Generated Documents** (${#REQUIRED_DOCS[@]} total):
   - List each document with its full path in `$OUTPUT_DIR`
   - Brief description of contents
   - File size
   - **Note**: Only documents relevant to the application type were generated

3. **Documentation Coverage**:
   - **Generated Categories**: List categories of documents that were generated based on app requirements
   - **Skipped Categories**: List categories of documents that were skipped and why
   - **Foundation documentation**: PRD (always)
   - **Feature analysis**: Feature Stories (always), Technical Overview (always)
   - **Design documentation**: Style Guide, UI States (if UI-focused)
   - **Technical documentation**: Technical Spec (always)
   - **Planning documentation**: Playbook Rules Loading, Implementation Plan (always)
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

   **For COLLABORATIVE MODE completions:**
   - Review the collaborative PRD in `$OUTPUT_DIR/PRD_COLLABORATIVE.md` (if generated)
   - Consider running again to graduate to comprehensive documentation
   - Use insights gained to refine APP_DETAILS.md for future comprehensive generation

   **For COMPREHENSIVE MODE completions:**
   - Review all documentation in `$OUTPUT_DIR`
   - Create symlink to latest generation (done automatically in summary output)
   - Gather stakeholder feedback on the comprehensive specification
   - Begin implementation using the Implementation Plan

   **For both modes:**
   - Address any clarification requests found in the generated documents
   - Update APP_DETAILS.md with new insights for future iterations

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

### General Prompt Failures
If any prompt execution fails:
1. Log the error with the specific prompt name
2. Continue with other prompts that don't depend on the failed output
3. Report all failures in the final summary
4. Suggest manual intervention for failed steps

### Collaborative Mode Specific Errors
If collaborative mode encounters issues:
1. **Iteration Loop Failures**: If user feedback integration fails, save the current state and offer to continue with existing PRD
2. **User Input Timeout**: If user doesn't respond within reasonable time, offer to proceed with current specification
3. **Invalid User Responses**: Gracefully handle unclear feedback and ask for clarification
4. **Graduation Failures**: If transition from collaborative to comprehensive fails, preserve collaborative PRD and suggest manual review

### Mode Detection Failures
If mode detection fails:
1. Default to COLLABORATIVE MODE for safety (less overwhelming)
2. Log the detection failure reason
3. Allow user to manually specify mode if needed
4. Provide clear explanation of why collaborative mode was chosen

## Intelligent Document Selection Examples

The system automatically determines which documents to generate based on app characteristics and selected mode:

### Collaborative Mode Example: Early-Stage Idea
**Mode**: COLLABORATIVE
**Input**: Basic app idea with minimal details
**Generated Documents** (1 total):
- PRD_COLLABORATIVE.md (focused 8-section collaborative PRD)

**Process**:
1. Generate initial collaborative PRD with critical questions
2. User provides feedback and clarifications
3. Iterate and refine the collaborative PRD
4. Option to graduate to comprehensive documentation

**Skipped Documents** (18 total): All other documents until graduation to comprehensive mode

### Example 1: Mobile Social Media App
**App Type**: UI-focused, Client-Server
**Platform**: Mobile (iOS/Android), Web
**Generated Documents** (7 total):
- PRD (foundation)
- FEATURE_STORIES, TECHNICAL_OVERVIEW (feature analysis)
- STYLE_GUIDE, UI_STATES (design)
- TECHNICAL_SPEC (technical)
- IMPLEMENTATION_PLAN (planning - with iterative refinement)
**Additional Outputs**: Playbook rules loading, validation reports for each iteration

### Example 2: CLI Data Processing Tool
**App Type**: CLI-focused, Standalone
**Platform**: Terminal/CLI
**Generated Documents** (5 total):
- PRD (foundation)
- FEATURE_STORIES, TECHNICAL_OVERVIEW (feature analysis)
- TECHNICAL_SPEC (technical)
- IMPLEMENTATION_PLAN (planning - with iterative refinement)
**Skipped Documents** (2 total): All UI/UX docs (no interface)
**Additional Outputs**: Playbook rules loading, validation reports for each iteration

### Example 3: REST API Microservice
**App Type**: API-focused, Service-Only
**Platform**: Web (server-only)
**Generated Documents** (5 total):
- PRD (foundation)
- FEATURE_STORIES, TECHNICAL_OVERVIEW (feature analysis)
- TECHNICAL_SPEC (technical)
- IMPLEMENTATION_PLAN (planning - with iterative refinement)
**Skipped Documents** (2 total): All UI/UX docs (no interface)
**Additional Outputs**: Playbook rules loading, validation reports for each iteration

### Example 4: Desktop Productivity App
**App Type**: UI-focused, Standalone
**Platform**: Desktop (Windows/macOS)
**Generated Documents** (7 total):
- PRD (foundation)
- FEATURE_STORIES, TECHNICAL_OVERVIEW (feature analysis)
- STYLE_GUIDE, UI_STATES (design)
- TECHNICAL_SPEC (technical)
- IMPLEMENTATION_PLAN (planning - with iterative refinement)
**Additional Outputs**: Playbook rules loading, validation reports for each iteration

## Customization Options

### Mode Selection
- **Auto-Detection** (Default): System automatically chooses COLLABORATIVE or COMPREHENSIVE based on APP_DETAILS.md completeness
- **Force Collaborative**: Override detection to use collaborative mode regardless of input completeness
- **Force Comprehensive**: Override detection to use comprehensive mode regardless of input completeness

### Document Generation
- **Force Full Generation**: Override intelligent selection to generate all 19 documents
- **Manual Selection**: Specify exact documents to generate via command line flags
- **Profile-Based**: Use predefined profiles (mobile-app, api-service, cli-tool, desktop-app)

### Collaborative Mode Options
- **Iteration Limit**: Set maximum number of collaborative iterations before auto-graduation
- **Auto-Graduate**: Automatically proceed to comprehensive mode after successful collaborative refinement
- **Save Iterations**: Preserve all collaborative iteration states for review

Remember: The PRD (collaborative or comprehensive) is always required as it feeds all other documents.

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
  - Technical Overview (architecture and implementation patterns)
  - Component Library (behaviors and interactions)
  - User Flows (navigation and workflows)
  - Information Architecture (organization and hierarchy)
  - Interactive Preview (functional implementation)

This centralized approach ensures consistency across all generated documents.