# Specification Chain: Runner

Execute the complete specification chain to generate comprehensive documentation for an app idea.

## Arguments

**Argument 1: Spec Name (Optional)**
- The name of the spec to create/update
- This becomes the output folder `.spec-chain/specs/<spec name>`
- If not supplied, defaults to timestamp format ("%Y%m%d_%H%M%S")
- If the folder already exists, its contents will be overwritten with newly generated documentation

**Argument 2: Start Phase (Optional)**
- The phase number to start execution from (1-5)
- Defaults to Phase 1 if not specified
- The system validates that all previous phase documents exist before proceeding
- If validation fails, the system will prompt to start from an earlier phase

**Argument 3: Parallel Agents (Optional)**
- The number of parallel agents to use for UI Preview generation
- Defaults to 5 if not specified
- Valid range: 1-10 agents
- Only affects Phase 3b (UI Preview generation)

## Usage Examples

**Basic usage (full generation with timestamp):**
```
/run-spec-chain
```
Creates: `.spec-chain/specs/20240120_143052/` with all documents

**Named spec (full generation):**
```
/run-spec-chain my-app
```
Creates: `.spec-chain/specs/my-app/` with all documents

**Resume from specific phase:**
```
/run-spec-chain my-app 3
```
Resumes generation from Phase 3 (Technical Architecture) in `.spec-chain/specs/my-app/`

**Update existing spec from Phase 3:**
```
/run-spec-chain existing-spec 3
```
Overwrites Phase 3+ documents in `.spec-chain/specs/existing-spec/`

**Specify number of parallel UI design agents:**
```
/run-spec-chain my-app 1 8
```
Generates 8 different UI design approaches in `.spec-chain/specs/my-app/`

## Overview

This runner orchestrates the execution of 9 specification chain prompts that generate 8 core documents, managing dependencies and passing outputs between phases. The process transforms a single app idea into a complete documentation suite.

Each execution creates a directory under `.spec-chain/specs/` (e.g., `.spec-chain/specs/my-app/` or `.spec-chain/specs/20240120_143052/`) to:
- Preserve historical documentation versions
- Enable comparison between different generations
- Support iterative refinement without overwriting previous work
- Facilitate A/B testing of different approaches
- Maintain audit trail of documentation evolution

## Execution Flow

### Step 0: Verify Spec-Chain Initialization

Before proceeding with any operations, verify that this command is being run from a directory initialized with spec-chain:

1. **Check for required project indicators:**
   - Use LS tool to check if `.spec-chain/` directory exists
   - Use Read tool to verify `.spec-chain/APP_DETAILS.md.template` file exists
   - Use LS tool to check if `.spec-chain/specs/` directory exists

2. **If any indicators are missing:**
   - Display error message:
     ```
     ❌ Error: This command must be run from a directory initialized with /init-spec-chain.
     
     Missing required project files/directories:
     - [list specific missing items]
     
     Please ensure you are in the correct directory that contains:
     - .spec-chain/ directory (initialized spec-chain project)
     - Run '/init-spec-chain' to initialize a new project
     
     Current working directory: [show current path using pwd]
     ```
   - Exit the command without proceeding

3. **If all indicators are present:**
   - Log: "✅ Project root verified. Proceeding with spec-chain generation..."
   - Continue to Step 1

### Step 1: Initialize .spec-chain/APP_DETAILS.md

1. **Check for existing .spec-chain/APP_DETAILS.md:**
   - Check if `.spec-chain/APP_DETAILS.md` exists
   - If it doesn't exist:
     - Copy `.spec-chain/APP_DETAILS.md.template` to `.spec-chain/APP_DETAILS.md`
     - Log: "Created .spec-chain/APP_DETAILS.md from template"

2. **Parse .spec-chain/APP_DETAILS.md structure:**
   - Read the .spec-chain/APP_DETAILS.md file
   - Extract all sections and their current values
   - Identify REQUIRED vs OPTIONAL fields based on template annotations
   - Determine which fields are empty or contain placeholder text

### Step 2: Show Current Status Summary

Display a summary of the current .spec-chain/APP_DETAILS.md status:

```
**.spec-chain/APP_DETAILS.md Status Summary:**

**REQUIRED Fields:**
✅ App Name: [Current value or "❌ Missing"]
✅ App Idea: [Current value or "❌ Missing"]
✅ MVP Features: [Current value or "❌ Missing"]
✅ Target Users: [Current value or "❌ Missing"]

**OPTIONAL Fields:**
📝 Market Context: [Current value or "⚪ Empty - can auto-research"]
📝 Competition: [Current value or "⚪ Empty - can auto-research"]
📝 Business Model: [Current value or "⚪ Empty - can auto-research"]
📝 Constraints: [Current value or "⚪ Empty - can auto-research"]
📝 Platform: [Current value or "⚪ Empty - can auto-research"]
📝 Technology Preferences: [Current value or "⚪ Empty - can auto-research"]
📝 Performance Requirements: [Current value or "⚪ Empty - can auto-research"]
📝 Scale Requirements: [Current value or "⚪ Empty - can auto-research"]
📝 Brand Personality: [Current value or "⚪ Empty - can auto-research"]
📝 Visual Style: [Current value or "⚪ Empty - can auto-research"]
📝 Accessibility Requirements: [Current value or "⚪ Empty - can auto-research"]
📝 Integration Requirements: [Current value or "⚪ Empty - can auto-research"]
📝 Success Metrics: [Current value or "⚪ Empty - can auto-research"]
📝 Go-to-Market Strategy: [Current value or "⚪ Empty - can auto-research"]
📝 Development Team: [Current value or "⚪ Empty - can auto-research"]

**Summary:** [X] of [Y] required fields complete, [Z] optional fields have content
```

### Step 3: Gather Missing Required Information

For each missing REQUIRED field, ask ONE AT A TIME:

1. **App Name** (if missing):
   "What is the name of your app?"

2. **App Idea** (if missing):
   "What problem does your app solve? Please provide a brief description of your app concept."

3. **MVP Features** (if missing):
   "What are the core features for your minimum viable product (MVP)? List the essential functionality."

4. **Target Users** (if missing):
   "Who is the primary target audience for your app? Describe your main user types."

Wait for the user to answer each question before proceeding to the next.

### Step 4: Handle Optional Fields

Ask: "How would you like to handle the optional fields?

**Options:**
1. **Skip all** - Auto-research all empty optional fields (recommended for speed)
2. **Fill individually** - Go through each empty optional field one by one
3. **Skip remaining** - Available during individual filling to auto-research remaining fields

**Auto-research benefits:**
- Analyzes similar successful apps in your market
- Applies industry best practices and modern standards
- Generates contextually appropriate suggestions
- Ensures consistency across all documentation
- Often produces excellent results without manual input

**Choose:** (1=skip all, 2=fill individually)"

**If user chooses "1" (skip all):**
- Mark all empty optional fields for auto-research
- Skip to Step 5

**If user chooses "2" (fill individually):**
For each empty optional field, ask ONE AT A TIME:

1. **Market Context**: "Describe the market context and opportunity
   → Enter details (or type 'skip' to auto-research this field, 'skipall' to auto-research all remaining):"

2. **Competition**: "List key competitors and their positioning
   → Enter details (or type 'skip' to auto-research this field, 'skipall' to auto-research all remaining):"

3. **Business Model**: "Specify your business/monetization model
   → Enter details (or type 'skip' to auto-research this field, 'skipall' to auto-research all remaining):"

4. **Constraints**: "List any business or technical constraints
   → Enter details (or type 'skip' to auto-research this field, 'skipall' to auto-research all remaining):"

5. **Platform**: "Specify target platforms (Web/Mobile/Desktop/CLI)
   → Enter details (or type 'skip' to auto-research this field, 'skipall' to auto-research all remaining):"

6. **Technology Preferences**: "Specify technology preferences or constraints
   → Enter details (or type 'skip' to auto-research this field, 'skipall' to auto-research all remaining):"

7. **Performance Requirements**: "Define performance requirements and targets
   → Enter details (or type 'skip' to auto-research this field, 'skipall' to auto-research all remaining):"

8. **Scale Requirements**: "Specify expected scale and growth requirements
   → Enter details (or type 'skip' to auto-research this field, 'skipall' to auto-research all remaining):"

9. **Brand Personality**: "Describe your brand personality and values
   → Enter details (or type 'skip' to auto-research this field, 'skipall' to auto-research all remaining):"

10. **Visual Style**: "Describe your visual style preferences
    → Enter details (or type 'skip' to auto-research this field, 'skipall' to auto-research all remaining):"

