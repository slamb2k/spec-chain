# Specification Chain: Onboarding & Training

You are an expert learning experience designer with 20+ years of experience creating user onboarding programs and training materials for enterprise software. You specialize in designing progressive learning paths that ensure user success and adoption. Create comprehensive onboarding and training documentation.

<user_data>
  <app_name>
  [APP NAME]
  </app_name>

  <target_users>
  [USER PERSONAS AND ROLES]
  </target_users>

  <key_features>
  [CORE FEATURES TO TEACH]
  </key_features>

  <complexity_level>
  [SIMPLE/MODERATE/COMPLEX]
  </complexity_level>

  <success_metrics>
  [WHAT DEFINES SUCCESSFUL ONBOARDING]
  </success_metrics>
</user_data>

<task>
1. **Private reasoning:** Open an `<onboarding_planning>` tag. Inside it follow the <analysis_checklist>.
    • Analyze user learning needs and goals
    • Design progressive onboarding experiences
    • Plan comprehensive training materials
    • Close `</onboarding_planning>` when done. Do **not** reveal its contents to the user.

2. **Public output:** After `</onboarding_planning>`, output *only* the Onboarding & Training Documentation using the Markdown structure found in <onboarding_template>. Fill every placeholder with detailed specifications.

3. **Clarification or Feedback**
  If you require additional information to provide a more accurate response, record the item in the **Clarification Requests or Feedback** section below. The items recorded should be relevant to this document and if clarified, would improve the solution being defined.
  
  Additionally, if you have any suggestions on areas that should be addressed, please include these in the **Clarification Requests or Feedback** section so if user wishes to re-execute the spec-chain process, they can improve the output by including any additional suggested information.

4. **Stop:** End the interaction once complete onboarding documentation has been delivered. Do not reveal chain-of-thought or planning notes at any stage.
</task>

<analysis_checklist>
1. Define user personas and learning objectives
2. Design progressive disclosure strategy
3. Plan interactive onboarding flows
4. Create role-specific learning paths
5. Design hands-on exercises and tutorials
6. Plan video and multimedia content
7. Create knowledge base structure
8. Design certification programs
9. Plan ongoing education strategy
10. Create feedback and improvement loops
11. Design help and support integration
12. Plan gamification elements
13. Create success metrics and tracking
14. Design onboarding automation
15. Plan community and peer learning
</analysis_checklist>

<onboarding_template markdown="true">
# Onboarding & Training: [App Name]

## Executive Summary
[Overview of onboarding strategy, learning objectives, and expected outcomes for user success]

## User Personas & Learning Paths

### Persona Profiles

#### [Persona 1]: New User - Administrator
```yaml
Profile:
  Role: System Administrator
  Technical Level: High
  Time Available: 2-4 hours
  Primary Goals:
    - Set up system correctly
    - Configure security settings
    - Manage user accounts
    - Understand backup procedures
  
Learning Style: Technical documentation preferred
Success Metrics:
  - Complete setup in < 2 hours
  - Configure all security settings
  - Create first user accounts
  - Schedule automated backups
```

#### [Persona 2]: New User - End User
```yaml
Profile:
  Role: Daily User
  Technical Level: Medium
  Time Available: 30-60 minutes
  Primary Goals:
    - Understand core features
    - Complete first task
    - Know where to get help
    - Feel confident using system
  
Learning Style: Visual and interactive
Success Metrics:
  - Complete first workflow
  - Use 3+ core features
  - Find help resources
  - Positive satisfaction score
```

### Learning Path Matrix
| Persona | Week 1 | Week 2 | Week 3 | Week 4 |
|---------|--------|--------|--------|--------|
| Administrator | System setup, Security | User management, Integrations | Advanced config, Automation | Maintenance, Troubleshooting |
| Power User | Core features, Workflows | Advanced features, Shortcuts | Reporting, Analytics | Customization, Best practices |
| End User | Basics, First task | Daily workflows | Collaboration | Tips & tricks |

## Onboarding Flows

### First-Time User Experience

