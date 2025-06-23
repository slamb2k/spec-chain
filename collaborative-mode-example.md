# Collaborative Mode Example

This demonstrates how the hybrid PRD system would work with the prompt repository idea.

## Input (Basic Idea)
```
[IDEA]
I want to create a "prompt repository" where users can store their commonly used prompts in one centralized area. Prompts should be sharable, have privacy settings, and support Markdown and XML formatting

[MVP]
User logs in or signs up
User can create a storage hierarchy for their prompts
User can create new prompts and add them into storage
User can retrieve, view, and edit existing prompts
```

## Expected Collaborative Mode Output

The system would detect this as a basic idea (not detailed requirements) and use COLLABORATIVE MODE:

---

# Product Requirements Document: Prompt Repository

## Elevator Pitch
A centralized platform where professionals can store, organize, and share their commonly used AI prompts with privacy controls and rich formatting support.

## Problem Statement
AI professionals and power users currently face several pain points:
- Prompts are scattered across different tools, documents, and chat histories
- No easy way to organize prompts by category, project, or use case
- Difficult to share effective prompts with team members or the community
- Loss of valuable prompts when switching between AI tools or devices
- No version control or iteration tracking for prompt refinement

## Target Audience
**Primary Users:**
- AI professionals and consultants who use prompts daily
- Content creators and marketers using AI tools
- Developers integrating AI into applications
- Teams collaborating on AI-powered projects

**Technical Proficiency:** Medium to high - comfortable with markdown and structured data

## Unique Selling Proposition (USP)
The first dedicated platform for prompt management with enterprise-grade privacy controls, rich formatting support, and seamless sharing capabilities.

## Target Platforms
- **Web Application:** Primary platform for full functionality
- **Browser Extension:** Quick access and prompt injection
- **Mobile App:** View and basic editing on-the-go

## Features List

### Core Features (MVP)
- [ ] **User Authentication:** As a user, I want to securely sign up and log in so that my prompts are private and accessible
  - [ ] Email/password registration and login
  - [ ] Password reset functionality

- [ ] **Hierarchical Organization:** As a user, I want to create folders and categories so that I can organize my prompts logically
  - [ ] Create, rename, and delete folders
  - [ ] Drag-and-drop organization
  - [ ] Nested folder support

- [ ] **Prompt Management:** As a user, I want to create, edit, and store prompts so that I can reuse them efficiently
  - [ ] Rich text editor with Markdown and XML support
  - [ ] Prompt versioning and history
  - [ ] Tags and metadata

- [ ] **Privacy Controls:** As a user, I want to control who can see my prompts so that I can share selectively
  - [ ] Private, team, and public visibility settings
  - [ ] Share via link with permissions

### Future Features
- [ ] **Team Collaboration:** Shared workspaces and prompt libraries
- [ ] **AI Integration:** Direct integration with popular AI tools
- [ ] **Analytics:** Usage tracking and prompt performance metrics

## UX/UI Considerations
- [ ] **Dashboard/Library View**
  - [ ] Grid and list view options
  - [ ] Search and filter capabilities
  - [ ] Quick preview on hover

- [ ] **Prompt Editor**
  - [ ] Split view: editor and preview
  - [ ] Syntax highlighting for XML/Markdown
  - [ ] Auto-save functionality

## Non-Functional Requirements
- [ ] **Performance:** Page load times under 2 seconds, search results under 500ms
- [ ] **Scalability:** Support for 10,000+ prompts per user, 100,000+ users initially
- [ ] **Security:** End-to-end encryption for private prompts, SOC2 compliance
- [ ] **Accessibility:** WCAG 2.1 AA compliance

## Monetization
**Freemium Model:**
- Free tier: 50 prompts, basic organization
- Pro tier ($9/month): Unlimited prompts, advanced features, team sharing
- Enterprise tier ($29/user/month): Advanced security, SSO, analytics

## Critical Questions and Clarifications
1. **Integration Priority:** Which AI tools should we integrate with first? (ChatGPT, Claude, etc.)
2. **Sharing Granularity:** Should sharing be at folder level, individual prompt level, or both?
3. **Import/Export:** What formats should we support for bulk import/export?
4. **Search Functionality:** Should we include semantic search or just text-based?
5. **Collaboration Features:** Real-time editing vs. version-based collaboration?

---

**Next Steps:** Please provide feedback on any of these sections, answer the critical questions, or suggest additional features you'd like to see. I'll integrate your responses and present an updated complete specification.
