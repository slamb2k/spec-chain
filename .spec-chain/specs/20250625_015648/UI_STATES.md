# UI States & Screen Snapshots: BIG Live Portal

## Overview
This document provides comprehensive UI state specifications for BIG Live Portal, a browser-based web application designed for performing arts organizations to manage artist contracts, expenses, and schedules. The UI states cover all user interactions across authentication, contract management, expense tracking, schedule viewing, and administrative functions, with a focus on mobile-first design and accessibility.

## Design Principles for States
- **Bold Simplicity**: Clean interfaces with clear visual hierarchy and minimal cognitive load
- **Mobile-First Responsiveness**: Touch-optimized interactions that scale gracefully to desktop
- **Accessibility-Driven**: WCAG 2.1 AA compliant with full keyboard navigation and screen reader support
- **Performance-Conscious**: Fast loading states and offline capabilities for touring artists
- **Error Prevention**: Clear validation and helpful guidance to prevent user mistakes
- **Consistent Feedback**: Immediate visual confirmation for all user actions

## Features & States

### Authentication & Access Management

#### Login Screen

##### Initial State
**Context:** First point of entry for all users, supporting both artist personal emails and admin SharePoint SSO

**Visual Description:**
- **Layout:** Centered card (480px max-width) on #F5F5F5 background with BIG Live Portal logo
- **Colors:** White card (#FFFFFF) with #E0E0E0 border, #1976D2 primary button
- **Typography:** H1 "Welcome Back" (32px/40px Semibold), Body text (16px/24px Regular)
- **Components:** Email input field, password field with show/hide toggle, "Sign In" primary button
- **Spacing:** 32px card padding, 24px between form elements, 16px between fields

**Interactive Elements:**
- **Primary Actions:** "Sign In" button (#1976D2 background, 44px height)
- **Secondary Actions:** "Forgot Password?" link (#1976D2 text), "Admin Login with SharePoint" ghost button
- **Navigation:** None (entry point)
- **Form Elements:** Email field with email keyboard type, password field with visibility toggle

**Animations & Transitions:**
- **Entry Animation:** Fade in 400ms cubic-bezier(0.0, 0.0, 0.2, 1)
- **Micro-interactions:** Input focus border animation 200ms, button hover shadow increase
- **Loading Indicators:** Button text replaced with spinner on submit
- **Transition Out:** Fade out 300ms to dashboard

**Responsive Behavior:**
- **Desktop (1200px+):** Centered card with decorative side imagery
- **Tablet (768px-1199px):** Centered card with reduced padding
- **Mobile (320px-767px):** Full-width card with 16px margin

**Accessibility Considerations:**
- **Focus States:** 2px solid #1976D2 outline with 2px offset
- **Screen Reader:** "Login form" landmark, descriptive labels for all fields
- **Color Contrast:** All text meets 4.5:1 ratio against backgrounds
- **Touch Targets:** All interactive elements minimum 44px × 44px

##### Loading State
**Context:** After user submits credentials, during authentication process

**Visual Description:**
- **Layout:** Same layout with disabled form elements
- **Loading Indicators:** Primary button shows circular spinner, form fields disabled
- **Disabled Elements:** All inputs and buttons disabled with opacity 0.6
- **Skeleton Screens:** N/A for login

**User Feedback:**
- **Progress Indication:** Spinner in button with "Signing in..." text
- **Time Expectations:** Average 1-2 seconds
- **Cancellation Options:** None during authentication

**Performance Considerations:**
- **Perceived Performance:** Immediate button state change on click
- **Progressive Loading:** Dashboard pre-fetching starts during auth
- **Error Handling:** Timeout after 10 seconds with retry option

##### Success State
**Context:** Authentication successful, transitioning to appropriate dashboard

**Visual Description:**
- **Success Indicators:** Brief checkmark animation in button
- **Color Changes:** Button briefly shows #4CAF50 success color
- **Icon Usage:** Checkmark icon replaces spinner
- **Message Display:** "Success! Redirecting..." below button

**Next Actions:**
- **Primary Next Steps:** Automatic redirect to role-appropriate dashboard
- **Secondary Options:** N/A - automatic progression
- **Auto-transitions:** 500ms delay then fade to dashboard

##### Error State
**Context:** Invalid credentials, account locked, or system error

**Visual Description:**
- **Error Indicators:** Red border on relevant fields, error message below
- **Color Treatment:** #F44336 for error text and field borders
- **Message Styling:** Error icon + message in red below form
- **Affected Elements:** Specific field(s) with errors highlighted

**Error Recovery:**
- **Retry Options:** Form remains active for immediate retry
- **Alternative Paths:** "Forgot Password?" link prominent
- **Help Resources:** "Contact Support" link in error message

**Error Prevention:**
- **Validation:** Email format validation on blur
- **Confirmation:** N/A for login
- **Clear Instructions:** Helper text appears on focus

#### Password Reset Flow

##### Initial State - Request Reset
**Context:** User clicked "Forgot Password?" from login screen

**Visual Description:**
- **Layout:** Modal overlay (600px max-width) with semi-transparent backdrop
- **Colors:** White modal with standard form styling
- **Typography:** H2 "Reset Your Password" (24px/32px Semibold)
- **Components:** Email input, "Send Reset Link" primary button, "Cancel" ghost button
- **Spacing:** 32px modal padding, standard form spacing

**Interactive Elements:**
- **Primary Actions:** "Send Reset Link" button
- **Secondary Actions:** "Cancel" returns to login
- **Navigation:** Close button (X) in top-right
- **Form Elements:** Single email input field

**Animations & Transitions:**
- **Entry Animation:** Modal slides up with fade 300ms
- **Micro-interactions:** Standard form interactions
- **Loading Indicators:** Button spinner during submission
- **Transition Out:** Fade out on success or cancel

##### Success State - Email Sent
**Context:** Reset email successfully sent to user

**Visual Description:**
- **Success Indicators:** Green checkmark icon, success message
- **Color Changes:** #4CAF50 accent color for success elements
- **Icon Usage:** Large checkmark icon (48px)
- **Message Display:** "Check your email" with instructions

**Next Actions:**
- **Primary Next Steps:** "Return to Login" button
- **Secondary Options:** "Resend Email" link (after 60s)
- **Auto-transitions:** Modal closes after 10s

### Contract Management

#### Contract Dashboard (Admin View)

##### Initial State
**Context:** Admin accessing contract management section

**Visual Description:**
- **Layout:** Full-width layout with sidebar navigation, main content area with action bar
- **Colors:** White background, gray sidebar (#F5F5F5), blue accents
- **Typography:** H1 "Contracts" (32px), data table with Body text (16px)
- **Components:** Search bar, filter chips, data table, "Upload Contracts" button
- **Spacing:** 24px page padding, 16px between elements

**Interactive Elements:**
- **Primary Actions:** "Upload Contracts" button (top-right)
- **Secondary Actions:** Bulk select checkboxes, row actions (view, assign, delete)
- **Navigation:** Sidebar with active "Contracts" item highlighted
- **Form Elements:** Search input, date range picker, status filter dropdown

**Responsive Behavior:**
- **Desktop (1200px+):** Full table view with all columns visible
- **Tablet (768px-1199px):** Condensed table, some columns hidden
- **Mobile (320px-767px):** Card-based list view instead of table

##### Upload State
**Context:** Admin uploading one or more contracts

**Visual Description:**
- **Layout:** Modal overlay with drag-drop zone
- **Loading Indicators:** Progress bar for each file, overall progress
- **Disabled Elements:** Other page elements dimmed
- **Skeleton Screens:** N/A

**User Feedback:**
- **Progress Indication:** Individual file progress bars
- **Time Expectations:** Speed indicator (MB/s)
- **Cancellation Options:** Cancel button per file and overall

##### Assignment State
**Context:** Admin assigning contracts to artists

**Visual Description:**
- **Layout:** Side panel slides in from right (480px wide)
- **Colors:** White panel with standard form elements
- **Typography:** H3 "Assign Contract" with form labels
- **Components:** Artist multi-select, email template preview, send button

**Interactive Elements:**
- **Primary Actions:** "Send to Artists" button
- **Secondary Actions:** "Preview Email", "Save as Template"
- **Navigation:** Close (X) button, breadcrumb showing contract name
- **Form Elements:** Searchable artist dropdown, email customization fields

#### Contract View (Artist Mobile)

##### Initial State
**Context:** Artist viewing assigned contract on mobile device

**Visual Description:**
- **Layout:** Full-screen document viewer with floating action bar
- **Colors:** White background, blue action buttons
- **Typography:** Document rendered at readable size with pinch-to-zoom
- **Components:** Document viewer, zoom controls, "Sign Contract" floating button
- **Spacing:** Edge-to-edge document, 16px padding for controls

**Interactive Elements:**
- **Primary Actions:** "Sign Contract" floating action button
- **Secondary Actions:** Download, zoom controls
- **Navigation:** Back arrow to contract list
- **Form Elements:** None in view mode

**Animations & Transitions:**
- **Entry Animation:** Slide in from right 300ms
- **Micro-interactions:** Smooth pinch-to-zoom, momentum scrolling
- **Loading Indicators:** Document skeleton while loading
- **Transition Out:** Slide out to left

##### Signing State
**Context:** Artist in e-signature flow via integrated service

**Visual Description:**
- **Layout:** Embedded signature interface from DocuSign/Adobe Sign
- **Colors:** Provider's signature UI with BIG Live Portal header
- **Typography:** Provider's standard signing interface
- **Components:** Signature pad/type selector, navigation buttons

**Interactive Elements:**
- **Primary Actions:** "Sign" / "Initial" / "Date" fields
- **Secondary Actions:** "Decline to Sign" option
- **Navigation:** Step indicator for multi-page documents
- **Form Elements:** Signature capture (draw/type/upload)

**Accessibility Considerations:**
- **Focus States:** Tab through signature fields
- **Screen Reader:** Full document text available
- **Color Contrast:** High contrast mode available
- **Touch Targets:** Large signature areas for mobile

##### Completion State
**Context:** Contract successfully signed and filed

**Visual Description:**
- **Success Indicators:** Full-screen success message with confetti animation
- **Color Changes:** #4CAF50 success theme
- **Icon Usage:** Large checkmark with circular progress completion
- **Message Display:** "Contract Signed Successfully!"

**Next Actions:**
- **Primary Next Steps:** "Download Copy" and "View All Contracts"
- **Secondary Options:** "Share" button for sending to personal email
- **Auto-transitions:** Returns to contract list after 5s

### Expense Management

#### Expense Submission (Mobile)

##### Initial State
**Context:** Artist creating new expense claim on mobile

**Visual Description:**
- **Layout:** Full-screen form with camera button prominent
- **Colors:** White background, #7B1FA2 purple accent for artist features
- **Typography:** H2 "New Expense" with clear form labels
- **Components:** Camera capture button, form fields, receipt preview area
- **Spacing:** 16px padding, optimized for thumb reach

**Interactive Elements:**
- **Primary Actions:** Large camera button for receipt capture
- **Secondary Actions:** "Upload from Gallery" option
- **Navigation:** Cancel (X) saves draft and returns
- **Form Elements:** Date picker, amount input (number pad), category dropdown

**Animations & Transitions:**
- **Entry Animation:** Slide up from bottom 300ms
- **Micro-interactions:** Field auto-advance, smooth keyboard transitions
- **Loading Indicators:** Image processing spinner
- **Transition Out:** Slide down on submit/cancel

**Responsive Behavior:**
- **Desktop (1200px+):** Side-by-side receipt and form
- **Tablet (768px-1199px):** Stacked layout with larger form
- **Mobile (320px-767px):** Single column, camera-first

##### Receipt Capture State
**Context:** Using device camera to photograph receipt

**Visual Description:**
- **Layout:** Full-screen camera view with capture controls
- **Colors:** Dark overlay with white controls
- **Typography:** Minimal text, icon-based UI
- **Components:** Camera viewfinder, capture button, flash toggle, gallery access

**Interactive Elements:**
- **Primary Actions:** Large capture button (72px)
- **Secondary Actions:** Flash, switch camera, gallery
- **Navigation:** Cancel returns to form
- **Form Elements:** None - camera interface only

**User Feedback:**
- **Progress Indication:** Capture animation and processing
- **Time Expectations:** 2-3s for image optimization
- **Cancellation Options:** Cancel returns with draft saved

##### Processing State
**Context:** Receipt image being enhanced and prepared

**Visual Description:**
- **Layout:** Full-screen with receipt preview and enhancement status
- **Loading Indicators:** Progress bar with "Enhancing image..." text
- **Disabled Elements:** Form fields disabled during processing
- **Skeleton Screens:** Receipt area shows animated placeholder

**Performance Considerations:**
- **Perceived Performance:** Immediate preview with progressive enhancement
- **Progressive Loading:** Low-res preview → enhanced version
- **Error Handling:** Retry option if enhancement fails

##### Form Completion State
**Context:** All required expense information entered

**Visual Description:**
- **Layout:** Scrollable form with receipt thumbnail at top
- **Colors:** Green checkmarks next to completed fields
- **Typography:** Clear labels with helper text for complex fields
- **Components:** Validated form fields, receipt preview, submit button

**Interactive Elements:**
- **Primary Actions:** "Submit Expense" button (fixed bottom)
- **Secondary Actions:** "Save as Draft" option
- **Navigation:** Back saves draft automatically
- **Form Elements:** All fields with appropriate keyboards

##### Submission Success State
**Context:** Expense successfully submitted for approval

**Visual Description:**
- **Success Indicators:** Full-screen success with expense ID
- **Color Changes:** #4CAF50 success green throughout
- **Icon Usage:** Animated checkmark with circular progress
- **Message Display:** "Expense Submitted" with reference number

**Next Actions:**
- **Primary Next Steps:** "Submit Another" or "View All Expenses"
- **Secondary Options:** "Track Status" link
- **Auto-transitions:** Returns to expense list after 3s

#### Expense Approval Queue (Desktop Admin)

##### Initial State
**Context:** Finance manager reviewing pending expenses

**Visual Description:**
- **Layout:** Split view with queue list left, detail panel right
- **Colors:** Priority indicators (red/yellow/green), neutral backgrounds
- **Typography:** H1 "Expense Approvals" with data table styling
- **Components:** Filterable queue list, detailed expense view, action buttons
- **Spacing:** Dense information layout with clear separation

**Interactive Elements:**
- **Primary Actions:** "Approve" and "Reject" buttons per expense
- **Secondary Actions:** Bulk selection, export, filters
- **Navigation:** Keyboard shortcuts for power users (A=approve, R=reject)
- **Form Elements:** Comment field for rejections, amount adjustment

**Animations & Transitions:**
- **Entry Animation:** Queue items slide in staggered
- **Micro-interactions:** Row highlight on hover, smooth panel transitions
- **Loading Indicators:** Inline spinners for individual actions
- **Transition Out:** Approved items fade out gracefully

##### Bulk Processing State
**Context:** Processing multiple expenses simultaneously

**Visual Description:**
- **Layout:** Modal overlay showing batch progress
- **Loading Indicators:** Progress bar with count (X of Y processed)
- **Disabled Elements:** Background interface locked
- **Skeleton Screens:** N/A - modal progress view

**User Feedback:**
- **Progress Indication:** Real-time counter and percentage
- **Time Expectations:** ~2s per expense shown
- **Cancellation Options:** "Stop Processing" halts queue

### Schedule Management

#### Personal Schedule View (Mobile)

##### Initial State - Day View
**Context:** Artist checking today's schedule on mobile

**Visual Description:**
- **Layout:** Full-width timeline with current time indicator
- **Colors:** #00796B teal for events, color coding by type
- **Typography:** H2 for date, Body for event details
- **Components:** Timeline, event cards, floating date picker
- **Spacing:** Edge-to-edge timeline, 16px card margins

**Interactive Elements:**
- **Primary Actions:** Tap event for details, swipe between days
- **Secondary Actions:** View switcher (day/week/month)
- **Navigation:** Bottom nav bar with schedule icon active
- **Form Elements:** None - read-only view

**Animations & Transitions:**
- **Entry Animation:** Events slide in from bottom staggered
- **Micro-interactions:** Haptic feedback on swipe, smooth scrolling
- **Loading Indicators:** Skeleton events while loading
- **Transition Out:** Swipe transitions between days

**Responsive Behavior:**
- **Desktop (1200px+):** Multi-day week view default
- **Tablet (768px-1199px):** 3-day view with sidebar
- **Mobile (320px-767px):** Single day focus with swipe

##### Event Detail State
**Context:** Artist viewing specific event details

**Visual Description:**
- **Layout:** Bottom sheet modal (mobile) with event information
- **Colors:** Event type color as header accent
- **Typography:** H3 event title, Body for details, Caption for metadata
- **Components:** Map preview, participant list, venue details, notes

**Interactive Elements:**
- **Primary Actions:** "Get Directions" and "Add to Calendar"
- **Secondary Actions:** "Contact Venue", participant contact links
- **Navigation:** Swipe down to dismiss, X button
- **Form Elements:** Personal notes field (optional)

##### Schedule Update Notification State
**Context:** Important schedule change requiring acknowledgment

**Visual Description:**
- **Layout:** Full-screen priority notification
- **Colors:** #F57C00 admin orange for urgent updates
- **Typography:** H2 "Schedule Update" with change details
- **Components:** Before/after comparison, acknowledge button

**Interactive Elements:**
- **Primary Actions:** "Acknowledge Update" button
- **Secondary Actions:** "View Full Schedule" link
- **Navigation:** Cannot dismiss without acknowledging
- **Form Elements:** Optional comment field

**User Feedback:**
- **Progress Indication:** Button state change on acknowledge
- **Time Expectations:** Immediate confirmation
- **Cancellation Options:** None - must acknowledge

### Administrative Functions

#### Admin Dashboard

##### Initial State
**Context:** Administrator's command center showing system overview

**Visual Description:**
- **Layout:** Grid of metric cards, activity feed, quick actions
- **Colors:** Status colors for metrics (green=good, red=attention)
- **Typography:** H1 "Dashboard", H3 for metric titles, large numbers
- **Components:** Metric cards, charts, activity timeline, action shortcuts
- **Spacing:** 24px grid gap, 32px section spacing

**Interactive Elements:**
- **Primary Actions:** Quick action buttons for common tasks
- **Secondary Actions:** Drill-down links on metrics
- **Navigation:** Persistent sidebar with dashboard highlighted
- **Form Elements:** Date range picker for metrics

**Animations & Transitions:**
- **Entry Animation:** Cards fade in with slight scale
- **Micro-interactions:** Number animations on load
- **Loading Indicators:** Skeleton cards while data loads
- **Transition Out:** Smooth transition to detailed views

**Responsive Behavior:**
- **Desktop (1200px+):** 4-column grid layout
- **Tablet (768px-1199px):** 2-column grid
- **Mobile (320px-767px):** Single column stack

##### User Management State
**Context:** Admin adding or editing user accounts

**Visual Description:**
- **Layout:** Data table with inline editing and slide-out panel
- **Colors:** Standard form colors, role badges
- **Typography:** Standard table and form typography
- **Components:** User table, edit panel, role selector, action menu

**Interactive Elements:**
- **Primary Actions:** "Add User", "Save Changes"
- **Secondary Actions:** Bulk actions, export, deactivate
- **Navigation:** Breadcrumb: Dashboard > Users
- **Form Elements:** Standard user fields with validation

##### System Alert State
**Context:** Critical system issue requiring admin attention

**Visual Description:**
- **Layout:** Persistent banner at top of all admin pages
- **Colors:** #F44336 error red background, white text
- **Typography:** Bold alert text with clear action needed
- **Components:** Alert banner, dismiss button, action link

**Interactive Elements:**
- **Primary Actions:** Link to resolve issue
- **Secondary Actions:** Temporary dismiss (reappears on refresh)
- **Navigation:** Maintains current page context
- **Form Elements:** None - alert only

## Cross-Feature State Patterns

### Global Loading States
**Page Loading:** Full-page spinner with logo for initial load
**Component Loading:** Inline spinners maintain layout stability
**Background Processing:** Toast notifications for async operations

### Global Error Handling
**Network Errors:** Persistent banner with retry option
**Server Errors:** Full-page error with support contact
**Validation Errors:** Inline field errors with helpful messages

### Navigation States
**Active Navigation:** Bold text and accent bar for current section
**Breadcrumbs:** Click-through path for deep navigation
**Back/Forward:** Browser-native with state preservation

### Responsive Breakpoints
**Mobile First:** Core features fully functional at 320px
**Touch Interactions:** Swipe gestures for navigation
**Orientation Changes:** Graceful reflow without data loss

## Animation & Motion Guidelines

### Transition Timing
**Micro-interactions:** 150ms ease-out for small changes
**Standard Transitions:** 200ms cubic-bezier for most interactions
**Modal/Overlay:** 300ms cubic-bezier for overlays
**Page Transitions:** 400ms cubic-bezier for major changes

### Animation Patterns
**Fade Transitions:** Opacity changes for content swaps
**Slide Transitions:** Horizontal for navigation, vertical for modals
**Scale Transitions:** Subtle scale for emphasis (0.95 → 1)
**Custom Animations:** Success confetti, progress celebrations

### Performance Considerations
**Hardware Acceleration:** Transform and opacity only
**Reduced Motion:** Respect prefers-reduced-motion
**Battery Optimization:** Limit continuous animations

## Critical Questions and Clarifications

1. **Offline State Handling:** How should the UI indicate which features are available offline versus requiring connection? Should there be a persistent offline indicator or contextual warnings?

2. **Biometric Authentication:** For future mobile app versions, how should biometric login (Face ID/Touch ID) be visually integrated with the existing email/password flow?

3. **Multi-Organization Support:** If artists work with multiple organizations, how should the UI handle organization switching? Should there be a persistent org selector or account switcher?

4. **Notification Preferences:** Should notification settings be granular (per notification type) or simple (on/off)? How should the UI handle notification permission requests?

5. **Data Density Preferences:** Should admin users have the ability to switch between comfortable and compact views for data tables, or should this be responsive-only?

6. **Accessibility Modes:** Beyond standard WCAG compliance, should there be specific high-contrast or large-text modes for stage/backstage environments?

7. **Progress Tracking:** For multi-step workflows (like contract assignment), should there be a persistent progress indicator, or is the current context sufficient?

8. **Error Recovery:** For critical errors (like failed expense submissions), should the system automatically retry, or always require user intervention?

9. **Customization Depth:** How much should organizations be able to customize the UI (colors, logos) while maintaining usability and brand recognition?

10. **Performance Indicators:** Should the UI show performance metrics (like sync status, connection speed) to users, or hide this complexity?