# Initialize Spec Chain Project

This command initializes a new Spec Chain project by creating the required directory structure and template files.

## What This Command Does

1. Creates the required directory structure:
   - `.spec-chain/` - Root directory for all spec-chain files
   - `.spec-chain/specs/` - Where all generated documentation will be stored
   - `.spec-chain/assets/inspiration/visual/` - For visual design references
   - `.spec-chain/assets/inspiration/functional/` - For functional design references

2. Creates `.spec-chain/APP_DETAILS.md` from the embedded template with:
   - Detailed comments explaining each section
   - Clear marking of required vs optional fields
   - Guidance on what information to provide
   - Template validation to ensure all required sections are present

## Execution Steps

### 1. Create Directory Structure

```bash
# Create main spec-chain directory and subdirectories
mkdir -p .spec-chain/specs 2>&1 || {
    echo "❌ Permission denied creating .spec-chain directory"
    echo ""
    echo "To fix this, add the following to your .claude/settings.local.json:"
    echo '{'
    echo '  "permissions": {'
    echo '    "allow": ['
    echo '      "Read(.spec-chain/**)",'
    echo '      "Write(.spec-chain/**)",'
    echo '      "Edit(.spec-chain/**)",'
    echo '      "MultiEdit(.spec-chain/**)"'
    echo '    ]'
    echo '  }'
    echo '}'
    echo ""
    echo "Then restart Claude Code and run /init-spec-chain again."
    exit 1
}

# Create inspiration directories
mkdir -p .spec-chain/assets/inspiration/visual
mkdir -p .spec-chain/assets/inspiration/functional

# Create placeholder files in inspiration directories
echo "# Visual Inspiration Assets

Place visual design references here:
- Screenshots showing color schemes, typography, visual styles
- UI mockups demonstrating visual aesthetics
- Brand guidelines or style references
- Images showing desired look and feel
- HTML files with CSS styles to extract

Visual elements to capture:
- Color palettes and gradients
- Typography (fonts, sizes, weights)
- Spacing and padding systems
- Border styles and shadows
- Button and form styling
- Animation and transition effects" > .spec-chain/assets/inspiration/visual/README.md

echo "# Functional Inspiration Assets

Place functional design references here:
- Screenshots showing layouts and information architecture
- Wireframes demonstrating component arrangements
- HTML files showing navigation structures
- Examples of forms, workflows, and user journeys
- Dashboard layouts and data displays

Functional elements to capture:
- Page layouts and grid systems
- Navigation patterns and menus
- Form structures and field arrangements
- Multi-step processes and wizards
- Data tables and list views
- Modal dialogs and overlays" > .spec-chain/assets/inspiration/functional/README.md
```

### 2. Create .spec-chain/APP_DETAILS.md

Create `.spec-chain/APP_DETAILS.md` if it doesn't exist, using the embedded template content below:

```bash
# Check if APP_DETAILS.md needs to be created
if [ ! -f ".spec-chain/APP_DETAILS.md" ]; then
    echo "✅ Creating .spec-chain/APP_DETAILS.md from template"
    echo "📝 Please fill out the required sections in .spec-chain/APP_DETAILS.md"
    # Create the file with the template content (see below)
else
    echo "⚠️  .spec-chain/APP_DETAILS.md already exists"
    echo "✅ Keeping existing .spec-chain/APP_DETAILS.md"
fi
```

When creating `.spec-chain/APP_DETAILS.md`, use the following template content:

```markdown
# APP_DETAILS.md

This file contains the core information needed to generate comprehensive documentation for your application.
Fields marked as (REQUIRED) must be filled out. Fields marked as (OPTIONAL) can be left blank and will be auto-researched or use sensible defaults.

## Basic Information (REQUIRED)

**App Name:**
[Your app name here]

**App Idea:**
[Brief description of what your app does and what problem it solves]

**MVP Features:**
[List the core features for your minimum viable product]
- Feature 1: [description]
- Feature 2: [description]
- Feature 3: [description]

## Target Users (REQUIRED)

### Primary Users
[Who are the main users of your app?]
- User type 1: [description]
- User type 2: [description]

### Secondary Users (OPTIONAL)
[Any additional user types - leave blank if none]

## Business Context (OPTIONAL - will be auto-researched if not provided)

### Market Context
(Optional - will research competitors and market landscape if left blank)

### Competition
(Optional - will find similar solutions automatically if left blank)

### Business Model
(Optional - will suggest based on app type if left blank)

### Constraints
(Optional - list any specific constraints or requirements)

## Technical Requirements (OPTIONAL - will use modern defaults if not provided)

### Platform
(Optional - will suggest one or more of the following: Web, Mobile, Desktop, Terminal/CLI based on app type and features if left blank)

### Technology Preferences
(Optional - will recommend modern stack if left blank)

### Performance Requirements
(Optional - will use industry standards if left blank)

### Scale Requirements
(Optional - will estimate based on user base if left blank)

## Design Requirements (OPTIONAL - will use best practices if not provided)

### Brand Personality
(Optional - will generate based on app type and users if left blank)

### Visual Style
(Optional - will use modern, clean design if left blank)

### Key Emotions
(Optional - will infer from app purpose if left blank)

### Accessibility Requirements
(Optional - defaults to WCAG 2.1 AA compliance if left blank)

## Feature Details (OPTIONAL - will be inferred from MVP if not provided)

### Core Workflows
(Optional - will be derived from MVP features if left blank)

### Content Types
(Optional - will be inferred from app description if left blank)

### Feature Priorities
(Optional - will prioritize based on MVP list if left blank)

## Integration Requirements (OPTIONAL)

### External Services
[List any third-party services or APIs you need to integrate]

### API Requirements
(Optional - will generate standard REST API if left blank)

## Success Metrics (OPTIONAL - will generate standard KPIs if not provided)

### Business Metrics
(Optional - will suggest relevant metrics based on app type)

### Technical Metrics
(Optional - will use industry standard metrics)

### User Satisfaction
(Optional - will include standard UX metrics)

## Go-to-Market Strategy (OPTIONAL - will be researched if not provided)

### Target Market
(Optional - will be inferred from users and app type)

### Value Proposition
(Optional - will be generated from app idea and benefits)

### Launch Strategy
(Optional - will suggest phased approach)

## Development Team (OPTIONAL - will use standard team if not provided)

### Team Structure
(Optional - will suggest appropriate team size and roles)

### Timeline Estimates
(Optional - will estimate based on feature complexity)

## Additional Context (OPTIONAL)

### Migration Strategy
[If replacing existing system, describe migration needs]

### Training Requirements
(Optional - will suggest based on user types and complexity)

### Security Considerations
(Optional - will apply standard security best practices)

### Future Roadmap
[Any long-term vision or future features]

---

## Instructions for Use

1. **Fill out all REQUIRED sections** - These are essential for generating documentation
2. **OPTIONAL sections can be left blank** - The system will:
   - Research market context and competitors
   - Suggest appropriate technology stacks
   - Generate design guidelines
   - Create standard metrics and KPIs
   - Propose go-to-market strategies

3. **The more detail you provide, the more tailored the output** - While optional fields will be auto-filled, providing your specific requirements will result in more customized documentation

4. **Save this file as APP_DETAILS.md** in your project root directory
```

### 3. Create Success Message

After creating all files and directories, display:

```
✅ Spec Chain project initialized successfully!

Created directories:
- .spec-chain/ (root directory for all spec-chain files)
- .spec-chain/specs/ (for generated documentation)
- .spec-chain/assets/inspiration/visual/ (for visual design references)
- .spec-chain/assets/inspiration/functional/ (for functional design references)

Created files:
- .spec-chain/APP_DETAILS.md (application details template)
- .spec-chain/assets/inspiration/visual/README.md (visual inspiration guide)
- .spec-chain/assets/inspiration/functional/README.md (functional inspiration guide)

Next steps:
1. Fill out .spec-chain/APP_DETAILS.md with your application details
   - The interactive information gathering will guide you through completing any missing fields
   - Fill out as many sections as possible for the most detailed generation
2. Add inspiration materials to the appropriate directories:
   - Visual designs → .spec-chain/assets/inspiration/visual/
   - Functional examples → .spec-chain/assets/inspiration/functional/
3. Run the spec-chain generator to create your comprehensive documentation

To generate documentation after setup:
- Use the run-spec-chain.md command (includes interactive information gathering and comprehensive generation)
- Use validate-spec-chain.md to check your setup and see readiness for generation
```

## Error Handling

Check if files/directories already exist before creating:
- If `.spec-chain/APP_DETAILS.md` exists, validate structure against template and add missing sections
- If directories exist, skip creation but note they already existed
- Always use the embedded template content defined in this command
- Validate APP_DETAILS.md structure and restore missing sections from template
- Create backup before modifying existing .spec-chain/APP_DETAILS.md
- Report what was created vs what already existed vs what was validated/updated