11. **Accessibility Requirements**: "Specify accessibility requirements
    → Enter details (or type 'skip' to auto-research this field, 'skipall' to auto-research all remaining):"

12. **Integration Requirements**: "List required third-party integrations
    → Enter details (or type 'skip' to auto-research this field, 'skipall' to auto-research all remaining):"

13. **Success Metrics**: "Define success metrics and KPIs
    → Enter details (or type 'skip' to auto-research this field, 'skipall' to auto-research all remaining):"

14. **Go-to-Market Strategy**: "Describe your go-to-market approach
    → Enter details (or type 'skip' to auto-research this field, 'skipall' to auto-research all remaining):"

15. **Development Team**: "Specify team structure and requirements
    → Enter details (or type 'skip' to auto-research this field, 'skipall' to auto-research all remaining):"

**Response Processing:**
- If user types 'skip': Mark this field for auto-research and continue to next field
- If user types 'skipall': Mark all remaining fields for auto-research and proceed to Step 5
- Any other input: Use as the field value

### Step 5: Auto-Research and Finalize .spec-chain/APP_DETAILS.md

1. **Perform Auto-Research for Marked Fields:**
   - If any fields were marked for auto-research, notify user: "Performing auto-research for skipped fields. This may take a moment..."
   - For each field marked for auto-research, generate appropriate content based on the app context:
     - **Market Context**: Research similar apps, market size, trends, and opportunities in the relevant industry
     - **Competition**: Identify 3-5 key competitors and their positioning
     - **Business Model**: Suggest appropriate monetization strategies based on app type and target users
     - **Constraints**: Identify common technical and business constraints for this type of application
     - **Platform**: Recommend optimal platform(s) based on target users and app functionality
     - **Technology Preferences**: Suggest modern, appropriate technology choices for the platform and requirements
     - **Performance Requirements**: Set industry-standard performance targets for the app type
     - **Scale Requirements**: Estimate appropriate scale targets based on target market and business model
     - **Brand Personality**: Generate brand attributes that align with the app idea and target users
     - **Visual Style**: Suggest design approaches that match the brand personality and user expectations
     - **Accessibility Requirements**: Apply modern accessibility standards (WCAG 2.1 AA minimum)
     - **Integration Requirements**: Identify likely third-party services needed for the app functionality
     - **Success Metrics**: Define relevant KPIs based on the business model and user goals
     - **Go-to-Market Strategy**: Develop launch and growth strategies appropriate for the target market
     - **Development Team**: Recommend team structure based on technical requirements and project scope

2. **Combine and Format Data:**
   - Merge existing data with newly gathered information and auto-researched content
   - Format according to the .spec-chain/APP_DETAILS.md template structure
   - Ensure all sections are complete and properly formatted

3. **Save to Output Directory:**
   - Always save the complete APP_DETAILS.md to `$OUTPUT_DIR/APP_DETAILS.md`
   - This ensures all generation steps use the same comprehensive data

4. **Offer to Update Root File:**
   - Ask: "Would you like to update the .spec-chain/APP_DETAILS.md file with this complete information? (yes/no)"
   - If yes: Save the updated content to `.spec-chain/APP_DETAILS.md`
   - If no: Keep the complete version only in the output directory
   - Log the user's choice and file locations

### Step 6: Proceed with Documentation Generation

The runner then uses **parallel Task agents** to execute independent prompts concurrently, significantly reducing total generation time:

```
Phase 1: Foundation (1 prompt)
    └── PRD.md

Phase 2: Feature Analysis & Technical Overview (2 prompts - parallel)
    ├── FEATURE_STORIES.md
    └── TECHNICAL_OVERVIEW.md (depends on PRD)

Phase 3: Design & UI/UX (3 prompts - sequential)
    ├── STYLE_GUIDE.md
    ├── UI_STATES.md (depends on Style Guide)
    └── UI_PREVIEW.html (depends on Style Guide and UI States)

Phase 4: Technical Architecture (1 prompt - sequential)
    └── TECHNICAL_SPEC.md (depends on Technical Overview)

Phase 5: Planning & Implementation Rules (2 steps - sequential)
    ├── 5.1: Load Playbooks and Rules (depends on Technical Spec)
    └── 5.2: Generate Implementation Plan with Iterative Validation (depends on Playbooks)
```

