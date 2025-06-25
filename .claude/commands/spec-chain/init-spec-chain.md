# Initialize Spec Chain Project

This command initializes a new Spec Chain project by creating the required directory structure and template files.

## What This Command Does

1. Creates the required directory structure:
   - `.spec-chain/` - Root directory for all spec-chain files
   - `.spec-chain/specs/` - Where all generated documentation will be stored
   - `.spec-chain/assets/inspiration/visual/` - For visual design references
   - `.spec-chain/assets/inspiration/functional/` - For functional design references

2. Copies `.spec-chain/APP_DETAILS.md.template` to create `.spec-chain/APP_DETAILS.md` with:
   - Detailed comments explaining each section
   - Clear marking of required vs optional fields
   - Guidance on what information to provide
   - Template validation to ensure all required sections are present

## Execution Steps

### 1. Create Directory Structure

```bash
# Create main spec-chain directory and subdirectories
mkdir -p .spec-chain/specs

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

### 2. Create .spec-chain/APP_DETAILS.md from Template

Check if template exists in spec-chain package and copy it, with validation:

```bash
# First, ensure we have a template file in .spec-chain
if [ ! -f ".spec-chain/APP_DETAILS.md.template" ]; then
    # Try to copy from package location
    PACKAGE_TEMPLATE="$(dirname "$(readlink -f "$0")")/../../APP_DETAILS.md.template"
    if [ -f "$PACKAGE_TEMPLATE" ]; then
        cp "$PACKAGE_TEMPLATE" .spec-chain/APP_DETAILS.md.template
        echo "📋 Copied template from package to .spec-chain/"
    else
        # Create a basic template if not found
        echo "⚠️ Creating basic APP_DETAILS.md.template..."
        # [Template content would be created here]
    fi
fi

# Now check if APP_DETAILS.md needs to be created
if [ ! -f ".spec-chain/APP_DETAILS.md" ]; then
    # Remove the warning comment block from template when copying
    sed '/^<!--$/,/^-->$/d' .spec-chain/APP_DETAILS.md.template > .spec-chain/APP_DETAILS.md
    echo "✅ Created .spec-chain/APP_DETAILS.md from template"
    echo "📝 Please fill out the required sections in .spec-chain/APP_DETAILS.md"
else
        echo "⚠️  .spec-chain/APP_DETAILS.md already exists"
        echo "🔍 Validating .spec-chain/APP_DETAILS.md structure against template..."

        # Validate that all required sections exist
        # Extract section headers from template (excluding warning block)
        TEMPLATE_SECTIONS=$(sed '/^<!--$/,/^-->$/d' .spec-chain/APP_DETAILS.md.template | grep -E '^##|^###' | sort)
        CURRENT_SECTIONS=$(grep -E '^##|^###' .spec-chain/APP_DETAILS.md | sort)

        # Find missing sections
        MISSING_SECTIONS=$(comm -23 <(echo "$TEMPLATE_SECTIONS") <(echo "$CURRENT_SECTIONS"))

        if [ -n "$MISSING_SECTIONS" ]; then
            echo "❌ Missing sections found in .spec-chain/APP_DETAILS.md:"
            echo "$MISSING_SECTIONS"
            echo ""
            echo "🔧 Adding missing sections from template..."

            # Backup current file
            cp .spec-chain/APP_DETAILS.md .spec-chain/APP_DETAILS.md.backup

            # Merge missing sections from template
            # This is a simplified approach - in practice, you'd want more sophisticated merging
            echo "" >> .spec-chain/APP_DETAILS.md
            echo "# Missing sections added from template:" >> .spec-chain/APP_DETAILS.md
            sed '/^<!--$/,/^-->$/d' .spec-chain/APP_DETAILS.md.template | grep -A 10 -E '^##|^###' >> .spec-chain/APP_DETAILS.md

            echo "✅ Missing sections added. Please review and fill out .spec-chain/APP_DETAILS.md"
            echo "📄 Backup saved as .spec-chain/APP_DETAILS.md.backup"
        else
            echo "✅ .spec-chain/APP_DETAILS.md structure is complete"
        fi
fi
```

If template doesn't exist, create `.spec-chain/APP_DETAILS.md` with the following content:

```markdown
# App Details

This file contains all the input data needed for generating comprehensive documentation using the Spec Chain tool.

