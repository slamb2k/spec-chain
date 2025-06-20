# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with the Spec Chain documentation generator.

## Repository Overview

Spec Chain is an AI-powered documentation generator that creates comprehensive software documentation from a single APP_DETAILS.md file. It consists of 19 interconnected prompts that build upon each other to generate a complete documentation suite.

## Project Structure

```
spec-chain/
├── .claude/
│   └── commands/
│       └── spec-chain/             # All spec-chain commands and prompts
│           ├── init-spec-chain.md      # Initialize project
│           ├── validate-spec-chain.md  # Validate setup
│           ├── run-spec-chain.md       # Generate docs
│           └── [19 prompt files]       # Document generation prompts
├── assets/
│   └── inspiration/
│       ├── visual/                 # Visual references
│       └── functional/             # Functional references
├── specs/                          # Generated documentation
│   └── [timestamp]/                # Timestamped outputs
└── APP_DETAILS.md                  # Project configuration
```

## Key Commands

### Initialize a Project
```bash
# From .claude/commands/spec-chain/
init-spec-chain
```
Creates directory structure and APP_DETAILS.md template.

### Validate Setup
```bash
# From .claude/commands/spec-chain/
validate-spec-chain
```
Checks all requirements and provides status report.

### Generate Documentation
```bash
# From .claude/commands/spec-chain/
run-spec-chain
```
Executes all 19 prompts to create documentation suite using parallel Task agents for ~60% faster generation.

## Working with Spec Chain

### 1. APP_DETAILS.md
- This is the single source of truth for all project information
- Contains sections for business, technical, and design requirements
- All prompts read from this file to maintain consistency

### 2. Inspiration Materials
- **Visual** (`/assets/inspiration/visual/`): Colors, typography, UI styles
- **Functional** (`/assets/inspiration/functional/`): Layouts, workflows, interactions
- Prompts analyze these materials to inform documentation

### 3. Generated Documentation
- All output goes to `/specs/[timestamp]/`
- Each run creates a unique timestamped directory
- Preserves documentation history for comparison

## Prompt Dependencies & Execution Flow

The runner uses parallel execution to optimize generation time:

```
Phase 1: Foundation (1 prompt)
    └── PRD.md

Phase 2: Business & Design (4 prompts - PARALLEL)
    ├── GTM_STRATEGY.md
    ├── BUSINESS_RULES.md
    └── STYLE_GUIDE.md

Phase 2.1: Design Dependencies (1 prompt)
    └── WIREFRAMES.md (depends on Style Guide)

Phase 2.2: Design Completion (3 prompts - PARALLEL)
    ├── USER_FLOWS.md
    ├── INFORMATION_ARCHITECTURE.md
    └── COMPONENT_LIBRARY.md

Phase 3: Technical Architecture (1 prompt)
    └── TECHNICAL_SPEC.md

Phase 3.1: Technical Dependencies (5 prompts - PARALLEL)
    ├── API_SPEC.md
    ├── DATA_MODEL.md
    ├── SECURITY_ARCHITECTURE.md
    ├── INTEGRATIONS.md
    └── PERFORMANCE_SCALABILITY.md

Phase 4: Interactive Preview (1 prompt)
Phase 5: Implementation (1 prompt)
Phase 5.1: Final Documents (3 prompts - PARALLEL)
```

## Important Notes

1. **Optimized Execution**: Prompts run in phases with parallel execution where possible
2. **Timestamp Directories**: Each generation creates a new timestamped folder
3. **Inspiration Separation**: Visual and functional inspiration are kept separate
4. **Validation First**: Always run validate-spec-chain before generating docs
5. **Parallel Performance**: Independent prompts execute concurrently using Task agents

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
   - Validate changes with a full documentation generation
   - Check that all prompts execute without errors
   - Verify output quality and completeness

## Common Tasks

### Add a New Documentation Type
1. Create new prompt in `.claude/commands/spec-chain/`
2. Add execution step in appropriate phase of `spec-chain/run-spec-chain.md`
3. Update README.md documentation list
4. Test full generation cycle

### Modify Existing Prompt
1. Edit prompt file in `.claude/commands/spec-chain/`
2. Ensure output format remains compatible with dependent prompts
3. Run validation and full generation to test

### Debug Generation Issues
1. Check validate-spec-chain output for errors
2. Verify APP_DETAILS.md is completely filled out
3. Ensure inspiration directories contain appropriate materials
4. Check individual prompt outputs in `/specs/[timestamp]/`

## Current Configuration

The repository has Claude Code permissions configured in `.claude/settings.local.json` allowing:
- `ls` command
- `find` command