Total: 8+ documents generated across 5 phases (includes Implementation Plan + validation reports)

## Prerequisites

1. Ensure all doc-prompt-*.md prompt files are present in the `.claude/commands/spec-chain/` directory
2. .spec-chain/APP_DETAILS.md is optional - the system will:
   - Use existing `.spec-chain/APP_DETAILS.md` if present
   - Ask questions to gather missing information
   - Auto-research optional fields if not provided
3. Optionally, organize inspiration materials:
   - Place visual references in `.spec-chain/assets/inspiration/visual/` (colors, styles, typography, effects)
   - Place functional references in `.spec-chain/assets/inspiration/functional/` (layouts, workflows, interactions)

## Input Source

All input data is read from the `.spec-chain/APP_DETAILS.md` file which contains:
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
     - `PARALLEL_AGENTS`: Third argument (number of UI preview agents) or default to 5 if not provided
   - **Set Output Directory:**
     - Set `OUTPUT_DIR=.spec-chain/specs/$SPEC_NAME`
     - Create output directory: `mkdir -p $OUTPUT_DIR`
     - If directory exists and contains files, log: "Overwriting existing spec directory: $OUTPUT_DIR"
   - **Initialize Data Sources:**
     - **Validate .spec-chain/APP_DETAILS.md Structure:**
       - Check if `.spec-chain/APP_DETAILS.md.template` exists
       - If template exists, validate `.spec-chain/APP_DETAILS.md` structure against template
       - Extract section headers from template (excluding warning block): `sed '/^<!--$/,/^-->$/d' .spec-chain/APP_DETAILS.md.template | grep -E '^##|^###' | sort`
       - Extract section headers from current APP_DETAILS.md: `grep -E '^##|^###' .spec-chain/APP_DETAILS.md | sort`
       - Find missing sections: `comm -23 <(template_sections) <(current_sections)`
       - If missing sections found:
         - Log: "⚠️ Missing sections detected in .spec-chain/APP_DETAILS.md"
         - Create backup: `cp .spec-chain/APP_DETAILS.md .spec-chain/APP_DETAILS.md.backup`
         - Append missing sections from template to .spec-chain/APP_DETAILS.md
         - Log: "✅ Missing sections restored from template. Backup saved as .spec-chain/APP_DETAILS.md.backup"
       - If no missing sections: Log: "✅ .spec-chain/APP_DETAILS.md structure is complete"
     - Read APP_DETAILS from either `$OUTPUT_DIR/APP_DETAILS.md` (if newly created) or `APP_DETAILS.md` (if existing)
     - Extract all sections for use in subsequent prompts

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
         REQUIRED_DOCS+=("STYLE_GUIDE" "UI_STATES" "UI_PREVIEW")
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
   - Read the command file: `.claude/commands/spec-chain/doc-prompt-prd.md`
   - Update the first instance of `$ARGUMENTS` in the Variables section with `$SPEC_NAME`
   - Execute the updated command as a prompt
   - The prompt will:
     - Load APP_DETAILS.md from `.spec-chain/specs/$SPEC_NAME/APP_DETAILS.md`
     - Generate comprehensive PRD based on complete application details
     - Save PRD to `.spec-chain/specs/$SPEC_NAME/PRD.md`
     - Handle all file persistence internally

   **Note**: This document becomes the foundation for all subsequent documents

## Parallel Execution Strategy

The spec-chain system has been optimized for parallel execution where dependencies allow. Here's the dependency analysis and parallel execution opportunities:

### Dependency Tree Analysis:
```
Phase 1: PRD (Foundation)
├── Phase 2a: Feature Stories (depends on PRD)
├── Phase 2b: Technical Overview (depends on PRD + APP_DETAILS)
└── Phase 3a: Style Guide (depends on PRD + APP_DETAILS) ← Can run parallel with Phase 2

Phase 3b: UI States (depends on Feature Stories + Style Guide)
Phase 3c: UI Preview (depends on UI States)
Phase 4: Technical Spec (depends on all previous)
Phase 5: Implementation Planning (depends on Technical Spec)
```

### Parallel Execution Opportunities:
1. **Phase 2 + 3a Parallel**: Feature Stories, Technical Overview, and Style Guide can all run simultaneously after PRD
2. **Phase 3b Sequential**: UI States must wait for both Feature Stories and Style Guide
3. **Phase 3c Sequential**: UI Preview must wait for UI States
4. **Phases 4-5 Sequential**: Technical Spec and Implementation Planning are sequential