<!-- 
INSTRUCTIONS:
1. Fill out each section below with details about your application
2. Be as specific as possible - the more detail you provide, the better the generated documentation
3. Examples are provided in brackets [...] - replace these with your actual content
4. Feel free to add additional context in any section
5. Once complete, run the spec-chain documentation generator
-->

## Basic Information

### App Name
[Enter your application name here, e.g., "TaskMaster Pro"]

### App Idea
[Provide a comprehensive description of your application concept. Include:
- What problem it solves
- Who it's for
- What makes it unique
- Core value proposition
Example: "A project management tool designed specifically for creative agencies that combines visual task boards with time tracking and client collaboration features. It replaces complex enterprise tools with an intuitive, design-focused interface."]

### MVP Features
[List the minimum features needed for your first release. Be specific about functionality.
Example:
- User authentication with email/password and social login
- Create and manage projects with custom workflows
- Kanban-style task boards with drag-and-drop
- Time tracking with automatic timers
- Basic reporting dashboard
- Email notifications for task updates]

## Target Users

### Primary Users
[Describe your main user groups, their roles, and their needs.
Example:
- **Project Managers**: Need to oversee multiple projects, assign tasks, track budgets
  - Pain points: Current tools are too complex, poor visualization
  - Goals: Streamline workflows, improve team communication
- **Creative Directors**: Need to review work, provide feedback, track progress
  - Pain points: Scattered feedback across multiple tools
  - Goals: Centralized creative reviews, clear approval workflows]

### Secondary Users
[Describe additional user types who will use the system less frequently.
Example:
- **Clients**: View project progress, approve deliverables, communicate with team
- **Freelancers**: Access assigned tasks, track time, submit work]

## Business Context

### Market Context
[Describe the market landscape and opportunity.
Example: "The project management market is worth $5.37B and growing 10% annually. Current solutions are either too complex (Monday, Asana) or too simple (Trello). There's a gap for industry-specific solutions that understand creative workflows."]

### Competition
[List main competitors and their strengths/weaknesses.
Example:
- **Asana**: Great for general project management but lacks creative-specific features
- **Monday.com**: Highly customizable but steep learning curve and expensive
- **Basecamp**: Simple but missing modern features like real-time collaboration]