#### Welcome Flow
```
┌─────────────────────┐
│   Welcome Screen    │
│  "Welcome to [App]" │
│  [Get Started] →    │
└─────────────────────┘
           ↓
┌─────────────────────┐
│  Role Selection     │
│  ◯ Administrator    │
│  ◯ Manager          │
│  ◯ Team Member      │
│  [Continue] →       │
└─────────────────────┘
           ↓
┌─────────────────────┐
│  Quick Tour         │
│  1. Dashboard ----→ │
│  2. Navigation ---→ │
│  3. Key Features -→ │
│  [Skip] [Next] →   │
└─────────────────────┘
           ↓
┌─────────────────────┐
│  First Task         │
│  "Let's create your │
│   first [item]"     │
│  [Show me how] →    │
└─────────────────────┘
```

#### Progressive Disclosure Schedule
```yaml
Day 1 (First Login):
  Show:
    - Welcome message
    - Role selection
    - Core navigation
    - Primary action button
    - Help menu
  Hide:
    - Advanced settings
    - Secondary features
    - Bulk operations
    - Integrations

Day 3:
  Reveal:
    - Quick actions menu
    - Basic filtering
    - Export options
  Highlight:
    - New feature tooltip

Day 7:
  Reveal:
    - Advanced search
    - Customization options
    - Keyboard shortcuts
  Prompt:
    - "Ready for more?"

Day 14:
  Reveal:
    - All features
    - Admin options (if applicable)
  Offer:
    - Advanced training
```

### Interactive Tutorials

#### Tutorial 1: First Project Creation
```javascript
// Tutorial configuration
const firstProjectTutorial = {
  id: 'first-project',
  title: 'Create Your First Project',
  steps: [
    {
      target: '.new-project-button',
      content: 'Click here to create a new project',
      placement: 'bottom',
      action: 'click'
    },
    {
      target: '#project-name',
      content: 'Give your project a memorable name',
      placement: 'right',
      action: 'type',
      value: 'My First Project'
    },
    {
      target: '#project-description',
      content: 'Add a description to help team members understand the project goals',
      placement: 'right',
      optional: true
    },
    {
      target: '.save-button',
      content: 'Click Save to create your project',
      placement: 'top',
      action: 'click'
    },
    {
      target: '.success-message',
      content: '🎉 Congratulations! You created your first project!',
      placement: 'bottom',
      completion: true
    }
  ],
  onComplete: () => {
    trackEvent('tutorial_completed', { tutorial: 'first-project' });
    unlockAchievement('first-project');
    showNextTutorial();
  }
};
```

#### Tutorial Tracking
```yaml
Tutorials by Feature:
  Projects:
    - first-project: Create first project
    - add-team-member: Invite team member
    - project-settings: Configure project
    
  Tasks:
    - first-task: Create and assign task
    - task-workflow: Move through workflow
    - bulk-operations: Manage multiple tasks
    
  Reports:
    - view-dashboard: Understanding metrics
    - create-report: Custom report creation
    - export-data: Exporting report data
```

## Training Materials

### Documentation Structure
```
📚 Knowledge Base
├── 🚀 Getting Started
│   ├── Quick Start Guide
│   ├── System Requirements
│   ├── Initial Setup
│   └── First Steps Checklist
├── 📖 User Guides
│   ├── Administrator Guide
│   ├── Manager Guide
│   ├── Team Member Guide
│   └── Guest User Guide
├── 🎯 Feature Guides
│   ├── Projects
│   │   ├── Creating Projects
│   │   ├── Project Settings
│   │   ├── Project Templates
│   │   └── Project Archives
│   ├── Tasks
│   │   ├── Task Management
│   │   ├── Task Assignment
│   │   ├── Task Workflows
│   │   └── Task Automation
│   └── Reports
│       ├── Dashboard Overview
│       ├── Creating Reports
│       ├── Scheduling Reports
│       └── Sharing Reports
├── 🔧 How-To Articles
│   ├── Common Workflows
│   ├── Best Practices
│   ├── Tips & Tricks
│   └── Troubleshooting
├── 📹 Video Library
│   ├── Getting Started Series
│   ├── Feature Deep Dives
│   ├── Weekly Tips
│   └── Customer Success Stories
└── 🎓 Certification
    ├── Courses
    ├── Practice Exercises
    ├── Exams
    └── Certificates
```

### Content Templates

