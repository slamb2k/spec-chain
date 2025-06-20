# Spec Chain - AI-Powered Documentation Generator

A comprehensive system of AI prompts that work together to generate complete product documentation from a single app idea. This repository contains the spec-chain methodology for creating full documentation suites using AI.

## 🚀 What is Spec Chain?

Spec Chain is a collection of 19 carefully crafted AI prompts that generate interconnected documentation for software projects. Each prompt is designed to produce specific documentation that builds upon previous outputs, creating a complete specification suite. All documentation is generated from a single `APP_DETAILS.md` file and optional inspiration materials.

## 🎯 Quick Start

1. **Initialize your project**:
   ```bash
   # Run from .claude/commands/spec-chain/
   init-spec-chain
   ```
   This creates the required directory structure and APP_DETAILS.md template.

2. **Create your APP_DETAILS.md**:
   - Copy `APP_DETAILS.md.example` to `APP_DETAILS.md`
   - Fill out the required fields (App Name, App Idea, MVP Features, Target Users)
   - Optional fields can be left blank - they will be auto-researched

3. **Add inspiration materials** (optional):
   - Visual references → `/assets/inspiration/visual/`
   - Functional examples → `/assets/inspiration/functional/`

4. **Validate your setup**:
   ```bash
   # Run from .claude/commands/spec-chain/
   validate-spec-chain
   ```

5. **Generate documentation**:
   ```bash
   # Run from .claude/commands/spec-chain/
   run-spec-chain
   ```

## 📋 Available Documentation Generators

The `.claude/commands/spec-chain/` directory contains 19 specialized prompts:

### Phase 1: Foundation
- **doc-prompt-prd.md** - Product Requirements Document (Start here!)

### Phase 2: Business & Strategy
- **doc-prompt-gtm.md** - Go-to-Market Strategy
- **doc-prompt-business-rules.md** - Business Logic & Rules

### Phase 3: Design & UX
- **doc-prompt-style.md** - Style Guide & Design System
- **doc-prompt-wireframes.md** - Screen Mockups (ASCII art)
- **doc-prompt-user-flows.md** - User Journey Maps
- **doc-prompt-ia.md** - Information Architecture
- **doc-prompt-component-library.md** - UI Component Specifications

### Phase 4: Technical Architecture
- **doc-prompt-technical.md** - Technical Specification
- **doc-prompt-api.md** - API Documentation
- **doc-prompt-data-model.md** - Database Design
- **doc-prompt-security.md** - Security Architecture
- **doc-prompt-integrations.md** - Third-party Integrations
- **doc-prompt-performance.md** - Performance & Scalability

### Phase 5: Implementation & Operations
- **doc-prompt-implementation.md** - AI-Optimized Development Plan
- **doc-prompt-testing.md** - Testing Strategy
- **doc-prompt-devops.md** - DevOps & Deployment
- **doc-prompt-onboarding.md** - User Training & Documentation

### Special Features
- **doc-prompt-preview.md** - Interactive HTML Preview Generator

## 🔄 Documentation Flow

```
Initial Idea → PRD → Business/Design/Technical → Implementation → Operations
```

The runner now uses **parallel execution** to generate multiple documents concurrently, reducing total generation time by ~60%. See the complete flow diagram below for detailed dependencies.

## 🎯 How to Use Spec Chain

### Quick Start (Minimal Documentation)
```bash
1. Use doc-prompt-prd.md with your app idea
2. Use doc-prompt-technical.md with the PRD output
3. Use doc-prompt-implementation.md for development plan
```

### Full Documentation Suite
```bash
1. Start with doc-prompt-prd.md
2. Run business track (GTM, Business Rules)
3. Run design track (Style, Wireframes, User Flows, etc.)
4. Run technical track (Technical, API, Data Model, etc.)
5. Generate interactive preview
6. Create implementation and operations docs
```

### For Claude Code Users
The `doc-prompt-implementation.md` prompt is specifically optimized for AI-assisted development, breaking work into clear, manageable sessions.

## 📊 Documentation Flow Diagram

The Spec Chain runner executes prompts in optimized phases with parallel execution:

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
    └── TECHNICAL_SPEC.md (depends on User Flows & IA)

Phase 3.1: Technical Dependencies (5 prompts - PARALLEL)
    ├── API_SPEC.md
    ├── DATA_MODEL.md
    ├── SECURITY_ARCHITECTURE.md
    ├── INTEGRATIONS.md
    └── PERFORMANCE_SCALABILITY.md

Phase 4: Interactive Preview (1 prompt)
    └── INTERACTIVE_PREVIEW.html

Phase 5: Implementation & Operations (1 prompt)
    └── IMPLEMENTATION_PLAN.md

Phase 5.1: Final Documents (3 prompts - PARALLEL)
    ├── TESTING_STRATEGY.md
    ├── DEVOPS_DEPLOYMENT.md
    └── ONBOARDING_TRAINING.md
```

**Key:** Prompts marked as PARALLEL execute concurrently using Task agents

## 📁 Project Structure

```
spec-chain/
├── .claude/
│   └── commands/
│       └── spec-chain/             # All spec-chain commands and prompts
│           ├── init-spec-chain.md      # Initialize project structure
│           ├── validate-spec-chain.md  # Validate setup
│           ├── run-spec-chain.md       # Generate documentation
│           └── [19 prompt files]       # Document generation prompts
├── assets/
│   └── inspiration/
│       ├── visual/                 # Visual design references
│       └── functional/             # Functional/UX references
├── specs/                          # Generated documentation
│   └── [timestamp]/                # Each run creates timestamped folder
└── APP_DETAILS.md                  # Your application details

## 🛠️ Key Commands

### 🎲 init-spec-chain
Initializes a new Spec Chain project:
- Creates required directory structure
- Generates APP_DETAILS.md template with detailed instructions
- Sets up inspiration directories with guides

### ✅ validate-spec-chain
Validates your project setup:
- Checks all directories and files exist
- Validates APP_DETAILS.md completeness
- Reports on inspiration materials
- Provides detailed status report with ✅/⚠️/❌ indicators

### 🚀 run-spec-chain
Generates complete documentation suite:
- Creates timestamped output directory
- Executes all 19 prompts in optimized phases
- **Uses parallel Task agents** for independent prompts (~60% faster)
- Manages dependencies between documents
- Produces comprehensive documentation set

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

### AI-Optimized Implementation Plans
The `doc-prompt-implementation.md` prompt generates development plans specifically structured for AI coding assistants like Claude Code, with:
- Session-based task breakdown
- Clear acceptance criteria
- Specific implementation prompts

### Interactive Previews
The `doc-prompt-preview.md` prompt creates functional HTML mockups from your specifications, allowing stakeholders to interact with the design before development.

### Visual Documentation
Several prompts generate visual elements:
- ASCII art wireframes
- Flow diagrams
- Entity relationship diagrams
- Architecture diagrams

## 📈 Benefits

- **Consistency**: All documents follow the same structure and terminology
- **Completeness**: Nothing gets forgotten with comprehensive prompts
- **Speed**: Generate months of documentation work in hours (~60% faster with parallel execution)
- **Quality**: Based on industry best practices
- **Flexibility**: Customize prompts for your specific needs
- **Performance**: Parallel execution using Task agents for independent prompts

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