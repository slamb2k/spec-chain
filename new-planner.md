<tech-specification>AI Prompt Manager Technical Specification
1. Executive Summary
The AI Prompt Manager is a web-based application designed to help AI developers and prompt engineers organize, manage, and optimize their prompt library. The system provides a comprehensive solution for storing prompts with rich text editing, version control, advanced search capabilities, and intelligent organization through folders and tags.
Key Technical Decisions
Frontend: Next.js 14+ App Router for server-side rendering and optimal performance
Backend: Server Actions instead of traditional REST APIs for seamless client-server communication
Database: Supabase (PostgreSQL) for robust data storage with full-text search capabilities
Authentication: Clerk for enterprise-grade authentication with minimal implementation overhead
Deployment: Vercel for automatic scaling and global edge distribution
High-level Architecture
mermaid
graph TB
    subgraph "Client Layer"
        UI[Next.js App Router<br/>React 18+]
        STATE[Zustand Store]
        CACHE[React Query Cache]
    end
    
    subgraph "Edge Layer"
        MW[Next.js Middleware]
        CDN[Vercel Edge Network]
    end
    
    subgraph "Application Layer"
        SA[Server Actions]
        WH[Webhook Handlers]
    end
    
    subgraph "Data Layer"
        PRISMA[Prisma ORM]
        PG[(Supabase PostgreSQL)]
    end
    
    subgraph "External Services"
        CLERK[Clerk Auth]
        VERCEL[Vercel Platform]
    end
    
    UI --> STATE
    UI --> CACHE
    UI --> MW
    MW --> CLERK
    MW --> SA
    
    CACHE --> SA
    SA --> PRISMA
    PRISMA --> PG
    
    CLERK --> WH
    WH --> PRISMA
    
    UI --> CDN
    CDN --> VERCEL
2. System Architecture
2.1 Architecture Overview
The system follows a modern, serverless architecture optimized for developer experience and performance:
Frontend Architecture
Next.js App Router with React Server Components for optimal performance
Zustand for lightweight client-side state management
React Query for server state synchronization and caching
Progressive enhancement with JavaScript optional for core features
Backend Architecture
Server Actions for type-safe server mutations
Edge middleware for authentication and request routing
Webhook handlers for external service integration
Database-first design with Prisma ORM
Data Flow
User requests hit Vercel Edge Network
Middleware validates authentication via Clerk
Server Components fetch data directly from database
Client Components hydrate with cached data
Mutations occur through Server Actions
Real-time updates via React Query invalidation
2.2 Technology Stack
Frontend Technologies
Framework: Next.js 14+ (App Router)
UI Library: React 18+
State Management: Zustand 4+
Data Fetching: TanStack Query (React Query) v5
Styling: TailwindCSS 3.4+
Animation: Framer Motion 11+
Rich Text Editor: CodeMirror 6
Drag & Drop: @dnd-kit/sortable
Icons: Lucide React
Forms: React Hook Form + Zod
Date Handling: date-fns
Backend Technologies
Runtime: Node.js 20+ (Vercel)
API Layer: Next.js Server Actions
ORM: Prisma 5+
Validation: Zod
Error Tracking: Sentry
Logging: Pino
Database & Storage
Primary Database: Supabase (PostgreSQL 15+)
Caching: React Query in-memory cache
File Storage: Vercel Blob (for future attachments)
Search: PostgreSQL Full-Text Search with GIN indexes
Third-party Services
Authentication: Clerk
Hosting: Vercel
Monitoring: Vercel Analytics
Error Tracking: Sentry
3. Feature Specifications
3.1 Authentication & User Management
User Stories
As a user, I can sign up with email/password or social providers
As a user, I can reset my password via email
As a user, I can manage my profile and preferences
As a user, I can see my usage statistics and limits
Technical Requirements
Clerk SDK integration with Next.js middleware
User data synchronization via Clerk webhooks
Profile data stored in PostgreSQL for app-specific metadata
Session management through Clerk's JWT tokens
Implementation Approach
typescript
// middleware.ts
import { authMiddleware } from "@clerk/nextjs";

export default authMiddleware({
  publicRoutes: ["/", "/features", "/pricing"],
  afterAuth(auth, req) {
    // Handle post-auth logic
  }
});

// app/api/webhooks/clerk/route.ts
export async function POST(req: Request) {
  const event = await validateWebhookEvent(req);
  
  switch (event.type) {
    case 'user.created':
      await createUserProfile(event.data);
      break;
    case 'user.updated':
      await updateUserProfile(event.data);
      break;
  }
}
User Flow
User clicks "Sign Up" → Clerk modal appears
User enters credentials → Clerk validates
On success → Webhook creates user profile in database
User redirected to onboarding flow
Profile preferences saved via Server Action
API Endpoints (Server Actions)
updateUserProfile(data: UserProfileInput): Promise<UserProfile>
updateUserPreferences(preferences: UserPreferences): Promise<void>
getUserStats(): Promise<UserStatistics>
Data Models
prisma
model User {
  id            String   @id @default(cuid())
  clerkId       String   @unique
  email         String   @unique
  name          String?
  avatar        String?
  preferences   Json     @default("{}")
  onboarded     Boolean  @default(false)
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt
  
  prompts       Prompt[]
  folders       Folder[]
  tags          Tag[]
  templates     Template[]
}
Error Handling
Clerk authentication errors show inline messages
Network errors trigger retry with exponential backoff
Webhook failures logged to Sentry with retry queue
Performance Considerations
User profiles cached in React Query for 5 minutes
Clerk session cached in httpOnly cookies
Minimal database queries through careful data modeling
3.2 Prompt Organization
User Stories
As a user, I can create nested folders to organize prompts
As a user, I can drag and drop prompts between folders
As a user, I can create smart collections with rules
As a user, I can tag prompts for multi-dimensional organization
Technical Requirements
Recursive folder structure with PostgreSQL CTEs
Optimistic UI updates for drag-and-drop operations
Many-to-many relationships for prompt-tag associations
Smart collection rule engine with dynamic queries
Implementation Approach
typescript
// Recursive folder query
const getFolderTree = async (userId: string) => {
  return prisma.$queryRaw`
    WITH RECURSIVE folder_tree AS (
      SELECT * FROM folders 
      WHERE user_id = ${userId} AND parent_id IS NULL
      
      UNION ALL
      
      SELECT f.* FROM folders f
      INNER JOIN folder_tree ft ON f.parent_id = ft.id
    )
    SELECT * FROM folder_tree
    ORDER BY parent_id, position
  `;
};

// Drag and drop handler
async function moveItem(itemId: string, targetFolderId: string, position: number) {
  // Optimistic update
  updateCache(itemId, { folderId: targetFolderId, position });
  
  try {
    await movePromptServerAction(itemId, targetFolderId, position);
  } catch (error) {
    // Revert on failure
    revertCache(itemId);
    throw error;
  }
}
User Flow
User creates folder via modal dialog
Folder appears in sidebar with animation
User drags prompt to folder
UI updates optimistically
Server Action persists change
On error, UI reverts with error toast
Data Models
prisma
model Folder {
  id        String   @id @default(cuid())
  name      String
  color     String?
  icon      String?
  userId    String
  parentId  String?
  position  Int      @default(0)
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
  
  user      User     @relation(fields: [userId], references: [id])
  parent    Folder?  @relation("FolderHierarchy", fields: [parentId], references: [id])
  children  Folder[] @relation("FolderHierarchy")
  prompts   Prompt[]
  
  @@index([userId, parentId])
}