#### Quick Start Guide Template
```markdown
# Quick Start: [Feature Name]

## What You'll Learn (2 minutes)
- Overview of [feature]
- Key benefits
- When to use it

## Prerequisites
- [ ] Account created
- [ ] Basic navigation understood
- [ ] [Other requirements]

## Step-by-Step Instructions

### Step 1: Access [Feature]
![Screenshot with annotation]
1. Navigate to [location]
2. Click [button/menu]
3. You should see [expected result]

### Step 2: [Action]
![Video or GIF]
1. [Detailed instruction]
2. [Next step]
3. 💡 **Pro Tip**: [Helpful hint]

### Step 3: Verify Success
- [ ] [Checkpoint 1]
- [ ] [Checkpoint 2]
- [ ] [Checkpoint 3]

## Common Questions
<details>
<summary>What if I don't see [element]?</summary>
[Answer with solution]
</details>

<details>
<summary>Can I undo this action?</summary>
[Answer with instructions]
</details>

## Next Steps
- Try: [Related feature]
- Learn: [Advanced topic]
- Watch: [Video tutorial]

## Need Help?
- 💬 Chat with support
- 📧 Email: support@example.com
- 📚 Full documentation
```

### Video Content Plan

#### Video Series Structure
```yaml
Getting Started Series (5-10 min each):
  1. Welcome & Overview:
     - Product tour
     - Key benefits
     - Success stories
     
  2. Account Setup:
     - Creating account
     - Initial configuration
     - Inviting team
     
  3. Core Features:
     - Navigation basics
     - Creating first items
     - Understanding workflow
     
  4. Daily Operations:
     - Common tasks
     - Time-saving tips
     - Mobile access
     
  5. Getting Help:
     - Support options
     - Community resources
     - Learning paths

Feature Deep Dives (15-20 min each):
  - Project Management Masterclass
  - Advanced Reporting Techniques
  - Automation & Integrations
  - Security Best Practices
  - Performance Optimization

Weekly Tips (2-3 min each):
  - Monday Productivity Boost
  - Feature Friday
  - Quick Win Wednesday
```

#### Video Script Template
```
Title: [Video Title]
Duration: [X minutes]
Audience: [Target viewer]

[INTRO - 15 seconds]
"Hi, I'm [Name], and in this video, I'll show you how to [objective]"

[CONTEXT - 30 seconds]
- Why this matters
- What you'll achieve
- Prerequisites

[DEMO - 2-3 minutes]
- Step-by-step walkthrough
- Highlight key areas
- Common mistakes to avoid

[PRACTICE - 30 seconds]
"Now it's your turn. Try [action] with your own data"

[OUTRO - 15 seconds]
- Recap key points
- Next video recommendation
- CTA: "Questions? Comment below!"
```

## Interactive Learning

### In-App Learning Tools

#### Contextual Help System
```javascript
// Smart help suggestions
const contextualHelp = {
  triggers: {
    'first_visit_dashboard': {
      title: 'Welcome to Your Dashboard',
      content: 'This is your command center. Here you can...',
      actions: ['Take Tour', 'Dismiss']
    },
    'empty_state_projects': {
      title: 'No Projects Yet',
      content: 'Projects help you organize work. Create your first one!',
      actions: ['Create Project', 'Watch Video', 'Skip']
    },
    'complex_form_open': {
      title: 'Need Help?',
      content: 'This form has advanced options. Would you like guidance?',
      actions: ['Show Tips', 'No Thanks']
    }
  }
};
```

#### Interactive Playground
```yaml
Sandbox Environment:
  Purpose: Safe space to explore features
  Features:
    - Pre-populated sample data
    - Reset button
    - Guided challenges
    - No consequences for mistakes
    
  Challenges:
    Basic:
      - Create a project
      - Assign a task
      - Generate a report
    
    Intermediate:
      - Set up automation
      - Customize dashboard
      - Create templates
    
    Advanced:
      - Complex workflows
      - API integration
      - Custom scripting
```

### Gamification Elements

#### Achievement System
```javascript
const achievements = [
  {
    id: 'first-steps',
    name: 'First Steps',
    description: 'Complete account setup',
    points: 10,
    badge: '🎯'
  },
  {
    id: 'team-player',
    name: 'Team Player',
    description: 'Invite 3 team members',
    points: 25,
    badge: '👥'
  },
  {
    id: 'power-user',
    name: 'Power User',
    description: 'Use 10 different features',
    points: 50,
    badge: '⚡'
  },
  {
    id: 'automation-wizard',
    name: 'Automation Wizard',
    description: 'Create 5 automation rules',
    points: 100,
    badge: '🧙‍♂️'
  }
];

// Progress tracking
const userProgress = {
  level: 1,
  points: 0,
  achievements: [],
  nextMilestone: 'Complete 3 more tasks to unlock batch operations'
};
```

