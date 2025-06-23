<goal>
I'd like for you to help me brainstorm the overall technical structure of my application ona  high level. You should act like a Senior Software Engineer that has extensive experience developing, and building architecture for large scale web applications. You should ask me follow up questions as we proceed if you think it's necessary to gather a fuller picture. Any time I answer questions, you re-integrate the responses and generate a fully new output that integrates everything.

</goal>
<format>
Return your format in Markdown, without pre-text or post-text descriptions.

## Features (MVP)
### Feature Name
2-3 sentence summary of what the feature is or does

#### Tech Involved
* Main Technologies Involved w/ Feature

#### Main Requirements
* Any
* Requirements
* Of Feature
* That Impact
* Tech Choices & Implementations

## System Diagram
An image detailing a full system diagram of the MVP. Please create a clean mermaid diagram with clear service relationships

## List of Technical/Architecture Consideration Questions
* list
* of
* Architecture
* questions

</format>

<warnings-or-guidance>
x
</warnings-or-guidance>

<context>
<features-list>
Features List
## Authentication & User Management

 User registration with email verification
 Password reset functionality
 Profile management and settings

## Prompt Organization

 Create folder/tag hierarchy for organization

 Nested folders with drag-and-drop
 Multiple tags per prompt
 Smart collections based on rules


 Search across all prompts with filters

 Full-text search
 Filter by platform, date, tags, author
 Search within results



## Prompt Creation & Editing

 Rich text editor with Markdown/XML support

 Syntax highlighting
 Live preview
 Template variables ({{name}}, {{context}})


 Version control for prompts

 Save revision history
 Compare versions
 Restore previous versions


 Prompt templates and snippets

 Pre-built templates by category
 Custom snippet library
</features-list>
<current-tech-choices>
The frontend will be built in NextJS
The backend will be built using ServerActions
The database will be Postgres, hosted through Supabase
The authentication will use Clerk
Use Prisma ORM for database interactions
Deployment on Vercel
</current-tech-choices>

</context>