model SmartCollection {
  id        String   @id @default(cuid())
  name      String
  userId    String
  rules     Json     // Rule engine configuration
  createdAt DateTime @default(now())
  
  user      User     @relation(fields: [userId], references: [id])
}
Error Handling
Cascade delete protection with confirmation dialog
Circular reference prevention in folder moves
Maximum nesting depth of 10 levels
Optimistic updates with automatic rollback
3.3 Search & Filtering
User Stories
As a user, I can search prompts by title, content, or tags
As a user, I can filter by platform, date range, and author
As a user, I can see search suggestions as I type
As a user, I can save frequent searches
Technical Requirements
PostgreSQL full-text search with GIN indexes
Real-time search with debouncing
Faceted search with count aggregations
Search result ranking by relevance
Implementation Approach
typescript
// Database indexes
CREATE INDEX prompt_search_idx ON prompts 
USING GIN (to_tsvector('english', title || ' ' || content));

// Server Action for search
export async function searchPrompts(query: SearchQuery) {
  const { text, filters, page = 1, limit = 20 } = query;
  
  const results = await prisma.$queryRaw`
    SELECT 
      p.*,
      ts_rank(to_tsvector('english', p.title || ' ' || p.content), 
              plainto_tsquery('english', ${text})) AS rank
    FROM prompts p
    WHERE 
      to_tsvector('english', p.title || ' ' || p.content) @@ 
      plainto_tsquery('english', ${text})
      ${filters.platform ? Prisma.sql`AND p.platform = ${filters.platform}` : Prisma.empty}
    ORDER BY rank DESC
    LIMIT ${limit} OFFSET ${(page - 1) * limit}
  `;
  
  return results;
}
User Flow
User types in search box
Debounced search triggers after 300ms
Loading skeleton appears
Results render with highlighting
Filters update result count in real-time
Click result to view/edit prompt
Data Models
prisma
model SearchHistory {
  id        String   @id @default(cuid())
  userId    String
  query     String
  filters   Json?
  createdAt DateTime @default(now())
  
  user      User     @relation(fields: [userId], references: [id])
  
  @@index([userId, createdAt])
}
Performance Considerations
GIN indexes for full-text search performance
Search results cached for 60 seconds
Pagination with cursor-based navigation
Query suggestion from popular searches
3.4 Prompt Creation & Editing
User Stories
As a user, I can create prompts with rich text formatting
As a user, I can use variables in my prompts
As a user, I can see version history and restore old versions
As a user, I can preview prompts before saving
Technical Requirements
CodeMirror 6 for syntax highlighting and editing
Real-time Markdown/XML parsing and preview
Automatic version creation on save
Diff algorithm for version comparison
Implementation Approach
typescript
// Rich text editor setup
import { EditorState } from "@codemirror/state";
import { markdown } from "@codemirror/lang-markdown";

const editorConfig = {
  extensions: [
    markdown(),
    syntaxHighlighting(),
    variableDetection(),
    autoSave({ delay: 2000 })
  ]
};

// Version control
export async function savePromptVersion(
  promptId: string, 
  content: string,
  userId: string
) {
  const lastVersion = await getLastVersion(promptId);
  
  if (hasSignificantChanges(lastVersion?.content, content)) {
    await prisma.promptVersion.create({
      data: {
        promptId,
        content,
        versionNumber: (lastVersion?.versionNumber || 0) + 1,
        createdBy: userId,
        changeSummary: generateChangeSummary(lastVersion?.content, content)
      }
    });
  }
}
User Flow
User clicks "New Prompt"
Editor opens with template
User types with syntax highlighting
Preview updates in real-time
Auto-save triggers every 2 seconds
Version created on significant changes
Data Models
prisma
model Prompt {
  id          String   @id @default(cuid())
  title       String
  content     String   @db.Text
  description String?
  platform    Platform @default(GENERAL)
  userId      String
  folderId    String?
  isTemplate  Boolean  @default(false)
  isPublic    Boolean  @default(false)
  variables   Json?    // Template variables
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
  
  user        User     @relation(fields: [userId], references: [id])
  folder      Folder?  @relation(fields: [folderId], references: [id])
  versions    PromptVersion[]
  tags        PromptTag[]
  
  @@index([userId, folderId])
  @@index([platform])
}

model PromptVersion {
  id            String   @id @default(cuid())
  promptId      String
  content       String   @db.Text
  versionNumber Int
  changeSummary String?
  createdBy     String
  createdAt     DateTime @default(now())
  
  prompt        Prompt   @relation(fields: [promptId], references: [id], onDelete: Cascade)
}
3.5 Templates & Snippets
User Stories
As a user, I can browse pre-built prompt templates
As a user, I can create custom snippets for reuse
As a user, I can use variables in templates
As a user, I can see template usage analytics
Technical Requirements
Template categorization and search
Variable substitution engine
Snippet insertion with keyboard shortcuts
Usage tracking for popular templates
Implementation Approach
typescript
// Template variable system
interface TemplateVariable {
  name: string;
  type: 'text' | 'select' | 'number';
  default?: string;
  options?: string[];
  validation?: string; // Regex pattern
}

// Variable substitution
export function processTemplate(
  template: string, 
  variables: Record<string, any>
): string {
  return template.replace(
    /\{\{(\w+)\}\}/g, 
    (match, varName) => variables[varName] || match
  );
}

// Server Action
export async function createPromptFromTemplate(
  templateId: string,
  variables: Record<string, any>
) {
  const template = await prisma.template.findUnique({
    where: { id: templateId }
  });
  
  const processedContent = processTemplate(
    template.content, 
    variables
  );
  
  // Track usage
  await prisma.template.update({
    where: { id: templateId },
    data: { usageCount: { increment: 1 } }
  });
  
  return createPrompt({
    title: processTemplate(template.name, variables),
    content: processedContent,
    isTemplate: false
  });
}
Data Models
prisma
model Template {
  id          String   @id @default(cuid())
  name        String
  description String?
  category    String
  content     String   @db.Text
  variables   Json?    // Variable definitions
  isPublic    Boolean  @default(true)
  usageCount  Int      @default(0)
  createdBy   String
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
  
  creator     User     @relation(fields: [createdBy], references: [id])
  
  @@index([category])
  @@index([usageCount])
}

model Snippet {
  id        String   @id @default(cuid())
  name      String
  content   String
  shortcut  String?  // Keyboard shortcut
  userId    String
  createdAt DateTime @default(now())
  
  user      User     @relation(fields: [userId], references: [id])
}
4. Data Architecture
4.1 Data Models
User Entity
prisma
model User {
  id              String    @id @default(cuid())
  clerkId         String    @unique
  email           String    @unique
  name            String?
  avatar          String?
  bio             String?
  preferences     Json      @default("{}")
  onboarded       Boolean   @default(false)
  role            UserRole  @default(USER)
  storageUsed     BigInt    @default(0)
  promptCount     Int       @default(0)
  lastActiveAt    DateTime  @default(now())
  createdAt       DateTime  @default(now())
  updatedAt       DateTime  @updatedAt
  
  // Relations
  prompts         Prompt[]
  folders         Folder[]
  tags            Tag[]
  templates       Template[]
  searchHistory   SearchHistory[]
  activities      Activity[]
  
  @@index([clerkId])
  @@index([email])
}

enum UserRole {
  USER
  ADMIN
}
Prompt Entity
prisma
model Prompt {
  id              String    @id @default(cuid())
  title           String
  content         String    @db.Text
  description     String?
  platform        Platform  @default(GENERAL)
  model           String?   // AI model specification
  userId          String
  folderId        String?
  isTemplate      Boolean   @default(false)
  isPublic        Boolean   @default(false)
  isFavorite      Boolean   @default(false)
  variables       Json?     // Template variables
  metadata        Json?     // Additional metadata
  lastUsedAt      DateTime?
  viewCount       Int       @default(0)
  copyCount       Int       @default(0)
  createdAt       DateTime  @default(now())
  updatedAt       DateTime  @updatedAt
  
  // Relations
  user            User      @relation(fields: [userId], references: [id], onDelete: Cascade)
  folder          Folder?   @relation(fields: [folderId], references: [id], onDelete: SetNull)
  versions        PromptVersion[]
  tags            PromptTag[]
  activities      Activity[]
  
  // Indexes
  @@index([userId, folderId])
  @@index([platform])
  @@index([isPublic])
  @@index([createdAt])
}