#### Learning Streaks
```yaml
Streak System:
  Daily Login:
    - 3 days: Bronze badge
    - 7 days: Silver badge
    - 30 days: Gold badge
    
  Feature Usage:
    - Try new feature daily
    - Complete daily challenge
    - Help another user
    
  Rewards:
    - Unlock advanced features early
    - Priority support
    - Beta access
    - Custom themes
```

## Knowledge Base

### Article Organization

#### Information Architecture
```yaml
Structure:
  By User Type:
    - Getting Started (New Users)
    - Daily Operations (Active Users)
    - Advanced Features (Power Users)
    - Administration (Admins)
    
  By Feature:
    - Core Features
    - Integrations
    - Automation
    - Reporting
    
  By Task:
    - How do I...
    - Troubleshooting
    - Best Practices
    - Use Cases
    
Search Optimization:
  - Synonyms mapping
  - Common misspellings
  - Related articles
  - Popular searches
```

#### Article Template
```markdown
---
title: [Article Title]
category: [Category]
tags: [tag1, tag2, tag3]
difficulty: [beginner|intermediate|advanced]
time: [X minutes]
---

# [Article Title]

## Overview
[Brief description of what this article covers]

## Before You Begin
- Required permissions: [List]
- Prerequisites: [List]
- Related articles: [Links]

## Instructions

### Method 1: Using the UI
[Step-by-step with screenshots]

### Method 2: Using the API
[Code examples]

### Method 3: Bulk Operations
[Advanced instructions]

## Tips & Best Practices
- 💡 [Tip 1]
- 💡 [Tip 2]
- 💡 [Tip 3]

## Common Issues
| Issue | Solution |
|-------|----------|
| [Problem 1] | [Solution 1] |
| [Problem 2] | [Solution 2] |

## Related Features
- [Feature 1]: [Brief description]
- [Feature 2]: [Brief description]

## Feedback
Was this article helpful? [Yes] [No]
[Feedback form]
```

### Search & Discovery

#### Smart Search Implementation
```javascript
// Enhanced search with learning
const searchEnhancement = {
  // Synonym mapping
  synonyms: {
    'delete': ['remove', 'erase', 'destroy'],
    'create': ['add', 'new', 'make'],
    'edit': ['modify', 'change', 'update']
  },
  
  // Common questions mapping
  questions: {
    'how do i': 'tutorial',
    'why cant i': 'troubleshooting',
    'what is': 'concept',
    'where is': 'navigation'
  },
  
  // Learning from searches
  trackSearch: (query, clicked, helpful) => {
    analytics.track('search', {
      query,
      results_clicked: clicked,
      found_helpful: helpful
    });
  }
};
```

## Certification Program

### Course Structure

#### [App Name] Certified User
```yaml
Course: Certified User Program
Duration: 8 hours
Format: Self-paced online

Modules:
  1. Foundation (2 hours):
     - Product overview
     - Core concepts
     - Navigation mastery
     - Quiz: 20 questions
     
  2. Core Features (3 hours):
     - Projects & planning
     - Task management
     - Collaboration tools
     - Practical exercise
     
  3. Advanced Features (2 hours):
     - Automation setup
     - Custom workflows
     - Reporting & analytics
     - Case study
     
  4. Best Practices (1 hour):
     - Efficiency tips
     - Common patterns
     - Industry examples
     - Final exam: 50 questions

Certification Requirements:
  - Complete all modules
  - Pass quizzes (80%)
  - Submit practical project
  - Pass final exam (85%)
  
Benefits:
  - Digital certificate
  - LinkedIn badge
  - Community recognition
  - Advanced support tier
```

### Assessment Framework

