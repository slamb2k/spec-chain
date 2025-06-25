# Claude Commands Directory

This directory contains custom Claude Code commands for the Spec Chain project. These commands provide specialized functionality for AI-powered documentation generation and project management.

## Directory Structure

```
.claude/commands/
├── README.md                    # This file
├── prime.md                     # Context priming command
└── spec-chain/                  # Spec Chain documentation system
    ├── init-spec-chain.md           # Project initialization
    ├── validate-spec-chain.md       # Setup validation
    ├── run-spec-chain.md           # Documentation generation pipeline
    └── [9 doc-prompt files]        # Document generation prompts
```

## Available Commands

### 🎯 Context & Setup Commands

#### `/prime`
**File**: `prime.md`
**Purpose**: Context priming command that helps Claude understand the project structure
**Usage**: `/prime`
**Description**: 
- Runs `eza . --tree --git-ignore` to show project structure
- Reads key documentation files (README.md, COMMANDS.md, AI_DOCS.md, SPECS.md)
- Provides comprehensive project context for better assistance

### 🚀 Spec Chain System

The spec-chain system is a comprehensive AI-powered documentation generator that creates complete software specifications from a single APP_DETAILS.md file. All generated content is isolated in a `.spec-chain` directory for clean project organization and portability.

**Note for Claude:** When working with spec-chain commands, all prompts are self-documenting and include their own instructions. The commands work together to generate comprehensive documentation through multiple phases with parallel execution where possible.

#### Core Management Commands

##### `/init-spec-chain`
**File**: `spec-chain/init-spec-chain.md`
**Purpose**: Initialize a new Spec Chain project
**Usage**: `/init-spec-chain`
**Description**:
- Creates required directory structure (`.spec-chain/specs/`, `.spec-chain/assets/inspiration/`)
- Generates `.spec-chain/APP_DETAILS.md` template with detailed instructions
- Sets up inspiration directories with usage guides
- Validates Claude Code permissions and environment
- Keeps your project root clean by isolating all spec-chain files

##### `/validate-spec-chain`
**File**: `spec-chain/validate-spec-chain.md`
**Purpose**: Validate project setup and requirements
**Usage**: `/validate-spec-chain`
**Description**:
- Checks `.spec-chain/` directory exists and is properly initialized
- Validates `.spec-chain/APP_DETAILS.md` completeness and format
- Reports on inspiration materials availability in `.spec-chain/assets/`
- Provides detailed status report with ✅/⚠️/❌ indicators
- Ensures environment is ready for documentation generation

##### `/run-spec-chain`
**File**: `spec-chain/run-spec-chain.md`
**Purpose**: Execute the complete documentation generation pipeline
**Usage**: `/run-spec-chain [spec-name] [start-phase] [parallel-agents]`
**Description**:
- Generates 8 core documents in optimized phases
- Uses parallel execution for independent documents
- Manages dependencies between document types
- Creates timestamped output directories
- Includes iterative validation for implementation plans
- Supports resuming from specific phases
- Interactively gathers missing APP_DETAILS.md information
- Auto-researches optional fields when requested

**Parameters**:
- `spec-name`: Optional - Output directory name (defaults to timestamp)
- `start-phase`: Optional - Resume from specific phase (1-5, defaults to 1)
- `parallel-agents`: Optional - Number of UI preview agents (defaults to 5)

**Examples**:
- `/run-spec-chain` - Generate with timestamp
- `/run-spec-chain my-app` - Generate in `.spec-chain/specs/my-app/`
- `/run-spec-chain my-app 3` - Resume from Phase 3
- `/run-spec-chain my-app 1 8` - Generate with 8 parallel UI design agents

#### Document Generation Prompts

The spec-chain system includes 9 specialized prompts that generate 8 core documents:

##### `/doc-prompt-prd`
**File**: `spec-chain/doc-prompt-prd.md`
**Purpose**: Generate Product Requirements Document (foundation)
**Usage**: `/doc-prompt-prd SPEC_NAME`
**Dependencies**: .spec-chain/APP_DETAILS.md
**Output**: PRD.md

##### `/doc-prompt-feature-stories`
**File**: `spec-chain/doc-prompt-feature-stories.md`
**Purpose**: Create detailed feature stories and user scenarios
**Usage**: `/doc-prompt-feature-stories SPEC_NAME`
**Dependencies**: PRD.md, TECHNICAL_OVERVIEW.md (if available)
**Output**: FEATURE_STORIES.md
**Parallel**: Can run with technical-overview and style

##### `/doc-prompt-technical-overview`
**File**: `spec-chain/doc-prompt-technical-overview.md`
**Purpose**: Generate high-level technical architecture overview
**Usage**: `/doc-prompt-technical-overview SPEC_NAME`
**Dependencies**: PRD.md, .spec-chain/APP_DETAILS.md (technical requirements)
**Output**: TECHNICAL_OVERVIEW.md
**Parallel**: Can run with feature-stories and style

##### `/doc-prompt-style`
**File**: `spec-chain/doc-prompt-style.md`
**Purpose**: Generate UI/UX style guide and design system
**Usage**: `/doc-prompt-style SPEC_NAME`
**Dependencies**: PRD.md, .spec-chain/APP_DETAILS.md (design requirements)
**Output**: STYLE_GUIDE.md
**Parallel**: Can run with feature-stories and technical-overview