enum Platform {
  GENERAL
  CHATGPT
  CLAUDE
  GEMINI
  MIDJOURNEY
  DALLE
  STABLE_DIFFUSION
  CUSTOM
}
Folder Entity
prisma
model Folder {
  id              String    @id @default(cuid())
  name            String
  description     String?
  color           String?   @default("#8B5CF6")
  icon            String?   @default("folder")
  userId          String
  parentId        String?
  position        Int       @default(0)
  isExpanded      Boolean   @default(false)
  promptCount     Int       @default(0) // Denormalized for performance
  createdAt       DateTime  @default(now())
  updatedAt       DateTime  @updatedAt
  
  // Relations
  user            User      @relation(fields: [userId], references: [id], onDelete: Cascade)
  parent          Folder?   @relation("FolderHierarchy", fields: [parentId], references: [id], onDelete: Cascade)
  children        Folder[]  @relation("FolderHierarchy")
  prompts         Prompt[]
  
  // Constraints
  @@unique([userId, parentId, name]) // Unique folder names within same parent
  @@index([userId, parentId])
  @@index([position])
}
Tag Entity
prisma
model Tag {
  id              String    @id @default(cuid())
  name            String
  color           String?   @default("#A78BFA")
  userId          String
  usageCount      Int       @default(0) // Denormalized
  createdAt       DateTime  @default(now())
  
  // Relations
  user            User      @relation(fields: [userId], references: [id], onDelete: Cascade)
  prompts         PromptTag[]
  
  // Constraints
  @@unique([userId, name])
  @@index([userId])
  @@index([usageCount])
}

model PromptTag {
  promptId        String
  tagId           String
  createdAt       DateTime  @default(now())
  
  // Relations
  prompt          Prompt    @relation(fields: [promptId], references: [id], onDelete: Cascade)
  tag             Tag       @relation(fields: [tagId], references: [id], onDelete: Cascade)
  
  @@id([promptId, tagId])
  @@index([tagId])
}
Version Control
prisma
model PromptVersion {
  id              String    @id @default(cuid())
  promptId        String
  content         String    @db.Text
  versionNumber   Int
  changeSummary   String?
  metadata        Json?     // Diff metadata
  createdBy       String
  createdAt       DateTime  @default(now())
  
  // Relations
  prompt          Prompt    @relation(fields: [promptId], references: [id], onDelete: Cascade)
  
  // Constraints
  @@unique([promptId, versionNumber])
  @@index([promptId, createdAt])
}
Activity Tracking
prisma
model Activity {
  id              String    @id @default(cuid())
  userId          String
  action          Action
  entityType      EntityType
  entityId        String
  metadata        Json?     // Additional context
  ipAddress       String?
  userAgent       String?
  createdAt       DateTime  @default(now())
  
  // Relations
  user            User      @relation(fields: [userId], references: [id], onDelete: Cascade)
  
  @@index([userId, createdAt])
  @@index([entityType, entityId])
}

enum Action {
  CREATE
  UPDATE
  DELETE
  VIEW
  COPY
  SHARE
  EXPORT
  IMPORT
}

enum EntityType {
  PROMPT
  FOLDER
  TAG
  TEMPLATE
}
4.2 Data Storage
Database Selection
Supabase PostgreSQL: Primary database for all application data
Rationale:
Native full-text search capabilities
JSONB support for flexible metadata
Row-level security for multi-tenancy
Recursive CTEs for folder hierarchies
Built-in connection pooling
Data Persistence Strategies
Write-through caching: React Query cache with database as source of truth
Optimistic updates: Immediate UI updates with rollback on failure
Soft deletes: Prompts marked as deleted, purged after 30 days
Audit trail: All modifications tracked in Activity table
Caching Mechanisms
typescript
// React Query configuration
const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 5 * 60 * 1000, // 5 minutes
      cacheTime: 10 * 60 * 1000, // 10 minutes
      refetchOnWindowFocus: false,
      retry: 3,
    },
  },
});

// Cache key patterns
const cacheKeys = {
  prompts: {
    all: ['prompts'],
    lists: () => [...cacheKeys.prompts.all, 'list'],
    list: (filters: any) => [...cacheKeys.prompts.lists(), filters],
    details: () => [...cacheKeys.prompts.all, 'detail'],
    detail: (id: string) => [...cacheKeys.prompts.details(), id],
  },
  folders: {
    tree: (userId: string) => ['folders', 'tree', userId],
  },
};
Backup and Recovery
Automated backups: Supabase daily backups with 30-day retention
Point-in-time recovery: Available for last 7 days
Export functionality: Users can export all prompts as JSON/Markdown
Import validation: Schema validation before importing data
5. API Specifications
5.1 Internal APIs (Server Actions)
Authentication Actions
typescript
// app/actions/auth.ts
export async function updateUserProfile(input: {
  name?: string;
  bio?: string;
  preferences?: UserPreferences;
}) {
  const user = await requireAuth();
  
  const updated = await prisma.user.update({
    where: { id: user.id },
    data: {
      ...input,
      updatedAt: new Date(),
    },
  });
  
  revalidatePath('/settings');
  return updated;
}
Prompt Management Actions
typescript
// app/actions/prompts.ts
export async function createPrompt(input: {
  title: string;
  content: string;
  description?: string;
  platform?: Platform;
  folderId?: string;
  tags?: string[];
}) {
  const user = await requireAuth();
  
  const prompt = await prisma.prompt.create({
    data: {
      ...input,
      userId: user.id,
      tags: {
        create: input.tags?.map(tagName => ({
          tag: {
            connectOrCreate: {
              where: { userId_name: { userId: user.id, name: tagName } },
              create: { name: tagName, userId: user.id },
            },
          },
        })),
      },
    },
    include: { tags: { include: { tag: true } } },
  });
  
  // Track activity
  await trackActivity({
    action: 'CREATE',
    entityType: 'PROMPT',
    entityId: prompt.id,
  });
  
  revalidatePath('/prompts');
  return prompt;
}

export async function updatePrompt(
  id: string,
  input: Partial<PromptInput>
) {
  const user = await requireAuth();
  
  // Verify ownership
  const existing = await prisma.prompt.findFirst({
    where: { id, userId: user.id },
  });
  
  if (!existing) throw new Error('Prompt not found');
  
  // Create version if content changed
  if (input.content && input.content !== existing.content) {
    await createPromptVersion(id, existing.content);
  }
  
  const updated = await prisma.prompt.update({
    where: { id },
    data: input,
  });
  
  revalidatePath(`/prompts/${id}`);
  return updated;
}

export async function deletePrompt(id: string) {
  const user = await requireAuth();
  
  await prisma.prompt.deleteMany({
    where: { id, userId: user.id },
  });
  
  revalidatePath('/prompts');
}

