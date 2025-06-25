# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with the Spec Chain documentation generator.

## Repository Overview

Spec Chain is a Claude Code custom command system that generates comprehensive software documentation from a single APP_DETAILS.md file. It uses 9 specialized prompts that work together to generate 8 core documents with iterative validation for implementation planning.

## Project Structure

```
spec-chain/
├── .claude/
│   ├── CLAUDE.md                   # Claude Code guidance (this file)
│   └── commands/
│       ├── COMMANDS.md                 # Command documentation
│       ├── prime.md                    # Context priming
│       └── spec-chain/                 # All spec-chain commands and prompts
│           ├── init-spec-chain.md          # Initialize project
│           ├── validate-spec-chain.md      # Validate setup
│           ├── run-spec-chain.md           # Generate docs
│           └── [9 doc-prompt files]        # Document generation prompts
├── ai_docs/
│   ├── AI_DOCS.md                  # AI documentation overview
│   ├── extended_thinking.md        # Claude extended thinking guide
│   ├── implement-tool-use.md       # Tool use implementation guide
│   └── prompt_caching.md          # Prompt caching optimization
├── assets/
│   └── inspiration/
│       ├── visual/                 # Visual references
│       └── functional/             # Functional references
├── specs/
│   ├── SPECS.md                    # Generated documentation guide
│   └── [timestamp]/                # Timestamped outputs
└── APP_DETAILS.md                  # Project configuration
```

## Key Commands

### Initialize a Project
```
/init-spec-chain
```
Creates directory structure and APP_DETAILS.md template.

### Validate Setup
```
/validate-spec-chain
```
Checks all requirements and provides status report.

### Generate Documentation
```
/run-spec-chain [spec-name] [start-phase] [parallel-agents]
```
Executes the documentation generation pipeline using parallel Task agents for optimized performance, including iterative validation.

**Parameters:**
- `spec-name`: Optional - Output directory name (defaults to timestamp)
- `start-phase`: Optional - Resume from specific phase (1-5, defaults to 1)
- `parallel-agents`: Optional - Number of UI preview agents (defaults to 5)

**Examples:**
- `/run-spec-chain` - Generate with timestamp
- `/run-spec-chain my-app` - Generate in /specs/my-app/
- `/run-spec-chain my-app 3` - Resume from Phase 3
- `/run-spec-chain my-app 1 8` - Generate with 8 parallel UI design agents

## Generated Documents

A complete spec-chain run produces 8 core documents:
1. **PRD.md** - Product Requirements Document
2. **FEATURE_STORIES.md** - Detailed feature breakdowns
3. **TECHNICAL_OVERVIEW.md** - High-level architecture
4. **STYLE_GUIDE.md** - UI/UX design system
5. **UI_STATES.md** - Screen mockups and states
6. **UI_PREVIEW.html** - Interactive UI preview across platforms
7. **TECHNICAL_SPEC.md** - Detailed technical specification
8. **IMPLEMENTATION_PLAN.md** - AI-optimized development plan

Additional outputs:
- **IMPLEMENTATION_PLAN_v[1-N].md** - Iteration versions
- **VALIDATION_REPORT_v[1-N].md** - Validation feedback for each iteration

## Available Prompts

The spec-chain system includes 9 specialized document generation prompts:

1. **doc-prompt-prd.md** - Generates the Product Requirements Document (foundation)
2. **doc-prompt-feature-stories.md** - Creates detailed feature stories and user scenarios
3. **doc-prompt-technical-overview.md** - Produces high-level technical architecture overview
4. **doc-prompt-style.md** - Generates UI/UX style guide and design system
5. **doc-prompt-states.md** - Creates UI states and screen snapshots
6. **doc-prompt-ui-preview.md** - Generates interactive UI preview with working components
7. **doc-prompt-technical.md** - Produces comprehensive technical specification
8. **doc-prompt-planner.md** - Generates AI-optimized implementation plan
9. **doc-prompt-planner-validator.md** - Validates implementation plan completeness

## Working with Spec Chain

### 1. APP_DETAILS.md
- This is the single source of truth for all project information
- Contains sections for business, technical, and design requirements
- All prompts read from this file to maintain consistency
- **New in v2.0**: If APP_DETAILS.md is incomplete or missing, `/run-spec-chain` will:
  - Create from template if missing
  - Interactively gather required fields
  - Auto-research optional fields if desired