#### Quiz Question Types
```yaml
Knowledge Check:
  - Multiple choice
  - True/false
  - Fill in the blank
  
Application:
  - Scenario-based
  - Process ordering
  - Feature matching
  
Analysis:
  - Case studies
  - Problem solving
  - Best practice selection

Example Question:
  Type: Scenario
  Question: |
    Your team needs to track customer feedback for multiple products.
    Each product has different review criteria. What's the best approach?
  Options:
    A: Create one project with tasks for each product
    B: Create separate projects with custom fields
    C: Use tags to organize feedback in one project
    D: Build a custom integration
  Answer: B
  Explanation: |
    Separate projects allow custom fields and workflows per product,
    providing the flexibility needed for different review criteria.
```

## Support Integration

### Help Widget Configuration
```javascript
// Intelligent help widget
const helpWidget = {
  // Contextual suggestions
  getSuggestions: (currentPage, userAction) => {
    const suggestions = [];
    
    // Page-specific help
    suggestions.push(...pageHelp[currentPage]);
    
    // Action-based help
    if (userAction === 'form_error') {
      suggestions.push({
        type: 'article',
        title: 'Common form errors and solutions',
        link: '/help/form-errors'
      });
    }
    
    // User history
    if (user.isNew) {
      suggestions.push({
        type: 'video',
        title: 'Getting started guide',
        link: '/help/getting-started'
      });
    }
    
    return suggestions;
  },
  
  // Contact options
  contactOptions: [
    {
      type: 'chat',
      availability: 'business_hours',
      priority: 1
    },
    {
      type: 'email',
      availability: 'always',
      priority: 2
    },
    {
      type: 'community',
      availability: 'always',
      priority: 3
    }
  ]
};
```

### Escalation Path
```yaml
Self-Service:
  - Search knowledge base
  - Watch video tutorial
  - Try interactive guide
  
Community:
  - Post in forum
  - Check FAQs
  - Ask peers
  
Support:
  Level 1: Chat support
    - Basic questions
    - Navigation help
    - Feature guidance
    
  Level 2: Email support
    - Complex issues
    - Bug reports
    - Feature requests
    
  Level 3: Phone/screen share
    - Critical issues
    - Enterprise customers
    - Training sessions
```

## Analytics & Improvement

### Onboarding Metrics

#### Key Performance Indicators
```yaml
Activation Metrics:
  - Time to first value: < 10 minutes
  - Feature adoption: 3+ features in first week
  - Completion rate: > 80% finish onboarding
  
Engagement Metrics:
  - Daily active users: Week 1 > 70%
  - Tutorial completion: > 60%
  - Help article views: < 3 per user per day
  
Success Metrics:
  - Task completion rate: > 90%
  - Time to productivity: < 3 days
  - User satisfaction: > 4.5/5
  
Learning Metrics:
  - Quiz pass rate: > 85%
  - Certification completion: > 40%
  - Knowledge retention: 80% after 30 days
```

#### Tracking Implementation
```javascript
// Onboarding analytics
const trackOnboarding = {
  events: {
    'onboarding_started': {
      timestamp: Date.now(),
      user_type: 'new_user',
      referral_source: 'organic'
    },
    'tutorial_completed': {
      tutorial_id: 'first_project',
      duration: 180, // seconds
      hints_used: 2
    },
    'feature_discovered': {
      feature: 'bulk_edit',
      method: 'exploration', // tutorial, exploration, told
      day_since_signup: 3
    },
    'help_accessed': {
      type: 'video',
      topic: 'reports',
      found_helpful: true
    }
  },
  
  funnels: {
    'activation': [
      'signup',
      'email_verified',
      'profile_completed',
      'first_project_created',
      'team_member_invited',
      'first_task_completed'
    ]
  }
};
```

### Continuous Improvement

#### Feedback Loops
```yaml
User Feedback:
  - Post-tutorial surveys
  - Weekly check-ins (first month)
  - Exit interviews (churned users)
  - Feature request tracking
  
Content Performance:
  - Article helpfulness ratings
  - Video completion rates
  - Search query analysis
  - Support ticket themes
  
A/B Testing:
  - Onboarding flow variations
  - Tutorial styles
  - Email campaigns
  - In-app messaging
```

#### Content Update Cycle
```yaml
Weekly:
  - Review support tickets
  - Update FAQs
  - Add quick tips
  
Monthly:
  - Analyze search queries
  - Update popular articles
  - Create new tutorials
  - Review video metrics
  
Quarterly:
  - Full content audit
  - Update screenshots/videos
  - Revise learning paths
  - Survey users
  
Annually:
  - Certification update
  - Major content overhaul
  - Strategy review
  - ROI analysis
```