export async function searchPrompts(query: {
  text?: string;
  platform?: Platform;
  tags?: string[];
  folderId?: string;
  dateFrom?: Date;
  dateTo?: Date;
  page?: number;
  limit?: number;
}) {
  const user = await requireAuth();
  const { page = 1, limit = 20, ...filters } = query;
  
  const where: any = { userId: user.id };
  
  if (filters.text) {
    where.OR = [
      { title: { contains: filters.text, mode: 'insensitive' } },
      { content: { contains: filters.text, mode: 'insensitive' } },
    ];
  }
  
  if (filters.platform) where.platform = filters.platform;
  if (filters.folderId) where.folderId = filters.folderId;
  
  if (filters.tags?.length) {
    where.tags = {
      some: {
        tag: { name: { in: filters.tags } },
      },
    };
  }
  
  if (filters.dateFrom || filters.dateTo) {
    where.createdAt = {};
    if (filters.dateFrom) where.createdAt.gte = filters.dateFrom;
    if (filters.dateTo) where.createdAt.lte = filters.dateTo;
  }
  
  const [prompts, total] = await Promise.all([
    prisma.prompt.findMany({
      where,
      include: { tags: { include: { tag: true } } },
      orderBy: { updatedAt: 'desc' },
      skip: (page - 1) * limit,
      take: limit,
    }),
    prisma.prompt.count({ where }),
  ]);
  
  return {
    prompts,
    pagination: {
      page,
      limit,
      total,
      pages: Math.ceil(total / limit),
    },
  };
}
Folder Management Actions
typescript
// app/actions/folders.ts
export async function createFolder(input: {
  name: string;
  parentId?: string;
  color?: string;
  icon?: string;
}) {
  const user = await requireAuth();
  
  // Get next position
  const maxPosition = await prisma.folder.findFirst({
    where: { userId: user.id, parentId: input.parentId },
    orderBy: { position: 'desc' },
    select: { position: true },
  });
  
  const folder = await prisma.folder.create({
    data: {
      ...input,
      userId: user.id,
      position: (maxPosition?.position ?? -1) + 1,
    },
  });
  
  revalidatePath('/prompts');
  return folder;
}

export async function moveFolder(
  id: string,
  targetParentId: string | null,
  position: number
) {
  const user = await requireAuth();
  
  // Verify ownership and prevent circular reference
  const folder = await prisma.folder.findFirst({
    where: { id, userId: user.id },
  });
  
  if (!folder) throw new Error('Folder not found');
  
  // Check for circular reference
  if (targetParentId) {
    const isCircular = await checkCircularReference(id, targetParentId);
    if (isCircular) throw new Error('Circular reference detected');
  }
  
  // Update positions
  await prisma.$transaction([
    // Shift positions in target location
    prisma.folder.updateMany({
      where: {
        userId: user.id,
        parentId: targetParentId,
        position: { gte: position },
      },
      data: { position: { increment: 1 } },
    }),
    // Move folder
    prisma.folder.update({
      where: { id },
      data: { parentId: targetParentId, position },
    }),
  ]);
  
  revalidatePath('/prompts');
}

export async function getFolderTree(userId: string) {
  const folders = await prisma.$queryRaw<Folder[]>`
    WITH RECURSIVE folder_tree AS (
      SELECT * FROM "Folder" 
      WHERE "userId" = ${userId} AND "parentId" IS NULL
      
      UNION ALL
      
      SELECT f.* FROM "Folder" f
      INNER JOIN folder_tree ft ON f."parentId" = ft.id
    )
    SELECT * FROM folder_tree
    ORDER BY "parentId", position
  `;
  
  // Build tree structure
  return buildFolderTree(folders);
}
Response Schemas All Server Actions return typed responses using Zod schemas:
typescript
// schemas/api.ts
import { z } from 'zod';

export const PromptSchema = z.object({
  id: z.string(),
  title: z.string(),
  content: z.string(),
  description: z.string().optional(),
  platform: z.enum(['GENERAL', 'CHATGPT', 'CLAUDE', ...]),
  userId: z.string(),
  folderId: z.string().optional(),
  isTemplate: z.boolean(),
  isPublic: z.boolean(),
  createdAt: z.date(),
  updatedAt: z.date(),
  tags: z.array(TagSchema).optional(),
});

export const PaginatedResponseSchema = z.object({
  data: z.array(z.unknown()),
  pagination: z.object({
    page: z.number(),
    limit: z.number(),
    total: z.number(),
    pages: z.number(),
  }),
});

export const ErrorResponseSchema = z.object({
  error: z.string(),
  code: z.string().optional(),
  details: z.record(z.string()).optional(),
});
5.2 External Integrations
Clerk Authentication
typescript
// Integration: Clerk webhooks
// app/api/webhooks/clerk/route.ts
import { Webhook } from 'svix';
import { headers } from 'next/headers';
import { WebhookEvent } from '@clerk/nextjs/server';

export async function POST(req: Request) {
  const WEBHOOK_SECRET = process.env.CLERK_WEBHOOK_SECRET;
  
  if (!WEBHOOK_SECRET) {
    throw new Error('Missing CLERK_WEBHOOK_SECRET');
  }
  
  // Get headers
  const headerPayload = headers();
  const svix_id = headerPayload.get("svix-id");
  const svix_timestamp = headerPayload.get("svix-timestamp");
  const svix_signature = headerPayload.get("svix-signature");
  
  // Get body
  const payload = await req.json();
  const body = JSON.stringify(payload);
  
  // Verify webhook
  const wh = new Webhook(WEBHOOK_SECRET);
  let evt: WebhookEvent;
  
  try {
    evt = wh.verify(body, {
      "svix-id": svix_id!,
      "svix-timestamp": svix_timestamp!,
      "svix-signature": svix_signature!,
    }) as WebhookEvent;
  } catch (err) {
    return new Response('Error verifying webhook', { status: 400 });
  }
  
  // Handle events
  switch (evt.type) {
    case 'user.created':
      await handleUserCreated(evt.data);
      break;
    case 'user.updated':
      await handleUserUpdated(evt.data);
      break;
    case 'user.deleted':
      await handleUserDeleted(evt.data);
      break;
  }
  
  return new Response('', { status: 200 });
}

async function handleUserCreated(userData: any) {
  await prisma.user.create({
    data: {
      clerkId: userData.id,
      email: userData.email_addresses[0].email_address,
      name: `${userData.first_name} ${userData.last_name}`.trim(),
      avatar: userData.image_url,
    },
  });
}
Supabase Database
typescript
// lib/supabase.ts
import { PrismaClient } from '@prisma/client';

// Connection URL from environment
const prismaClientSingleton = () => {
  return new PrismaClient({
    datasources: {
      db: {
        url: process.env.DATABASE_URL,
      },
    },
    log: process.env.NODE_ENV === 'development' 
      ? ['query', 'error', 'warn'] 
      : ['error'],
  });
};

declare global {
  var prisma: undefined | ReturnType<typeof prismaClientSingleton>;
}

export const prisma = globalThis.prisma ?? prismaClientSingleton();

if (process.env.NODE_ENV !== 'production') {
  globalThis.prisma = prisma;
}
Future Integrations
typescript
// AI Platform Integration (future)
interface AIIntegration {
  provider: 'openai' | 'anthropic' | 'google';
  apiKey: string;
  testPrompt: (prompt: string) => Promise<string>;
  validatePrompt: (prompt: string) => Promise<ValidationResult>;
}

// Export Integration (future)
interface ExportIntegration {
  format: 'json' | 'markdown' | 'csv';
  export: (prompts: Prompt[]) => Promise<Blob>;
  import: (file: File) => Promise<Prompt[]>;
}
6. Security & Privacy
6.1 Authentication & Authorization
Authentication Mechanism
Provider: Clerk with JWT-based authentication
Session Management: HTTP-only cookies with secure flag
Token Handling: Automatic refresh with 15-minute access tokens
Multi-factor: Optional TOTP-based 2FA through Clerk
Authorization Strategy
typescript
// middleware.ts
export const config = {
  matcher: ['/((?!api|_next/static|_next/image|favicon.ico).*)'],
};

export default authMiddleware({
  publicRoutes: ['/', '/features', '/pricing', '/blog(.*)'],
  afterAuth(auth, req) {
    // Redirect logged out users to sign-in
    if (!auth.userId && !auth.isPublicRoute) {
      return redirectToSignIn({ returnBackUrl: req.url });
    }
    
    // Redirect onboarding if needed
    if (auth.userId && !auth.isPublicRoute) {
      const user = await getUserProfile(auth.userId);
      if (!user?.onboarded && req.nextUrl.pathname !== '/onboarding') {
        return NextResponse.redirect(new URL('/onboarding', req.url));
      }
    }
  },
});