### 2. Inspiration Materials
- **Visual** (`/assets/inspiration/visual/`): Colors, typography, UI styles
- **Functional** (`/assets/inspiration/functional/`): Layouts, workflows, interactions
- Prompts analyze these materials to inform documentation

### 3. Generated Documentation
- All output goes to `/specs/[spec-name]/` or `/specs/[timestamp]/`
- Each run creates a unique directory (named or timestamped)
- Generates 8 core documents plus validation reports
- Preserves documentation history for comparison

## Prompt Dependencies & Execution Flow

The runner uses parallel execution to optimize generation time:

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

## Important Notes

1. **Optimized Execution**: Prompts run in phases with parallel execution where possible
2. **Timestamp Directories**: Each generation creates a new timestamped folder
3. **Inspiration Separation**: Visual and functional inspiration are kept separate
4. **Validation First**: Always run validate-spec-chain before generating docs (or let run-spec-chain handle missing data)
5. **Parallel Performance**: Independent prompts execute concurrently using Task agents
6. **Iterative Validation**: Implementation plans are validated and refined up to 5 times for quality assurance
7. **Interactive Setup**: run-spec-chain can interactively gather missing APP_DETAILS.md information
8. **Auto-Research**: Optional fields can be automatically researched based on context
9. **Playbook Integration**: Implementation plans automatically integrate rules from `/assets/playbooks/`

## Development Guidelines

When modifying Spec Chain:

1. **Prompt Updates**: 
   - Maintain consistent structure across all prompts
   - Preserve input/output contracts between prompts
   - Update dependencies if changing prompt order

2. **New Prompts**:
   - Follow existing naming convention: `doc-prompt-[name].md`
   - Add to appropriate phase in `spec-chain/run-spec-chain.md`
   - Consider if it can run in parallel with other prompts
   - Update documentation flow diagram

3. **Testing**:
   - Validate changes with a full documentation generation using `/run-spec-chain`
   - Check that all prompts execute without errors
   - Verify output quality and completeness
   - Review validation reports for implementation plan iterations

## Implementation Plan Validation Process

The spec-chain now includes an iterative validation process for implementation plans:

1. **Initial Generation**: The `doc-prompt-planner.md` generates an implementation plan based on all prior specifications
2. **Validation**: The `doc-prompt-planner-validator.md` evaluates the plan against requirements
3. **Iterative Refinement**: If the plan doesn't meet the 85% completion threshold, it's refined based on validation feedback
4. **Maximum Iterations**: Up to 5 iterations are performed to achieve an approved plan
5. **Output Files**: 
   - `IMPLEMENTATION_PLAN.md` - The final approved plan
   - `IMPLEMENTATION_PLAN_v1.md` through `IMPLEMENTATION_PLAN_v[N].md` - All iteration versions
   - `VALIDATION_REPORT_v1.md` through `VALIDATION_REPORT_v[N].md` - Validation feedback for each iteration

This ensures the implementation plan comprehensively covers all requirements and integrates any loaded playbook rules.

## Common Tasks

### Add a New Documentation Type
1. Create new prompt in `.claude/commands/spec-chain/` following naming convention: `doc-prompt-[name].md`
2. Add execution step in appropriate phase of `.claude/commands/spec-chain/run-spec-chain.md`
3. Update README.md and CLAUDE.md documentation lists
4. Test full generation cycle with `/run-spec-chain`

### Modify Existing Prompt
1. Edit prompt file in `.claude/commands/spec-chain/`
2. Ensure output format remains compatible with dependent prompts
3. Run validation and full generation to test

### Debug Generation Issues
1. Run `/validate-spec-chain` to check for errors
2. Verify APP_DETAILS.md is completely filled out
3. Ensure inspiration directories contain appropriate materials
4. Check individual prompt outputs in `/specs/[spec-name]/`
5. Review validation reports for implementation plan issues

## Related Resources

- **Claude API Documentation**: https://docs.anthropic.com/
- **Spec Chain Commands**: `/.claude/commands/spec-chain/`
- **Command Documentation**: `/.claude/commands/COMMANDS.md`
- **AI Documentation**: `/ai_docs/AI_DOCS.md`
- **Generated Documentation Guide**: `/specs/SPECS.md`
- **Project Examples**: `/specs/` directory
- **Implementation Guides**: Individual prompt documentation

## Current Configuration

The repository has Claude Code permissions configured in `.claude/settings.local.json` allowing:
- `ls` command
- `find` command