### Business Model
[Describe how you'll make money.
Example: "SaaS subscription with three tiers:
- Starter: $15/user/month (up to 10 users)
- Professional: $25/user/month (unlimited users, advanced features)
- Enterprise: Custom pricing (SSO, dedicated support, custom integrations)"]

### Constraints
[List any limitations or requirements.
Example:
- Must comply with GDPR and CCPA
- Need to support data export in standard formats
- Must work on mobile devices
- Integration with Adobe Creative Cloud required]

## Technical Requirements

### Platform
[Specify target platforms: Web, iOS, Android, Desktop, etc.
Example: "Web (responsive design for mobile), with native iOS and Android apps planned for Phase 2"]

### Technology Preferences
[List any preferred technologies or constraints.
Example:
- Frontend: React or Vue.js preferred
- Backend: Node.js with TypeScript
- Database: PostgreSQL for relational data, Redis for caching
- Hosting: AWS or Google Cloud
- Must support REST API for integrations]

### Performance Requirements
[Specify performance targets.
Example:
- Page load time: < 3 seconds on 3G connection
- API response time: < 200ms for 95% of requests
- Support 10,000 concurrent users
- 99.9% uptime SLA]

### Scale Requirements
[Describe expected growth.
Example:
- Launch: 100 users, 1,000 projects
- Year 1: 5,000 users, 50,000 projects
- Year 3: 50,000 users, 500,000 projects]

## Design Requirements

### Brand Personality
[Describe the personality and feeling of your brand.
Example: "Professional but approachable, modern, creative, efficient, trustworthy, innovative"]

### Visual Style
[Describe the visual direction.
Example:
- Clean, minimalist interface with plenty of white space
- Bright accent colors for important actions
- Playful illustrations for empty states
- Modern typography with excellent readability
- Dark mode support required]

### Key Emotions
[What should users feel when using your app?
Example: "Confident, in control, creative, productive, delighted"]

### Accessibility Requirements
[Specify accessibility standards.
Example: "WCAG 2.1 Level AA compliance required, with Level AAA for critical user flows"]

## Feature Details

### Core Workflows
[Describe the main user workflows in detail.
Example:
1. **Project Creation Flow**:
   - User clicks "New Project"
   - Selects project template or starts from scratch
   - Enters project details (name, client, deadline)
   - Invites team members
   - Sets up initial task structure

2. **Task Management Flow**:
   - Create tasks with title, description, assignee
   - Set due dates and priorities
   - Add attachments and comments
   - Move tasks between workflow stages
   - Track time spent on tasks]

### Content Types
[List the main types of content/data in your system.
Example:
- **Projects**: Name, description, client, status, timeline, budget
- **Tasks**: Title, description, assignee, due date, priority, attachments
- **Users**: Name, email, role, avatar, preferences
- **Comments**: Text, author, timestamp, attachments
- **Time Entries**: Duration, task, user, date, description]

### Key Features Priority
[Rank features by importance.
Example:
1. **Critical (MVP)**: User auth, project creation, task management, basic reporting
2. **High (Phase 1)**: Time tracking, file sharing, notifications, team chat
3. **Medium (Phase 2)**: Advanced reporting, invoicing, resource planning
4. **Low (Future)**: AI suggestions, workflow automation, white-labeling]

## Integration Requirements

### External Services
[List third-party services you need to integrate with.
Example:
- **Google Workspace**: Calendar sync, Drive integration
- **Slack**: Notifications and chat integration
- **Stripe**: Payment processing
- **SendGrid**: Transactional emails
- **Cloudinary**: Image optimization and delivery]

### API Requirements
[Describe API needs.
Example:
- RESTful API for all core operations
- GraphQL API for complex queries (optional)
- Webhook support for real-time events
- API rate limiting: 1000 requests/hour
- OAuth 2.0 for authentication]

## Success Metrics

### Business Metrics
[How will you measure business success?
Example:
- 80% user activation rate within first week
- 50% of users create at least 3 projects in first month
- < 5% monthly churn rate
- Average of 5 team members per account]

### Technical Metrics
[How will you measure technical success?
Example:
- 99.9% uptime
- < 3 second page load time (P95)
- < 200ms API response time (P95)
- < 1% error rate]

### User Satisfaction
[How will you measure user satisfaction?
Example:
- NPS score > 50
- App store rating > 4.5 stars
- Support ticket volume < 5% of MAU
- Feature adoption rate > 60% within 30 days]

## Go-to-Market Strategy

### Target Market
[Define your initial target market specifically.
Example: "Small to medium creative agencies (10-100 employees) in the US and UK, starting with digital marketing agencies who already use modern tools and are looking for better creative workflow management."]

### Value Proposition
[Concise statement of your unique value.
Example: "The only project management tool built specifically for creative teams - beautiful, intuitive, and powerful enough to handle complex creative workflows."]

### Launch Strategy
[Describe your go-to-market approach.
Example:
- Private beta with 20 hand-picked agencies
- Gather feedback and iterate for 3 months
- Public launch with Product Hunt campaign
- Content marketing focused on creative workflow best practices
- Partner with creative tools (Figma, Adobe) for integrations]

## Additional Context

### Inspiration Directory
[Note about the inspiration directories]
- Visual inspiration materials are in `.spec-chain/assets/inspiration/visual/`
- Functional inspiration materials are in `.spec-chain/assets/inspiration/functional/`

### Development Team
[Describe your team structure.
Example:
- 1 Product Manager
- 2 Frontend Developers
- 2 Backend Developers
- 1 UI/UX Designer
- 1 QA Engineer
- 1 DevOps Engineer (part-time)]

### Timeline Expectations
[Provide rough timeline estimates.
Example:
- MVP: 4 months
- Beta Launch: Month 5
- Public Launch: Month 6
- Mobile Apps: Month 9-12]

### Special Considerations
[Any other important information.
Example:
- Building on top of existing codebase from previous project
- Need to migrate 10,000 users from old system
- Must maintain backward compatibility with v1 API
- Requires integration with proprietary internal tool]

<!-- 
NEXT STEPS:
1. Fill out all sections above with your specific details
2. Add any additional context that might be helpful
3. Place inspiration materials in the appropriate directories
4. Run the spec-chain generator to create comprehensive documentation
-->
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
- Always prefer copying from `APP_DETAILS.md.template` if it exists
- Validate APP_DETAILS.md structure and restore missing sections from template
- Create backup before modifying existing .spec-chain/APP_DETAILS.md
- Report what was created vs what already existed vs what was validated/updated