// Server-side authorization
export async function requireAuth() {
  const { userId } = auth();
  if (!userId) throw new Error('Unauthorized');
  
  const user = await prisma.user.findUnique({
    where: { clerkId: userId },
  });
  
  if (!user) throw new Error('User not found');
  return user;
}

// Role-based access
export async function requireRole(role: UserRole) {
  const user = await requireAuth();
  if (user.role !== role) throw new Error('Insufficient permissions');
  return user;
}
6.2 Data Security
Encryption Strategies
At Rest: Supabase encrypts all data at rest using AES-256
In Transit: All connections use TLS 1.3
Sensitive Data: User tokens encrypted with APP_SECRET before storage
typescript
// lib/encryption.ts
import { createCipheriv, createDecipheriv, randomBytes } from 'crypto';

const algorithm = 'aes-256-gcm';
const secretKey = Buffer.from(process.env.ENCRYPTION_KEY!, 'hex');

export function encrypt(text: string): string {
  const iv = randomBytes(16);
  const cipher = createCipheriv(algorithm, secretKey, iv);
  
  const encrypted = Buffer.concat([
    cipher.update(text, 'utf8'),
    cipher.final(),
  ]);
  
  const authTag = cipher.getAuthTag();
  
  return Buffer.concat([authTag, iv, encrypted]).toString('hex');
}

export function decrypt(encryptedHex: string): string {
  const encrypted = Buffer.from(encryptedHex, 'hex');
  
  const authTag = encrypted.slice(0, 16);
  const iv = encrypted.slice(16, 32);
  const text = encrypted.slice(32);
  
  const decipher = createDecipheriv(algorithm, secretKey, iv);
  decipher.setAuthTag(authTag);
  
  return decipher.update(text) + decipher.final('utf8');
}
PII Handling
Email addresses hashed for logging
No PII in URL parameters
User data deletion on account closure
Export functionality for data portability
Compliance Requirements
GDPR: Data export, deletion rights, consent management
CCPA: California privacy rights support
SOC 2: Audit logging, access controls
6.3 Application Security
Input Validation
typescript
// lib/validation.ts
import { z } from 'zod';
import DOMPurify from 'isomorphic-dompurify';

// Prompt content validation
export const PromptContentSchema = z.string()
  .min(1, 'Content is required')
  .max(50000, 'Content too long')
  .transform((content) => {
    // Sanitize HTML but preserve markdown
    return DOMPurify.sanitize(content, {
      ALLOWED_TAGS: [],
      ALLOWED_ATTR: [],
      KEEP_CONTENT: true,
    });
  });

// SQL injection prevention via Prisma
// XSS prevention via React's default escaping
// CSRF protection via Server Actions
Security Headers
typescript
// next.config.js
const securityHeaders = [
  {
    key: 'X-DNS-Prefetch-Control',
    value: 'on'
  },
  {
    key: 'Strict-Transport-Security',
    value: 'max-age=63072000; includeSubDomains; preload'
  },
  {
    key: 'X-XSS-Protection',
    value: '1; mode=block'
  },
  {
    key: 'X-Frame-Options',
    value: 'SAMEORIGIN'
  },
  {
    key: 'X-Content-Type-Options',
    value: 'nosniff'
  },
  {
    key: 'Referrer-Policy',
    value: 'origin-when-cross-origin'
  },
  {
    key: 'Content-Security-Policy',
    value: ContentSecurityPolicy.replace(/\s{2,}/g, ' ').trim()
  }
];
Rate Limiting
typescript
// lib/rate-limit.ts
import { Ratelimit } from '@upstash/ratelimit';
import { Redis } from '@upstash/redis';

const ratelimit = new Ratelimit({
  redis: Redis.fromEnv(),
  limiter: Ratelimit.slidingWindow(10, '10 s'),
});

export async function checkRateLimit(identifier: string) {
  const { success, limit, reset, remaining } = await ratelimit.limit(
    identifier
  );
  
  if (!success) {
    throw new Error('Rate limit exceeded');
  }
  
  return { limit, reset, remaining };
}

// Usage in Server Actions
export async function createPrompt(input: PromptInput) {
  const user = await requireAuth();
  await checkRateLimit(`create-prompt:${user.id}`);
  
  // ... rest of implementation
}
7. User Interface Specifications
7.1 Design System
Visual Design Principles
Bold Simplicity: Clean interfaces with purposeful complexity
Breathable Whitespace: Strategic negative space for cognitive comfort
Motion Choreography: Physics-based transitions for spatial continuity
Content-First: Prioritize user objectives over decoration
Component Library Structure
/components
  /ui              # Base UI components
    /button
    /input
    /card
    /modal
  /features        # Feature-specific components
    /prompts
    /folders
    /editor
  /layouts         # Layout components
    /sidebar
    /header
    /footer
Responsive Design Approach
Mobile-first development
Breakpoints: 640px (sm), 768px (md), 1024px (lg), 1280px (xl)
Touch-optimized interactions for mobile
Adaptive layouts for different screen sizes
Accessibility Standards
WCAG 2.1 AA compliance
Keyboard navigation support
Screen reader optimization
Focus indicators and skip links
Reduced motion preferences
7.2 Design Foundations
7.2.1 Color System
Primary Colors
css
:root {
  /* Primary */
  --primary-dark: #0F0F14;        /* Deep charcoal backgrounds */
  --primary-surface: #1A1A1F;     /* Elevated surfaces */
  --primary-light: #F8F9FA;       /* Text and highlights */
  
  /* Secondary */
  --secondary-purple: #8B5CF6;    /* Primary accent */
  --secondary-purple-light: #A78BFA; /* Hover states */
  --secondary-purple-pale: #EDE9FE;  /* Subtle backgrounds */
  
  /* Accent Gradient */
  --gradient-start: #8B5CF6;      /* Purple */
  --gradient-end: #EC4899;        /* Pink */
  --gradient: linear-gradient(135deg, var(--gradient-start), var(--gradient-end));
  
  /* Functional */
  --success: #10B981;
  --warning: #F59E0B;
  --error: #EF4444;
  --info: #3B82F6;
  
  /* Neutrals */
  --neutral-50: #FAFAFA;
  --neutral-100: #F4F4F5;
  --neutral-200: #E4E4E7;
  --neutral-400: #A1A1AA;
  --neutral-500: #71717A;
  --neutral-600: #52525B;
  --neutral-700: #3F3F46;
  --neutral-800: #27272A;
  --neutral-900: #18181B;
}
7.2.2 Typography
css
:root {
  /* Font Families */
  --font-sans: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  --font-mono: 'JetBrains Mono', 'Courier New', monospace;
  
  /* Font Sizes */
  --text-xs: 0.75rem;     /* 12px */
  --text-sm: 0.875rem;    /* 14px */
  --text-base: 1rem;      /* 16px */
  --text-lg: 1.125rem;    /* 18px */
  --text-xl: 1.25rem;     /* 20px */
  --text-2xl: 1.5rem;     /* 24px */
  --text-3xl: 1.75rem;    /* 28px */
  --text-4xl: 2rem;       /* 32px */
  
  /* Line Heights */
  --leading-tight: 1.25;
  --leading-normal: 1.5;
  --leading-relaxed: 1.75;
  
  /* Font Weights */
  --font-light: 300;
  --font-normal: 400;
  --font-medium: 500;
  --font-semibold: 600;
  --font-bold: 700;
}

/* Typography Classes */
.heading-1 {
  font-size: var(--text-4xl);
  font-weight: var(--font-bold);
  line-height: var(--leading-tight);
  letter-spacing: -0.025em;
}

.body-large {
  font-size: var(--text-base);
  font-weight: var(--font-normal);
  line-height: var(--leading-normal);
}