##### `/doc-prompt-states`
**File**: `spec-chain/doc-prompt-states.md`
**Purpose**: Create UI states and screen snapshots
**Usage**: `/doc-prompt-states SPEC_NAME`
**Dependencies**: FEATURE_STORIES.md, STYLE_GUIDE.md
**Output**: UI_STATES.md

##### `/doc-prompt-ui-preview`
**File**: `spec-chain/doc-prompt-ui-preview.md`
**Purpose**: Generate interactive UI preview with working components
**Usage**: `/doc-prompt-ui-preview SPEC_NAME`
**Dependencies**: STYLE_GUIDE.md, UI_STATES.md
**Output**: UI_PREVIEW.html

##### `/doc-prompt-technical`
**File**: `spec-chain/doc-prompt-technical.md`
**Purpose**: Generate comprehensive technical specification
**Usage**: `/doc-prompt-technical SPEC_NAME`
**Dependencies**: All previous documents
**Output**: TECHNICAL_SPEC.md

##### `/doc-prompt-planner`
**File**: `spec-chain/doc-prompt-planner.md`
**Purpose**: Generate AI-optimized implementation plan
**Usage**: `/doc-prompt-planner SPEC_NAME`
**Dependencies**: TECHNICAL_SPEC.md, playbooks from `.spec-chain/assets/playbooks/`
**Output**: IMPLEMENTATION_PLAN.md

##### `/doc-prompt-planner-validator`
**File**: `spec-chain/doc-prompt-planner-validator.md`
**Purpose**: Validate implementation plan completeness
**Usage**: `/doc-prompt-planner-validator SPEC_NAME`
**Dependencies**: IMPLEMENTATION_PLAN.md, all specification documents
**Output**: VALIDATION_REPORT_v[N].md

## Key Features

### 🔄 File-Based Architecture (v2.0)
- **Simplified Execution**: All prompts only require spec name as argument
- **Self-Contained Operations**: Each prompt handles its own file loading and persistence
- **Consistent Interface**: Identical calling pattern across all prompts
- **Automatic Persistence**: Files saved automatically to `/specs/SPEC_NAME/` directory

### ⚡ Parallel Execution
- **Optimized Performance**: Independent documents generate simultaneously
- **Smart Dependencies**: Only waits when actual dependencies exist
- **Time Reduction**: 25-33% faster than sequential execution
- **Resource Efficiency**: Maximizes concurrent processing opportunities

### 🔄 Iterative Validation
- **Quality Assurance**: Implementation plans validated against all specifications
- **Refinement Loop**: Up to 5 iterations for plan improvement
- **Threshold-Based Approval**: Minimum 85% completion score required
- **Comprehensive Coverage**: Validates against all requirement documents

## Execution Flow

```
Phase 1: Foundation (Sequential)
└── PRD.md

Phase 2: Feature Analysis & Technical Overview (Parallel)
├── FEATURE_STORIES.md
└── TECHNICAL_OVERVIEW.md (depends on PRD)

Phase 3: Design & UI/UX (Sequential)
├── STYLE_GUIDE.md
├── UI_STATES.md (depends on Style Guide)
└── UI_PREVIEW.html (depends on Style Guide and UI States)

Phase 4: Technical Architecture (Sequential)
└── TECHNICAL_SPEC.md (depends on Technical Overview)

Phase 5: Planning & Implementation Rules (Sequential)
├── 5.1: Load Playbooks and Rules (depends on Technical Spec)
└── 5.2: Generate Implementation Plan with Iterative Validation (depends on Playbooks)
```

## Generated Output Structure

```
.spec-chain/specs/SPEC_NAME/
├── APP_DETAILS.md (input)
├── PRD.md (Phase 1)
├── FEATURE_STORIES.md (Phase 2a)
├── TECHNICAL_OVERVIEW.md (Phase 2b)
├── STYLE_GUIDE.md (Phase 3a)
├── UI_STATES.md (Phase 3b)
├── UI_PREVIEW.html (Phase 3c)
├── TECHNICAL_SPEC.md (Phase 4)
├── IMPLEMENTATION_PLAN.md (Phase 5)
├── VALIDATION_REPORT_v*.md (Phase 5 validation)
└── README.md (summary)
```

## Usage Examples

### Quick Start
```bash
/init-spec-chain                    # Initialize project
# Edit .spec-chain/APP_DETAILS.md with your project info
/validate-spec-chain               # Validate setup
/run-spec-chain my-app             # Generate all documentation
```

### Individual Document Generation
```bash
/doc-prompt-prd my-app             # Generate PRD only
/doc-prompt-technical my-app       # Generate technical spec
/doc-prompt-planner my-app         # Generate implementation plan
```

### Parallel Execution Example
```bash
# Phase 2 & 3a can run simultaneously
/doc-prompt-feature-stories my-app &
/doc-prompt-technical-overview my-app &
/doc-prompt-style my-app &
wait
```

## Benefits

- **Consistency**: All documents follow the same structure and terminology
- **Completeness**: Comprehensive prompts ensure nothing is forgotten
- **Speed**: Parallel execution reduces generation time significantly
- **Quality**: Based on industry best practices and iterative validation
- **Flexibility**: Individual prompts can be run independently
- **Maintainability**: File-based architecture simplifies debugging and updates
- **Portability**: All spec-chain files isolated in `.spec-chain/` directory
- **Clean Projects**: Your project directory remains uncluttered
