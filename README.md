# Spec Chain - AI-Powered Documentation Generator

A comprehensive system of AI prompts that work together to generate complete product documentation from a single app idea. This repository contains the spec-chain methodology for creating full documentation suites using AI with optimized parallel execution and simplified file-based operations.

**Use spec-chain in any project:** Simply run `/init-spec-chain` in any directory to initialize it for spec-chain usage. All generated content is isolated in a `.spec-chain` directory for portability and clean project organization.

## 📦 Installation

### Quick Install (Recommended)

**Using npm (global installation):**
```bash
npm install -g claude-spec-chain
claude-spec-chain install
```

**Using shell script (Linux/macOS/WSL):**
```bash
curl -fsSL https://raw.githubusercontent.com/yourusername/spec-chain/main/install.sh | bash
```

**Note:** Claude Code runs on Linux. Windows users should use WSL (Windows Subsystem for Linux).

**Deployment Note:** For clean deployment, only the core spec-chain commands are included in packages. The `prime.md` and `CLAUDE.md` files are development-specific and should be customized per project if needed.

### Other Installation Methods

**Download and extract:**
1. Download the latest release from [GitHub Releases](https://github.com/yourusername/spec-chain/releases)
2. Extract the `.claude` directory to your project root
3. Open your project in Claude Code

**Git clone:**
```bash
git clone https://github.com/yourusername/spec-chain.git
cp -r spec-chain/.claude your-project/
```

**Global installation with shell script:**
```bash
# Install globally to ~/.claude-commands/spec-chain
curl -fsSL https://raw.githubusercontent.com/yourusername/spec-chain/main/install.sh | bash -s -- --global

# Then in any project:
claude-spec-chain install
```

## 🚀 What is Spec Chain?

Spec Chain is a collection of 9 carefully crafted AI prompts that generate 8 core documents with iterative validation for comprehensive software documentation. Each prompt is designed to produce specific documentation that builds upon previous outputs, creating a complete specification suite. All documentation is generated from a single `APP_DETAILS.md` file and optional inspiration materials.

### ⚡ **New in v3.0**: Isolated Project Structure
- **Isolated Generation**: All spec-chain files now live in `.spec-chain/` directory
- **Portable Commands**: Initialize and run spec-chain in any project directory
- **Easy Verification**: Simple check for `.spec-chain/` directory confirms initialization
- **Any Directory**: Works in any folder after running `/init-spec-chain`

### **v2.0 Features**: Simplified Execution & Parallel Processing
- **File-Based Architecture**: All prompts now use simplified file-based loading instead of complex argument passing
- **Parallel Execution**: Independent documents generate simultaneously, reducing total time by 25-33%
- **Single Argument Interface**: All prompts now only require the spec name as an argument
- **Self-Contained Operations**: Each prompt handles its own file loading and persistence internally

## 🎯 Quick Start

1. **Initialize your project**:
   ```bash
   /init-spec-chain
   ```
   This creates the required directory structure and APP_DETAILS.md template.

2. **Create your APP_DETAILS.md**:
   - The template is automatically created by `/init-spec-chain`
   - Fill out the required fields (App Name, App Idea, MVP Features, Target Users)
   - Optional fields can be left blank - they will be auto-researched
   - **Note**: If APP_DETAILS.md is incomplete, `/run-spec-chain` will interactively gather missing information

3. **Add inspiration materials** (optional):
   - Visual references → `/assets/inspiration/visual/`
   - Functional examples → `/assets/inspiration/functional/`

4. **Validate your setup**:
   ```bash
   /validate-spec-chain
   ```

5. **Generate documentation**:
   ```bash
   /run-spec-chain
   ```

## 📋 Available Documentation Generators

The `.claude/commands/spec-chain/` directory contains 9 specialized prompts that generate 8 core documents:

### Document Generation Prompts
1. **doc-prompt-prd.md** - Product Requirements Document (foundation)
2. **doc-prompt-feature-stories.md** - Detailed feature stories and user scenarios
3. **doc-prompt-technical-overview.md** - High-level technical architecture
4. **doc-prompt-style.md** - UI/UX style guide and design system
5. **doc-prompt-states.md** - UI states and screen snapshots
6. **doc-prompt-ui-preview.md** - Interactive UI preview with working components
7. **doc-prompt-technical.md** - Comprehensive technical specification
8. **doc-prompt-planner.md** - AI-optimized implementation plan
9. **doc-prompt-planner-validator.md** - Implementation plan validator

### Command Utilities
- **init-spec-chain.md** - Initialize project structure
- **validate-spec-chain.md** - Validate setup and requirements
- **run-spec-chain.md** - Execute documentation generation pipeline

## 🔄 Documentation Flow

```
Initial Idea → PRD → Business/Design/Technical → Implementation → Operations
```

The runner now uses **parallel execution** to generate multiple documents concurrently, optimizing total generation time. See the complete flow diagram below for detailed dependencies.

## 🎯 How to Use Spec Chain

### Quick Start (Minimal Documentation)
```bash
1. Use doc-prompt-prd.md with your app idea
2. Use doc-prompt-technical.md with the PRD output
3. Use doc-prompt-planner.md for development plan (with validation)
```

### Full Documentation Suite
```bash
1. Fill out APP_DETAILS.md with your project information
2. Optionally add inspiration materials to /assets/inspiration/
3. Run /validate-spec-chain to ensure setup is correct
4. Execute /run-spec-chain to generate all documentation
5. Review generated documents in /specs/[spec-name]/
6. Iterate on APP_DETAILS.md and regenerate as needed
```

### For Claude Code Users
The `doc-prompt-planner.md` prompt is specifically optimized for AI-assisted development, breaking work into clear, manageable sessions. The implementation plan now includes iterative validation to ensure comprehensive coverage.

## 📊 Documentation Flow Diagram

The Spec Chain runner executes prompts in optimized phases with parallel execution:

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
         └── IMPLEMENTATION_PLAN.md (with up to 5 validation iterations)
```

**Key:** Prompts marked as PARALLEL execute concurrently using Task agents

## 📁 Project Structure

### Spec Chain Repository Structure

This is the complete structure of the Spec Chain repository - the source code and all files that make up this project:

```
spec-chain/                         # This repository
├── .claude/                        # Claude Code integration
│   ├── CLAUDE.md                   # Claude Code guidance and project context
│   ├── settings.local.json         # Claude Code permissions
│   └── commands/
│       ├── prime.md                # Context priming command (dev-specific)
│       └── spec-chain/             # Core spec-chain commands
│           ├── COMMANDS.md         # Command documentation
│           ├── init-spec-chain.md  # Initialize project command
│           ├── validate-spec-chain.md # Validate setup command
│           ├── run-spec-chain.md   # Main generation pipeline
│           ├── doc-prompt-prd.md   # Product Requirements Document
│           ├── doc-prompt-feature-stories.md # Feature stories
│           ├── doc-prompt-technical-overview.md # Technical overview
│           ├── doc-prompt-style.md # UI/UX style guide
│           ├── doc-prompt-states.md # UI states and mockups
│           ├── doc-prompt-ui-preview.md # Interactive UI preview
│           ├── doc-prompt-technical.md # Technical specification
│           ├── doc-prompt-planner.md # Implementation planning
│           └── doc-prompt-planner-validator.md # Plan validation
├── .github/                        # GitHub Actions workflows
│   └── workflows/
│       ├── claude-code-review.yml  # Code review automation
│       ├── claude.yml              # Claude integration
│       └── release.yml             # Release automation
├── bin/                            # CLI executable
│   └── claude-spec-chain.js        # npm CLI tool
├── lib/                            # Library code
│   └── postinstall.js             # Post-installation script
├── .gitignore                      # Git ignore rules
├── .npmignore                      # npm ignore rules
├── package.json                    # npm package configuration
├── README.md                       # This file
├── INSTALL.md                      # Installation instructions
├── install.sh                      # Shell installation script
└── LICENSE                         # MIT license
```

### Your Project Directory (After Running `/init-spec-chain`)

This is what any project directory will look like after you initialize spec-chain. This structure is created when you run `/init-spec-chain` in any directory:

```
your-project/                       # Any existing project directory
├── .spec-chain/                    # Created by /init-spec-chain
│   ├── APP_DETAILS.md              # Your application details and requirements
│   ├── assets/
│   │   ├── inspiration/
│   │   │   ├── visual/            # Visual design references (images, mockups)
│   │   │   └── functional/        # Functional/UX references (workflows, layouts)
│   │   └── playbooks/             # Development playbooks and rules
│   └── specs/
│       ├── SPECS.md               # Generated documentation guide
│       └── [timestamp]/           # Each /run-spec-chain creates timestamped folder
│           ├── PRD.md             # Product Requirements Document
│           ├── FEATURE_STORIES.md # Detailed feature stories
│           ├── TECHNICAL_OVERVIEW.md # High-level architecture
│           ├── STYLE_GUIDE.md     # UI/UX design system
│           ├── UI_STATES.md       # Screen mockups and states
│           ├── UI_PREVIEW.html    # Interactive UI preview
│           ├── TECHNICAL_SPEC.md  # Detailed technical specification
│           ├── IMPLEMENTATION_PLAN.md # AI-optimized development plan
│           └── VALIDATION_REPORT_v*.md # Plan validation reports
├── .claude/                        # Claude Code commands (installed separately)
│   └── commands/
│       └── spec-chain/            # Only the core commands (no prime.md or CLAUDE.md)
│           └── [command files]     # The 12 spec-chain command files
└── [your existing files]          # Your original project files remain untouched
```

### Key Differences:

- **Repository Structure**: The complete Spec Chain project with source code, workflows, and development files
- **User Project Structure**: Clean, isolated spec-chain functionality added to any existing project
- **Installation Content**: Only the core `spec-chain/` commands are deployed to user projects
- **Development vs. Production**: Repository contains development files (`prime.md`, `CLAUDE.md`) that aren't deployed
- **Clean Separation**: User projects get only what they need, keeping their directory structure clean

## 🛠️ Key Commands

### 🎲 init-spec-chain
Initializes spec-chain in the current directory:
- Creates `.spec-chain/` directory structure
- Generates `.spec-chain/APP_DETAILS.md` from embedded template with detailed instructions
- Sets up `.spec-chain/assets/inspiration/` directories with guides
- Works in any directory - transforms it into a spec-chain enabled project

### ✅ validate-spec-chain
Validates spec-chain setup in the current directory:
- Checks `.spec-chain/` directory exists and is properly initialized
- Validates `.spec-chain/APP_DETAILS.md` completeness
- Reports on inspiration materials in `.spec-chain/assets/`
- Provides detailed status report with ✅/⚠️/❌ indicators
- Confirms the directory is ready for documentation generation

### 🚀 run-spec-chain
Generates complete documentation suite:
- Creates timestamped output directory  
- Executes all prompts in optimized phases to generate 8 core documents
- **Uses parallel Task agents** for independent prompts
- Manages dependencies between documents
- Produces comprehensive documentation set

**Usage**: `/run-spec-chain [spec-name] [start-phase] [parallel-agents]`
- `spec-name`: Optional - Output directory name (defaults to timestamp)
- `start-phase`: Optional - Resume from specific phase (1-5, defaults to 1)
- `parallel-agents`: Optional - Number of UI preview agents (defaults to 5)

## 📋 APP_DETAILS.md Structure

The APP_DETAILS.md file is the single source of truth for your project. It includes:

- **Basic Information**: App name, idea, MVP features
- **Target Users**: Primary and secondary personas
- **Business Context**: Market, competition, business model
- **Technical Requirements**: Platform, technology, performance, scale
- **Design Requirements**: Brand, visual style, accessibility
- **Feature Details**: Workflows, content types, priorities
- **Integration Requirements**: External services, APIs
- **Success Metrics**: Business, technical, user satisfaction
- **Go-to-Market Strategy**: Target market, value proposition, launch plan

## 🎨 Inspiration Materials

Spec Chain can use reference materials to enhance documentation quality:

### Visual Inspiration (`/assets/inspiration/visual/`)
- Color schemes and palettes
- Typography examples
- UI styling and effects
- Button and form designs
- Visual hierarchy examples

### Functional Inspiration (`/assets/inspiration/functional/`)
- Layout structures
- Navigation patterns
- Form workflows
- Data display patterns
- Interaction behaviors

## 🔧 Special Features

### Interactive APP_DETAILS.md Gathering
The `/run-spec-chain` command now includes interactive features:
- **Automatic template creation** if APP_DETAILS.md doesn't exist
- **Interactive prompting** for missing required fields
- **Auto-research option** for optional fields (market analysis, competition, etc.)
- **Smart validation** to ensure all necessary information is captured

### AI-Optimized Implementation Plans with Validation
The implementation planning process now includes iterative validation:
- **doc-prompt-planner.md** generates development plans structured for AI coding assistants
- **doc-prompt-planner-validator.md** validates the plan against all specifications
- Up to 5 iterations of refinement based on validation feedback
- Minimum 85% completion score required for approval
- Session-based task breakdown with clear acceptance criteria
- Automatic integration of loaded playbook rules from `.spec-chain/assets/playbooks/`

### Visual Documentation
The spec-chain prompts generate various visual elements within the documentation:
- ASCII art representations in UI_STATES.md
- Structured diagrams in technical specifications
- Clear hierarchical representations of system architecture

## 📈 Benefits

- **Consistency**: All documents follow the same structure and terminology
- **Completeness**: Nothing gets forgotten with comprehensive prompts
- **Speed**: Generate comprehensive documentation in minutes with parallel execution
- **Quality**: Based on industry best practices
- **Flexibility**: Customize prompts for your specific needs
- **Performance**: Parallel execution using Task agents for independent prompts

## 🔐 Permissions Configuration

**Claude Code will automatically ask for permissions as spec-chain runs** - you can simply approve each request as it appears. However, if you prefer to set up permissions in advance for a smoother experience, here's a sample `.claude/settings.local.json` configuration that covers the initial permissions required to make spec-chain run smoothly:

**Optional: Pre-configure permissions in `.claude/settings.local.json`:**
```json
{
  "permissions": {
    "allow": [
      "Read(.spec-chain/**)",
      "Write(.spec-chain/**)",
      "Edit(.spec-chain/**)",
      "MultiEdit(.spec-chain/**)",
      "Bash(mkdir:.spec-chain/**)",
      "Bash(ls:.spec-chain/**)",
      "Bash(pwd)",
      "Bash(cp:.spec-chain/**)",
      "Bash(echo:*)",
      "Bash(date)",
      "Bash(test:.spec-chain/**)"
    ]
  }
}
```

**Note:** 
- If this file doesn't exist, create it in your project's `.claude/` directory
- Restart Claude Code after adding permissions for them to take effect
- These permissions allow spec-chain to create and manage its isolated `.spec-chain/` directory structure
- You can also just run spec-chain without pre-configuring - Claude will ask for each permission as needed

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests with:
- New documentation prompts
- Improvements to existing prompts
- Additional examples
- Bug fixes

## 📄 License

This project is open source and available under the MIT License.

---

**Note**: This repository serves both as a tool (the spec-chain prompts) and as an example (the Brave New Projects documentation). Feel free to use either or both for your projects!