.code-block {
  font-family: var(--font-mono);
  font-size: var(--text-sm);
  line-height: var(--leading-normal);
}
7.2.3 Spacing & Layout
css
:root {
  /* Base Unit: 4px */
  --space-1: 0.25rem;   /* 4px */
  --space-2: 0.5rem;    /* 8px */
  --space-3: 0.75rem;   /* 12px */
  --space-4: 1rem;      /* 16px */
  --space-5: 1.25rem;   /* 20px */
  --space-6: 1.5rem;    /* 24px */
  --space-8: 2rem;      /* 32px */
  --space-10: 2.5rem;   /* 40px */
  --space-12: 3rem;     /* 48px */
  --space-16: 4rem;     /* 64px */
  
  /* Container */
  --container-sm: 640px;
  --container-md: 768px;
  --container-lg: 1024px;
  --container-xl: 1280px;
  
  /* Border Radius */
  --radius-sm: 0.25rem;   /* 4px */
  --radius-md: 0.5rem;    /* 8px */
  --radius-lg: 0.75rem;   /* 12px */
  --radius-xl: 1rem;      /* 16px */
  --radius-full: 9999px;
}
7.2.4 Interactive Elements
css
/* Button Base */
.button {
  height: 40px;
  padding: 0 var(--space-6);
  font-size: var(--text-sm);
  font-weight: var(--font-medium);
  border-radius: var(--radius-md);
  transition: all 200ms cubic-bezier(0.4, 0, 0.2, 1);
  cursor: pointer;
}

/* Primary Button */
.button-primary {
  background: var(--gradient);
  color: white;
  box-shadow: 0 4px 6px -1px rgba(139, 92, 246, 0.25);
}

.button-primary:hover {
  filter: brightness(1.1);
  transform: scale(1.02);
}

.button-primary:active {
  transform: scale(0.98);
}

/* Input Fields */
.input {
  height: 40px;
  padding: 0 var(--space-4);
  background: var(--primary-dark);
  border: 1px solid var(--neutral-800);
  border-radius: var(--radius-md);
  color: var(--neutral-100);
  font-size: var(--text-sm);
  transition: all 150ms ease-out;
}

.input:focus {
  outline: none;
  border-color: var(--secondary-purple);
  box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.1);
}

/* Cards */
.card {
  background: var(--primary-surface);
  border: 1px solid rgba(255, 255, 255, 0.06);
  border-radius: var(--radius-lg);
  padding: var(--space-6);
  box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.3);
  transition: all 200ms ease-out;
}

.card:hover {
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.4);
  transform: translateY(-1px);
}
7.2.5 Component Specifications
Design Tokens Structure
typescript
// theme/tokens.ts
export const tokens = {
  colors: {
    primary: {
      dark: '#0F0F14',
      surface: '#1A1A1F',
      light: '#F8F9FA',
    },
    secondary: {
      purple: '#8B5CF6',
      purpleLight: '#A78BFA',
      purplePale: '#EDE9FE',
    },
    // ... rest of colors
  },
  spacing: {
    xs: '0.25rem',
    sm: '0.5rem',
    md: '1rem',
    lg: '1.5rem',
    xl: '2rem',
    // ... rest of spacing
  },
  typography: {
    fonts: {
      sans: 'Inter, -apple-system, sans-serif',
      mono: 'JetBrains Mono, monospace',
    },
    sizes: {
      xs: '0.75rem',
      sm: '0.875rem',
      base: '1rem',
      // ... rest of sizes
    },
  },
};
7.3 User Experience Flows
Key User Journeys
First-Time User Onboarding
Landing page → Sign up → Email verification
Welcome screen → Feature tour
Create first prompt → Organization tutorial
Dashboard with sample content
Prompt Creation Flow
Dashboard → New prompt button
Editor opens with template selection
Write/edit with live preview
Add tags and folder
Save with auto-versioning
Search and Discovery
Search bar with suggestions
Filter sidebar with facets
Results with highlighting
Quick actions on hover
Bulk operations
Navigation Structure
/                     # Landing page
/sign-in             # Authentication
/sign-up
/dashboard           # Main dashboard
/prompts             # Prompt list/grid
  /new               # Create new prompt
  /[id]              # View/edit prompt
  /templates         # Template gallery
/folders             # Folder management
/search              # Advanced search
/settings            # User settings
  /profile
  /preferences
  /billing
/admin               # Admin panel (role-based)
State Management
typescript
// stores/ui.ts
interface UIState {
  sidebar: {
    isOpen: boolean;
    activeFolder: string | null;
  };
  editor: {
    mode: 'edit' | 'preview' | 'split';
    isDirty: boolean;
    autoSaveEnabled: boolean;
  };
  search: {
    query: string;
    filters: SearchFilters;
    view: 'grid' | 'list';
  };
}

// stores/prompts.ts
interface PromptsState {
  prompts: Map<string, Prompt>;
  selected: Set<string>;
  sortBy: 'updated' | 'created' | 'title';
  filterBy: FilterOptions;
}
8. Infrastructure & Deployment
8.1 Infrastructure Requirements
Hosting Environment
Platform: Vercel (serverless)
Regions: Auto-scaled globally via Vercel Edge Network
Environment: Node.js 20.x runtime
Server Requirements
Compute: Serverless functions with 10s default timeout
Memory: 1024MB per function (configurable up to 3008MB)
Concurrent Executions: 1000 (Vercel Pro plan)
Network Architecture
CDN: Vercel Edge Network for static assets
API Routes: Serverless functions at edge locations
Database Connection: Direct connection to Supabase
WebSockets: Not required for MVP
Storage Requirements
Database Storage:
Initial: 8GB (Supabase free tier)
Growth projection: ~1GB per 10,000 active users
Scaling: Automatic with Supabase Pro
File Storage:
Vercel Blob for future attachments
1GB included, $0.03/GB additional
Build Artifacts:
Vercel handles automatically
Retained for 90 days
8.2 Deployment Strategy
CI/CD Pipeline
yaml
# .github/workflows/deploy.yml
name: Deploy to Vercel

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '20'
          cache: 'npm'
      
      - run: npm ci
      - run: npm run lint
      - run: npm run type-check
      - run: npm run test
      
      # Database migrations check
      - run: npx prisma validate
      - run: npx prisma generate
  
  deploy-preview:
    needs: test
    if: github.event_name == 'pull_request'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: amondnet/vercel-action@v20
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
  
  deploy-production:
    needs: test
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      # Run migrations
      - run: npx prisma migrate deploy
        env:
          DATABASE_URL: ${{ secrets.DATABASE_URL }}
      
      # Deploy to Vercel
      - uses: amondnet/vercel-action@v20
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          vercel-args: '--prod'
Environment Management
typescript
// env.mjs - Runtime environment validation
import { z } from 'zod';

const envSchema = z.object({
  // Database
  DATABASE_URL: z.string().url(),
  
  // Authentication
  CLERK_SECRET_KEY: z.string(),
  CLERK_WEBHOOK_SECRET: z.string(),
  NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY: z.string(),
  
  // Application
  NEXT_PUBLIC_APP_URL: z.string().url(),
  ENCRYPTION_KEY: z.string().length(64), // 32 bytes hex
  
  // External Services
  SENTRY_DSN: z.string().url().optional(),
  VERCEL_ENV: z.enum(['development', 'preview', 'production']),
});

export const env = envSchema.parse(process.env);
Deployment Procedures
Development Workflow
 bash

# Local development
npm run dev

# Run migrations
npm run db:migrate

# Type checking
npm run type-check

# Testing
npm run test