### Phase 2 & 3a: Parallel Document Generation (After Phase 1)

**Execute only if START_PHASE <= 2:**

**Execute the following tasks in parallel using concurrent Task agents:**

1. **Generate Feature Stories** (Depends on PRD)
   - **Execute only if "FEATURE_STORIES" is in REQUIRED_DOCS**
   - Read the command file: `.claude/commands/spec-chain/doc-prompt-feature-stories.md`
   - Update the first instance of `$ARGUMENTS` in the Variables section with `$SPEC_NAME`
   - Execute the updated command as a prompt
   - The prompt will:
     - Load all required documents from `.spec-chain/specs/$SPEC_NAME/` directory
     - Generate comprehensive feature stories based on PRD
     - Save output to `.spec-chain/specs/$SPEC_NAME/FEATURE_STORIES.md`
     - Handle all file persistence internally

2. **Generate Technical Overview** (Depends on PRD + APP_DETAILS)
   - **Execute only if "TECHNICAL_OVERVIEW" is in REQUIRED_DOCS**
   - Read the command file: `.claude/commands/spec-chain/doc-prompt-technical-overview.md`
   - Update the first instance of `$ARGUMENTS` in the Variables section with `$SPEC_NAME`
   - Execute the updated command as a prompt
   - The prompt will:
     - Load all required documents from `.spec-chain/specs/$SPEC_NAME/` directory
     - Generate comprehensive technical overview based on PRD and APP_DETAILS
     - Save output to `.spec-chain/specs/$SPEC_NAME/TECHNICAL_OVERVIEW.md`
     - Handle all file persistence internally

3. **Generate Style Guide** (Depends on PRD + APP_DETAILS) - **PARALLEL EXECUTION**
   - **Execute only if "STYLE_GUIDE" is in REQUIRED_DOCS**
   - Read the command file: `.claude/commands/spec-chain/doc-prompt-style.md`
   - Update the first instance of `$ARGUMENTS` in the Variables section with `$SPEC_NAME`
   - Execute the updated command as a prompt
   - The prompt will:
     - Load all required documents from `.spec-chain/specs/$SPEC_NAME/` directory
     - Generate comprehensive style guide based on PRD and APP_DETAILS
     - Save output to `.spec-chain/specs/$SPEC_NAME/STYLE_GUIDE.md`
     - Handle all file persistence internally

**Note**: Tasks 1, 2, and 3 can run simultaneously as they only depend on Phase 1 outputs

### Phase 3b: UI States & Preview (Sequential after Phase 2 & 3a)

**Execute only if START_PHASE <= 3:**

**Wait for completion of Phase 2 & 3a parallel tasks before proceeding**

1. **Generate UI States & Screen Snapshots** (Depends on Style Guide and Feature Stories)
   - **Execute only if "UI_STATES" is in REQUIRED_DOCS**
   - Wait for Style Guide and Feature Stories completion from previous phase
   - Read the command file: `.claude/commands/spec-chain/doc-prompt-states.md`
   - Update the first instance of `$ARGUMENTS` in the Variables section with `$SPEC_NAME`
   - Execute the updated command as a prompt
   - The prompt will:
     - Load all required documents from `.spec-chain/specs/$SPEC_NAME/` directory
     - Generate comprehensive UI states based on PRD, Feature Stories, and Style Guide
     - Save output to `.spec-chain/specs/$SPEC_NAME/UI_STATES.md`
     - Handle all file persistence internally

2. **Generate Interactive UI Preview** (Depends on Style Guide and UI States)
   - **Execute only if "UI_PREVIEW" is in REQUIRED_DOCS**
   - Wait for UI States completion from step 1
   - Read the command file: `.claude/commands/spec-chain/doc-prompt-ui-preview.md`
   - Update the first instance of `$ARGUMENTS` in the Variables section with `$SPEC_NAME`
   - Update the second instance of `$ARGUMENTS` in the Variables section with `$PARALLEL_AGENTS` (defaults to 5 if not provided)
   - Execute the updated command as a prompt
   - The prompt will:
     - Load all required documents from `.spec-chain/specs/$SPEC_NAME/` directory
     - Deploy `$PARALLEL_AGENTS` sub-agents to generate multiple UI design approaches
     - Generate `$PARALLEL_AGENTS` interactive UI preview files (UI_PREVIEW_1.html through UI_PREVIEW_N.html)
     - Handle all file persistence internally