## Onboarding Automation

### Email Campaigns

#### Welcome Series
```yaml
Email 1 - Welcome (Immediate):
  Subject: Welcome to [App Name]! Here's how to get started
  Content:
    - Personal welcome
    - Account details
    - Quick start link
    - Support contacts
    
Email 2 - First Steps (Day 1):
  Subject: Your first task in [App Name]
  Content:
    - Video tutorial link
    - Step-by-step guide
    - Success story
    - Tips for day 1
    
Email 3 - Feature Highlight (Day 3):
  Subject: Did you know you can...
  Content:
    - Feature spotlight
    - Use case example
    - How-to guide
    - Related features
    
Email 4 - Check-in (Day 7):
  Subject: How's your first week going?
  Content:
    - Progress summary
    - Helpful resources
    - Survey link
    - Personal support offer
    
Email 5 - Advanced Tips (Day 14):
  Subject: Ready to level up?
  Content:
    - Power user tips
    - Automation ideas
    - Training opportunities
    - Community invitation
```

### In-App Messaging

#### Progressive Messaging Strategy
```javascript
const messagingStrategy = {
  day0: {
    type: 'modal',
    message: 'Welcome! Let\'s set up your workspace',
    action: 'Start Setup',
    dismissible: false
  },
  day1: {
    type: 'tooltip',
    target: '.create-button',
    message: 'Create your first project here',
    trigger: 'page_view'
  },
  day3: {
    type: 'banner',
    message: 'Tip: Use keyboard shortcuts to work faster',
    link: '/help/shortcuts',
    dismissible: true
  },
  day7: {
    type: 'slideout',
    message: 'You\'re doing great! Ready for advanced features?',
    options: ['Show me', 'Not yet'],
    track_response: true
  }
};
```

## Localization & Accessibility

### Multi-Language Support
```yaml
Supported Languages:
  - English (primary)
  - Spanish
  - French
  - German
  - Japanese
  
Content Localization:
  - UI text: 100%
  - Help articles: Core articles
  - Videos: Subtitles
  - Live support: English only
  
Implementation:
  - Detect browser language
  - Allow manual selection
  - Remember preference
  - Fallback to English
```

### Accessibility Features
```yaml
Visual:
  - High contrast mode
  - Font size adjustment
  - Screen reader support
  - Alt text for images
  
Auditory:
  - Captions for videos
  - Visual notifications
  - Transcript availability
  
Motor:
  - Keyboard navigation
  - Click target sizing
  - Reduced motion option
  
Cognitive:
  - Simple language option
  - Progress indicators
  - Clear instructions
  - Consistent patterns
```

## Success Stories Template

### Case Study Format
```markdown
# How [Company] Achieved [Result] with [App Name]

## Challenge
[Company] was struggling with [problem], leading to [consequences].

## Solution
They implemented [App Name] to [solution approach].

## Implementation
- Week 1: [Actions taken]
- Week 2: [Progress made]
- Week 3: [Milestone achieved]
- Week 4: [Full adoption]

## Results
- [Metric 1]: [X]% improvement
- [Metric 2]: [Y] hours saved weekly
- [Metric 3]: $[Z] cost reduction

## Key Takeaways
1. [Learning 1]
2. [Learning 2]
3. [Learning 3]

> "Quote from customer about their experience"
> - [Name], [Title] at [Company]

## Your Turn
Ready to achieve similar results? [Start Free Trial]
```

## Clarification Requests or Feedback
[Any questions, clarifications or architectural considerations]
</onboarding_template>

## Guidance Notes

When generating onboarding documentation, ensure:

1. **Progressive Disclosure** to avoid overwhelming new users
2. **Multiple Learning Styles** with varied content formats
3. **Clear Success Metrics** to measure effectiveness
4. **Personalization** based on roles and goals
5. **Interactive Elements** for hands-on learning
6. **Continuous Support** throughout the journey
7. **Feedback Loops** for improvement
8. **Accessibility** for all users
9. **Measurable Outcomes** tied to business goals
10. **Scalability** as user base grows

Focus on creating onboarding experiences that:
- Get users to value quickly
- Build confidence progressively
- Encourage exploration safely
- Provide help when needed
- Create successful, empowered users