Staging Deployment
Push to develop branch
Automatic deployment to staging-[project].vercel.app
Run E2E tests against staging
Manual QA verification
Production Deployment
Merge PR to main branch
Automated tests run
Database migrations applied
Deployment to production
Monitor error rates and performance
Rollback Strategy
bash
# Instant rollback via Vercel
vercel rollback [
Retry
S
Continue
Edit
Rollback Strategy (continued)
bash
# Instant rollback via Vercel
vercel rollback [deployment-url]

# Database rollback
npx prisma migrate resolve --rolled-back [migration-name]

# Feature flag rollback (future)
# Disable feature via environment variable without redeploy
Configuration Management
typescript
// config/index.ts
export const config = {
  app: {
    name: 'AI Prompt Manager',
    url: env.NEXT_PUBLIC_APP_URL,
    version: process.env.NEXT_PUBLIC_VERCEL_GIT_COMMIT_SHA || 'dev',
  },
  features: {
    templateSharing: process.env.FEATURE_TEMPLATE_SHARING === 'true',
    aiSuggestions: process.env.FEATURE_AI_SUGGESTIONS === 'true',
    collaboration: process.env.FEATURE_COLLABORATION === 'true',
  },
  limits: {
    maxPromptsPerUser: 1000,
    maxFolderDepth: 10,
    maxTagsPerPrompt: 20,
    maxFileSize: 5 * 1024 * 1024, // 5MB
  },
  cache: {
    promptTTL: 5 * 60 * 1000, // 5 minutes
    folderTTL: 10 * 60 * 1000, // 10 minutes
    searchTTL: 60 * 1000, // 1 minute
  },
};
9. Performance & Monitoring
9.1 Performance Optimization
Frontend Optimizations
typescript
// next.config.js
const nextConfig = {
  images: {
    domains: ['img.clerk.com'],
    formats: ['image/avif', 'image/webp'],
  },
  experimental: {
    optimizeCss: true,
    optimizePackageImports: ['lucide-react', 'date-fns'],
  },
  compiler: {
    removeConsole: process.env.NODE_ENV === 'production',
  },
};

// Dynamic imports for code splitting
const Editor = dynamic(() => import('@/components/editor'), {
  loading: () => <EditorSkeleton />,
  ssr: false,
});

// Image optimization
import Image from 'next/image';

// Font optimization
import { Inter } from 'next/font/google';
const inter = Inter({ 
  subsets: ['latin'],
  display: 'swap',
  variable: '--font-inter',
});
Database Optimizations
sql
-- Indexes for performance
CREATE INDEX idx_prompts_user_folder ON prompts(user_id, folder_id);
CREATE INDEX idx_prompts_created ON prompts(created_at DESC);
CREATE INDEX idx_prompts_search ON prompts USING GIN(to_tsvector('english', title || ' ' || content));
CREATE INDEX idx_folders_user_parent ON folders(user_id, parent_id);
CREATE INDEX idx_tags_user_usage ON tags(user_id, usage_count DESC);

-- Materialized view for folder statistics
CREATE MATERIALIZED VIEW folder_stats AS
SELECT 
  f.id,
  f.user_id,
  COUNT(p.id) as prompt_count,
  MAX(p.updated_at) as last_activity
FROM folders f
LEFT JOIN prompts p ON f.id = p.folder_id
GROUP BY f.id, f.user_id;

-- Refresh periodically
CREATE OR REPLACE FUNCTION refresh_folder_stats()
RETURNS void AS $$
BEGIN
  REFRESH MATERIALIZED VIEW CONCURRENTLY folder_stats;
END;
$$ LANGUAGE plpgsql;
Caching Strategy
typescript
// React Query cache configuration
export const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 5 * 60 * 1000, // 5 minutes
      cacheTime: 10 * 60 * 1000, // 10 minutes
      refetchOnWindowFocus: false,
      retry: (failureCount, error: any) => {
        if (error?.status === 404) return false;
        return failureCount < 3;
      },
    },
  },
});

// Prefetching
export async function prefetchUserData() {
  await queryClient.prefetchQuery({
    queryKey: ['user', 'profile'],
    queryFn: getUserProfile,
  });
  
  await queryClient.prefetchQuery({
    queryKey: ['folders', 'tree'],
    queryFn: getFolderTree,
  });
}
9.2 Monitoring & Analytics
Application Monitoring
typescript
// app/layout.tsx
import { Analytics } from '@vercel/analytics/react';
import { SpeedInsights } from '@vercel/speed-insights/next';

export default function RootLayout({ children }) {
  return (
    <html>
      <body>
        {children}
        <Analytics />
        <SpeedInsights />
      </body>
    </html>
  );
}

// Error tracking with Sentry
import * as Sentry from '@sentry/nextjs';

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  environment: process.env.VERCEL_ENV,
  tracesSampleRate: 0.1,
  integrations: [
    new Sentry.BrowserTracing(),
    new Sentry.Replay({
      maskAllText: true,
      blockAllMedia: true,
    }),
  ],
});
Performance Metrics
typescript
// lib/metrics.ts
export function trackPerformance(metric: string, value: number) {
  // Send to analytics
  if (window.gtag) {
    window.gtag('event', 'timing_complete', {
      name: metric,
      value: Math.round(value),
      event_category: 'Performance',
    });
  }
  
  // Log to console in development
  if (process.env.NODE_ENV === 'development') {
    console.log(`Performance: ${metric} = ${value}ms`);
  }
}

// Usage
const startTime = performance.now();
await searchPrompts(query);
trackPerformance('search_duration', performance.now() - startTime);
Health Checks
typescript
// app/api/health/route.ts
export async function GET() {
  const checks = {
    status: 'healthy',
    timestamp: new Date().toISOString(),
    version: process.env.NEXT_PUBLIC_VERCEL_GIT_COMMIT_SHA,
    checks: {
      database: 'unknown',
      auth: 'unknown',
    },
  };
  
  try {
    // Check database
    await prisma.$queryRaw`SELECT 1`;
    checks.checks.database = 'healthy';
  } catch (error) {
    checks.checks.database = 'unhealthy';
    checks.status = 'degraded';
  }
  
  try {
    // Check auth service
    const response = await fetch('https://api.clerk.dev/v1/health');
    checks.checks.auth = response.ok ? 'healthy' : 'unhealthy';
  } catch (error) {
    checks.checks.auth = 'unhealthy';
    checks.status = 'degraded';
  }
  
  return NextResponse.json(checks);
}
10. Testing Strategy
10.1 Testing Approach
Unit Testing
typescript
// __tests__/actions/prompts.test.ts
import { createPrompt, updatePrompt } from '@/app/actions/prompts';
import { prismaMock } from '@/test/prisma-mock';

describe('Prompt Actions', () => {
  it('should create a prompt', async () => {
    const input = {
      title: 'Test Prompt',
      content: 'Test content',
      platform: 'CHATGPT',
    };
    
    prismaMock.prompt.create.mockResolvedValue({
      id: '1',
      ...input,
      userId: 'user-1',
      createdAt: new Date(),
      updatedAt: new Date(),
    });
    
    const result = await createPrompt(input);
    
    expect(result).toHaveProperty('id');
    expect(result.title).toBe(input.title);
  });
});
Integration Testing
typescript
// __tests__/integration/search.test.ts
import { POST } from '@/app/api/search/route';

describe('Search Integration', () => {
  it('should return search results', async () => {
    const request = new Request('http://localhost/api/search', {
      method: 'POST',
      body: JSON.stringify({
        query: 'test prompt',
        filters: { platform: 'CHATGPT' },
      }),
    });
    
    const response = await POST(request);
    const data = await response.json();
    
    expect(response.status).toBe(200);
    expect(data).toHaveProperty('results');
    expect(data).toHaveProperty('total');
  });
});
E2E Testing
typescript
// e2e/prompt-creation.spec.ts
import { test, expect } from '@playwright/test';