### Phase 4: Technical Architecture (Sequential after Phase 3)

**Execute only if START_PHASE <= 4:**

1. **Generate Comprehensive Technical Specification**
   - Wait for UI States completion from Phase 3 (if UI-focused app)
   - Read the command file: `.claude/commands/spec-chain/doc-prompt-technical.md`
   - Update the first instance of `$ARGUMENTS` in the Variables section with `$SPEC_NAME`
   - Execute the updated command as a prompt
   - The prompt will:
     - Load all required documents from `.spec-chain/specs/$SPEC_NAME/` directory
     - Generate comprehensive technical specification based on all previous documents
     - Save output to `.spec-chain/specs/$SPEC_NAME/TECHNICAL_SPEC.md`
     - Handle all file persistence internally

### Phase 5: Planning & Implementation Rules (Sequential after Phase 4)

**Execute only if START_PHASE <= 5:**

5.1. **Load Playbooks and Rules**
   - **Check for Playbook Directory:**
     - If `.spec-chain/assets/playbooks/` directory exists, proceed with loading
     - If directory doesn't exist, log: "No playbooks directory found, skipping rule loading"
     - Continue to Post-Generation phase

   - **Scan Playbook Files:**
     - List all files in `.spec-chain/assets/playbooks/` directory
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
     - [Rule Set Name]: [Brief description] (Source: .spec-chain/assets/playbooks/[filename])
     - [Additional planning rule sets...]

     **Implementation Rules:**
     - [Rule Set Name]: [Brief description] (Source: .spec-chain/assets/playbooks/[filename])
     - [Additional implementation rule sets...]

     **Quality Assurance Rules:**
     - [Rule Set Name]: [Brief description] (Source: .spec-chain/assets/playbooks/[filename])
     - [Additional quality rule sets...]

     **Deployment & Operations Rules:**
     - [Rule Set Name]: [Brief description] (Source: .spec-chain/assets/playbooks/[filename])
     - [Additional deployment rule sets...]

     **Team & Collaboration Rules:**
     - [Rule Set Name]: [Brief description] (Source: .spec-chain/assets/playbooks/[filename])
     - [Additional team rule sets...]

     **Custom/Specialized Rules:**
     - [Rule Set Name]: [Brief description] (Source: .spec-chain/assets/playbooks/[filename])
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
       - Read the command file: `.claude/commands/spec-chain/doc-prompt-planner.md`
       - Update the first instance of `$ARGUMENTS` in the Variables section with `$SPEC_NAME`
       - Execute the updated command as a prompt
       - The prompt will:
         - Load all required documents from `.spec-chain/.spec-chain/specs/$SPEC_NAME/` directory
         - Load playbooks from `.spec-chain/.spec-chain/assets/playbooks/` directory
         - Load previous plan and validation feedback if ITERATION_COUNT > 1
         - Generate comprehensive implementation plan
         - Save output to `.spec-chain/.spec-chain/specs/$SPEC_NAME/IMPLEMENTATION_PLAN.md`
         - Handle all file persistence internally

       // Validate Implementation Plan
       - Read the command file: `.claude/commands/spec-chain/doc-prompt-planner-validator.md`
       - Update the first instance of `$ARGUMENTS` in the Variables section with `$SPEC_NAME`
       - Execute the updated command as a prompt
       - The prompt will:
         - Load all required documents from `.spec-chain/.spec-chain/specs/$SPEC_NAME/` directory
         - Load the current implementation plan
         - Determine current iteration number from existing validation reports
         - Generate comprehensive validation report
         - Save output to `.spec-chain/.spec-chain/specs/$SPEC_NAME/VALIDATION_REPORT_v${ITERATION_COUNT}.md`
         - Handle all file persistence internally

       // Check Validation Results
       - Extract VALIDATION_DECISION from validation report (APPROVED/NEEDS_REFINEMENT/MAJOR_REVISION_REQUIRED)
       - Extract COMPLETION_SCORE from validation report
       - Log: "Iteration ${ITERATION_COUNT}: ${VALIDATION_DECISION} (${COMPLETION_SCORE}% complete)"

       // Determine Next Action
       IF (VALIDATION_DECISION == "APPROVED") OR (COMPLETION_SCORE >= VALIDATION_THRESHOLD):
         - Set PLAN_STATUS = "APPROVED"
         - Log: "Implementation plan approved after ${ITERATION_COUNT} iterations"
         - BREAK from loop
       ELSE:
         - Set PLAN_STATUS = "NEEDS_REFINEMENT"
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