test.describe('Prompt Creation', () => {
  test('should create and save a new prompt', async ({ page }) => {
    // Login
    await page.goto('/sign-in');
    await page.fill('[name="email"]', 'test@example.com');
    await page.fill('[name="password"]', 'password');
    await page.click('button[type="submit"]');
    
    // Navigate to new prompt
    await page.goto('/prompts/new');
    
    // Fill prompt details
    await page.fill('[name="title"]', 'Test Prompt');
    await page.fill('[name="content"]', 'This is a test prompt');
    
    // Save
    await page.click('button:has-text("Save")');
    
    // Verify redirect and success
    await expect(page).toHaveURL(/\/prompts\/[\w-]+$/);
    await expect(page.locator('text=Prompt saved')).toBeVisible();
  });
});
10.2 Quality Assurance
Code Quality Tools
json
// package.json scripts
{
  "scripts": {
    "lint": "next lint",
    "lint:fix": "next lint --fix",
    "type-check": "tsc --noEmit",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "test:e2e": "playwright test",
    "analyze": "ANALYZE=true next build"
  }
}
Pre-commit Hooks
json
// .husky/pre-commit
#!/bin/sh
. "$(dirname "$0")/_/husky.sh"

npm run lint
npm run type-check
npm run test -- --passWithNoTests
Performance Budget
javascript
// lighthouse.config.js
module.exports = {
  ci: {
    collect: {
      url: ['http://localhost:3000/'],
      numberOfRuns: 3,
    },
    assert: {
      assertions: {
        'categories:performance': ['error', { minScore: 0.9 }],
        'categories:accessibility': ['error', { minScore: 0.95 }],
        'categories:best-practices': ['error', { minScore: 0.9 }],
        'categories:seo': ['error', { minScore: 0.9 }],
        'first-contentful-paint': ['error', { maxNumericValue: 2000 }],
        'largest-contentful-paint': ['error', { maxNumericValue: 3000 }],
        'cumulative-layout-shift': ['error', { maxNumericValue: 0.1 }],
        'total-blocking-time': ['error', { maxNumericValue: 300 }],
      },
    },
  },
};
11. Future Considerations
11.1 Scalability Planning
Database Scaling
Implement read replicas for search queries
Partition prompts table by user_id
Archive old versions to cold storage
Implement connection pooling with pgBouncer
Application Scaling
Implement Redis for session storage
Add CDN for static assets
Implement queue system for heavy operations
Add WebSocket support for real-time features
11.2 Feature Roadmap
Phase 2 Features
AI-powered prompt suggestions
Collaborative editing
Public prompt marketplace
API access for developers
Mobile applications
Phase 3 Features
Advanced analytics dashboard
Team workspaces
Custom AI model integration
Prompt performance tracking
Export to various AI platforms
12. Project Structure
ai-prompt-manager/
├── app/                      # Next.js App Router
│   ├── (auth)/              # Auth group routes
│   │   ├── sign-in/
│   │   └── sign-up/
│   ├── (dashboard)/         # Dashboard group routes
│   │   ├── layout.tsx       # Dashboard layout
│   │   ├── page.tsx         # Dashboard home
│   │   ├── prompts/
│   │   │   ├── page.tsx     # Prompts list
│   │   │   ├── new/
│   │   │   └── [id]/
│   │   ├── folders/
│   │   ├── search/
│   │   └── settings/
│   ├── api/                 # API routes
│   │   ├── webhooks/
│   │   └── health/
│   ├── actions/             # Server Actions
│   │   ├── auth.ts
│   │   ├── prompts.ts
│   │   ├── folders.ts
│   │   └── search.ts
│   └── globals.css
├── components/              # React components
│   ├── ui/                  # Base UI components
│   ├── features/            # Feature components
│   └── layouts/             # Layout components
├── lib/                     # Utilities
│   ├── prisma.ts
│   ├── auth.ts
│   ├── validation.ts
│   └── utils.ts
├── hooks/                   # Custom React hooks
├── stores/                  # Zustand stores
├── types/                   # TypeScript types
├── prisma/                  # Database
│   ├── schema.prisma
│   └── migrations/
├── public/                  # Static assets
├── tests/                   # Test files
└── config/                  # Configuration



</tech-specification>
<project-rules>---
description: This rule explains Next.js conventions and best practices for fullstack development.
globs: **/*.js,**/*.jsx,**/*.ts,**/*.tsx
alwaysApply: false
---

# Next.js rules

- Use the App Router structure with `page.tsx` files in route directories.
- Client components must be explicitly marked with `'use client'` at the top of the file.
- Use kebab-case for directory names (e.g., `components/auth-form`) and PascalCase for component files.
- Prefer named exports over default exports, i.e. `export function Button() { /* ... */ }` instead of `export default function Button() { /* ... */ }`.
- Minimize `'use client'` directives:
  - Keep most components as React Server Components (RSC)
  - Only use client components when you need interactivity and wrap in `Suspense` with fallback UI
  - Create small client component wrappers around interactive elements
- Avoid unnecessary `useState` and `useEffect` when possible:
  - Use server components for data fetching
  - Use React Server Actions for form handling
  - Use URL search params for shareable state
- Use `nuqs` for URL search param state management
</project-rules>
<core-app-intent>
Elevator Pitch
A centralized prompt management platform that transforms scattered AI prompts into an organized, searchable, and shareable knowledge base - think "GitHub for prompts" where users can version, collaborate, and monetize their best AI interactions.
Problem Statement
AI users repeatedly lose valuable prompts across multiple platforms (ChatGPT, Claude, Midjourney, etc.), struggle to find and reuse their best work, and lack ways to collaborate or learn from others' proven prompts. This leads to duplicated effort, inconsistent results, and missed opportunities for knowledge sharing.
Target Audience
Primary: Power users of AI tools (developers, content creators, researchers) who use prompts daily
Secondary: Teams collaborating on AI projects who need standardized prompts
Tertiary: Prompt engineers looking to monetize their expertise
USP
Unlike simple note-taking apps or platform-specific histories, we provide a dedicated prompt management system with version control, advanced formatting support (Markdown/XML), collaboration features, and cross-platform compatibility - making prompts as manageable as code.
Target Platforms
Web application (responsive design)
Browser extension for quick capture
Mobile apps (iOS/Android) for on-the-go access
API for third-party integrations
Features List
Authentication & User Management
User registration with email verification
OAuth integration (Google, GitHub, Microsoft)
Password reset functionality
Profile management and settings
Prompt Organization
Create folder/tag hierarchy for organization
Nested folders with drag-and-drop
Multiple tags per prompt
Smart collections based on rules
Search across all prompts with filters
Full-text search
Filter by platform, date, tags, author
Search within results
Prompt Creation & Editing
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
Sharing & Collaboration
Privacy settings (private, unlisted, public)
Share via unique links
Team workspaces
Role-based permissions
Shared folders
Comments and annotations
Fork and remix public prompts
Import/Export & Integrations
Import from ChatGPT/Claude exports
Browser extension for quick capture
Export to various formats (JSON, Markdown, PDF)
API for programmatic access
UX/UI Considerations
Dashboard Screen
Recent prompts carousel
Quick actions (new prompt, import)
Usage statistics
Search bar prominently placed
Prompt Editor
Split-screen editor/preview
Collapsible sidebar for organization
Floating toolbar for formatting
Auto-save with status indicator
Browse/Discover Screen
Grid/list view toggle
Infinite scroll with lazy loading
Preview on hover
Quick actions (save, fork, share)
Mobile Optimization
Swipe gestures for navigation
Simplified editor for mobile
Offline mode with sync
Non-Functional Requirements
Performance
Sub-second search results
Instant preview rendering
Optimistic UI updates
Scalability
Support 10k+ prompts per user
Handle concurrent editing in teams
CDN for static assets
Security
End-to-end encryption option
API rate limiting
Regular security audits
GDPR compliance
Accessibility
WCAG 2.1 AA compliance
Keyboard navigation
Screen reader support
Monetization
Freemium Model:
Free: 100 prompts, basic features
Pro ($9/mo): Unlimited prompts, version control, API access
Team ($19/user/mo): Collaboration features, admin controls
Marketplace: Commission on premium prompt sales
Enterprise: Custom pricing for API access and white-label solutions




</core-app-intent>
</context>