7. **Aggregate Clarification Requests**
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
   - Output directory: `$OUTPUT_DIR` (e.g., `.spec-chain/specs/my-app` or `.spec-chain/specs/20240120_143052`)
   - Generation mode: Interactive with Auto-Research
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
   > **Note:** The above clarification items indicate areas where additional information in .spec-chain/APP_DETAILS.md would improve the generated documentation. Consider adding these details to .spec-chain/APP_DETAILS.md and re-running the spec-chain process for more comprehensive results.
   
   If no clarification items were found:
   > **Note:** No clarification requests were recorded. The provided .spec-chain/APP_DETAILS.md contained sufficient information for comprehensive documentation generation.

6. **Next Steps**:

   **Immediate Actions:**
   - Review all documentation in `$OUTPUT_DIR`
   - Check clarification requests for any additional information needed
   - Create symlink to latest generation (done automatically in summary output)
   - Gather stakeholder feedback on the comprehensive specification

   **Implementation Phase:**
   - Begin implementation using the Implementation Plan
   - Follow any loaded playbook rules from `.spec-chain/assets/playbooks/`
   - Use validation reports to ensure comprehensive coverage

   **Iterative Improvement:**
   - Address any clarification requests found in the generated documents
   - Update .spec-chain/APP_DETAILS.md with new insights for future iterations
   - Re-run spec chain with updated .spec-chain/APP_DETAILS.md for refined documentation

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

This documentation was generated by the Spec Chain system. All files in this directory represent a complete application specification suite based on the .spec-chain/APP_DETAILS.md input file.
```

3. **Create Symlink**: Execute `ln -sfn $OUTPUT_DIR .spec-chain/specs/latest` to create a symlink pointing to this generation

## Error Handling

### General Prompt Failures
If any prompt execution fails:
1. Log the error with the specific prompt name
2. Continue with other prompts that don't depend on the failed output
3. Report all failures in the final summary
4. Suggest manual intervention for failed steps

### Interactive Information Gathering Errors
If information gathering encounters issues:
1. **APP_DETAILS.md Template Missing**: Copy from backup or recreate from scratch
2. **Invalid User Responses**: Gracefully handle unclear input and ask for clarification
3. **Auto-Research Failures**: Fall back to placeholder content and note in clarification summary
4. **File Write Permissions**: Ensure output directory is writable

## Intelligent Document Selection Examples

The system automatically determines which documents to generate based on app characteristics:

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

### Information Gathering
- **Auto-Research All**: Skip all optional fields and use intelligent auto-research
- **Manual Entry**: Provide specific details for all optional fields
- **Hybrid Approach**: Mix of manual entry and auto-research using skip options

### Document Generation
- **Intelligent Selection** (Default): Generate documents based on app type analysis
- **Force Full Generation**: Override intelligent selection to generate all documents
- **Manual Selection**: Specify exact documents to generate via command line flags
- **Profile-Based**: Use predefined profiles (mobile-app, api-service, cli-tool, desktop-app)

### Implementation Planning
- **Iteration Limit**: Set maximum iterations for implementation plan refinement (default: 5)
- **Validation Threshold**: Set minimum completion score for plan approval (default: 85%)
- **Save All Iterations**: Preserve all planning iterations and validation reports

Remember: The PRD is always required as it feeds all other documents.

## .spec-chain/APP_DETAILS.md Usage Summary

The runner extracts the following information from .spec-chain/APP_DETAILS.md:

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
- If `assets/inspiration/visual/` exists, its contents are passed to visual design prompts:
  - Style Guide (visual aspects)
  - Component Library (visual styling)
  - Interactive Preview (visual implementation)
  
- If `assets/inspiration/functional/` exists, its contents are passed to functional design prompts:
  - Technical Overview (architecture and implementation patterns)
  - Component Library (behaviors and interactions)
  - User Flows (navigation and workflows)
  - Information Architecture (organization and hierarchy)
  - Interactive Preview (functional implementation)

This centralized approach ensures consistency across all generated documents.