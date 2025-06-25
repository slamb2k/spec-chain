# UI States & Screen Snapshots: BIG Live Portal

## Overview
This document provides comprehensive UI state specifications for BIG Live Portal, detailing every visual state, interaction pattern, and transition throughout the artist management platform. The states are designed following mobile-first principles with a focus on clarity, efficiency, and accessibility for performing arts professionals.

## Design Principles for States
- **Progressive Disclosure**: Complex information revealed gradually to prevent overwhelm
- **Clear Feedback**: Every user action receives immediate visual confirmation
- **Graceful Degradation**: Offline and error states maintain core functionality
- **Touch-First Design**: All interactions optimized for mobile devices with 44px minimum touch targets
- **Accessibility by Default**: WCAG 2.1 AA compliant with clear focus states and screen reader support

## Features & States

### Authentication & Onboarding

#### Login Screen

##### Initial State
**Context:** Artist or admin arrives at the platform to access their account

**Visual Description:**
- **Layout:** Centered card (max-width: 400px) on light gray background (#F5F5F5)
- **Colors:** White card background, primary blue (#1976D2) for CTA button
- **Typography:** H1 "Welcome to BIG Live Portal" (32px, 600 weight), body text (16px)
- **Components:** Email input field, password field with show/hide toggle, "Remember me" checkbox, primary login button
- **Spacing:** 24px padding inside card, 16px between form elements

**Interactive Elements:**
- **Primary Actions:** "Log In" button (full width on mobile, 120px min on desktop)
- **Secondary Actions:** "Forgot Password?" link below form, "Request Access" for new users
- **Navigation:** Logo links to marketing site
- **Form Elements:** Email field with envelope icon, password field with lock icon

**Animations & Transitions:**
- **Entry Animation:** Card fades in with subtle scale (0.95 to 1) over 300ms ease-out
- **Micro-interactions:** Input fields gain blue border on focus with 150ms transition
- **Loading Indicators:** Button shows spinner on submit, maintaining button size
- **Transition Out:** Fade to dashboard over 300ms after successful login

**Responsive Behavior:**
- **Desktop (1200px+):** Card centered with decorative background pattern
- **Tablet (768px-1199px):** Card takes 80% width, larger spacing
- **Mobile (320px-767px):** Full-width card with no margin, simplified layout

**Accessibility Considerations:**
- **Focus States:** 2px solid blue outline with 2px offset on all interactive elements
- **Screen Reader:** Form properly labeled, error messages announced
- **Color Contrast:** All text meets 4.5:1 ratio, buttons meet 3:1
- **Touch Targets:** Minimum 44x44px for all clickable elements

##### Loading State
**Context:** System validates credentials after user submits login form

**Visual Description:**
- **Layout:** Form inputs disabled with reduced opacity (0.6)
- **Loading Indicators:** Spinner icon replacing text in login button
- **Disabled Elements:** All form fields show disabled cursor, gray background
- **Skeleton Screens:** N/A for login process

**User Feedback:**
- **Progress Indication:** Spinner animation at 60fps
- **Time Expectations:** "Logging you in..." text appears after 2 seconds
- **Cancellation Options:** ESC key or click outside cancels request

**Performance Considerations:**
- **Perceived Performance:** Button responds immediately with loading state
- **Progressive Loading:** Dashboard starts loading in background
- **Error Handling:** Timeout after 30 seconds with retry option

##### Success State
**Context:** Valid credentials authenticated, transitioning to dashboard

**Visual Description:**
- **Success Indicators:** Checkmark icon briefly replaces spinner (300ms)
- **Color Changes:** Button turns success green (#4CAF50) momentarily
- **Icon Usage:** White checkmark in circle
- **Message Display:** "Success! Redirecting..." below button

**Next Actions:**
- **Primary Next Steps:** Automatic redirect to dashboard
- **Secondary Options:** N/A - automatic transition
- **Auto-transitions:** 500ms delay before dashboard transition

##### Error State
**Context:** Invalid credentials, account locked, or system error

**Visual Description:**
- **Error Indicators:** Red border on relevant fields, shake animation
- **Color Treatment:** Error red (#F44336) for borders and messages
- **Message Styling:** Error message appears below form with error icon
- **Affected Elements:** Specific field(s) highlighted based on error type

**Error Recovery:**
- **Retry Options:** Form re-enabled immediately for retry
- **Alternative Paths:** "Forgot Password?" link highlighted
- **Help Resources:** "Contact Support" link in error message

**Error Prevention:**
- **Validation:** Email format validated on blur
- **Confirmation:** Password visibility toggle to prevent typos
- **Clear Instructions:** Password requirements shown on focus

#### Registration Flow

##### Invitation Landing State
**Context:** Artist clicks invitation link from email to create account

**Visual Description:**
- **Layout:** Two-column layout on desktop (invitation details left, form right)
- **Colors:** Organization branding in header, standard form styling
- **Typography:** H1 "You're invited to join [Organization]" with welcoming message
- **Components:** Pre-filled email field (if provided), name fields, password creation
- **Spacing:** Generous 32px padding, clear visual hierarchy

**Interactive Elements:**
- **Primary Actions:** "Create Account" button at bottom of form
- **Secondary Actions:** "Already have an account? Log in" link
- **Navigation:** Back arrow to return to login
- **Form Elements:** First name, last name, password with strength indicator

**Animations & Transitions:**
- **Entry Animation:** Content slides up with fade over 400ms
- **Micro-interactions:** Password strength bar animates as user types
- **Loading Indicators:** Progressive form validation indicators
- **Transition Out:** Success animation before dashboard redirect

**Responsive Behavior:**
- **Desktop (1200px+):** Side-by-side layout with invitation context
- **Tablet (768px-1199px):** Stacked layout, invitation summary at top
- **Mobile (320px-767px):** Single column, collapsible invitation details

**Accessibility Considerations:**
- **Focus States:** Clear focus order from top to bottom
- **Screen Reader:** Invitation details read before form
- **Color Contrast:** Password strength uses patterns not just color
- **Touch Targets:** Extra padding on mobile for easy tapping

### Contract Management

#### Contract List View

##### Default State
**Context:** Artist views all their assigned contracts in one place

**Visual Description:**
- **Layout:** Responsive card grid, 1-3 columns based on viewport
- **Colors:** White cards on gray background, status badges with semantic colors
- **Typography:** Contract title (18px, 500), organization (14px), dates (14px)
- **Components:** Contract cards with status badge, preview thumbnail, action buttons
- **Spacing:** 16px grid gap, 24px card padding

**Interactive Elements:**
- **Primary Actions:** "View Contract" button on each card
- **Secondary Actions:** Download icon, share icon (if permitted)
- **Navigation:** Filter pills at top (All, Pending, Signed, Expired)
- **Form Elements:** Search bar with real-time filtering

**Animations & Transitions:**
- **Entry Animation:** Cards stagger in from bottom (50ms delay each)
- **Micro-interactions:** Cards lift on hover with shadow (200ms)
- **Loading Indicators:** Skeleton cards while loading
- **Transition Out:** Clicked card scales up slightly before navigation

**Responsive Behavior:**
- **Desktop (1200px+):** 3-column grid, hover states active
- **Tablet (768px-1199px):** 2-column grid, larger touch targets
- **Mobile (320px-767px):** Single column list, swipe actions enabled

**Accessibility Considerations:**
- **Focus States:** Entire card is focusable with visible outline
- **Screen Reader:** Status announced with contract title
- **Color Contrast:** Status badges have text labels too
- **Touch Targets:** Entire card is tappable on mobile

##### Loading State
**Context:** Fetching contracts from SharePoint integration

**Visual Description:**
- **Layout:** Skeleton cards maintain expected layout
- **Loading Indicators:** Animated gradient sweep on skeleton elements
- **Disabled Elements:** Filters and search temporarily disabled
- **Skeleton Screens:** 3-4 skeleton cards showing structure

**User Feedback:**
- **Progress Indication:** Subtle progress bar at top of container
- **Time Expectations:** "Loading contracts..." if over 3 seconds
- **Cancellation Options:** Can navigate away, will resume on return

**Performance Considerations:**
- **Perceived Performance:** Skeleton cards appear instantly
- **Progressive Loading:** Cards populate as data arrives
- **Error Handling:** Timeout with SharePoint retry logic

##### Empty State
**Context:** No contracts assigned to the artist yet

**Visual Description:**
- **Layout:** Centered illustration with message
- **Colors:** Muted illustration colors, standard text
- **Typography:** H2 "No contracts yet" with explanatory text
- **Components:** Friendly illustration, helpful message, contact button
- **Spacing:** Generous whitespace to avoid clutter

**Interactive Elements:**
- **Primary Actions:** "Contact Administrator" button
- **Secondary Actions:** "Learn More" about the platform
- **Navigation:** Regular navigation remains available
- **Form Elements:** None in empty state

**Animations & Transitions:**
- **Entry Animation:** Illustration draws in with SVG animation
- **Micro-interactions:** Button hover states as normal
- **Loading Indicators:** N/A
- **Transition Out:** Fades when first contract appears

#### Contract Detail View

##### Document Viewing State
**Context:** Artist opens a contract to review terms

**Visual Description:**
- **Layout:** Full-screen PDF viewer with floating toolbar
- **Colors:** Dark toolbar (#424242) with white icons for contrast
- **Typography:** Viewer controls use system fonts for performance
- **Components:** PDF canvas, zoom controls, page navigation, action bar
- **Spacing:** Edge-to-edge viewing with 44px toolbar height

**Interactive Elements:**
- **Primary Actions:** "Sign Contract" floating action button (FAB)
- **Secondary Actions:** Download, print, share buttons in toolbar
- **Navigation:** Back arrow, page up/down, thumbnail navigation
- **Form Elements:** Page number input for direct navigation

**Animations & Transitions:**
- **Entry Animation:** Document fades in as it loads
- **Micro-interactions:** Pinch-to-zoom gestures supported
- **Loading Indicators:** Progressive PDF loading with progress bar
- **Transition Out:** Zoom animation to signature flow

**Responsive Behavior:**
- **Desktop (1200px+):** Two-page spread option, sidebar navigation
- **Tablet (768px-1199px):** Single page, floating controls
- **Mobile (320px-767px):** Optimized mobile viewer, bottom toolbar

**Accessibility Considerations:**
- **Focus States:** Keyboard navigation through pages
- **Screen Reader:** PDF text extraction where available
- **Color Contrast:** High contrast mode for toolbar
- **Touch Targets:** Large buttons for mobile interaction

##### E-Signature Flow State
**Context:** Artist initiates contract signing process

**Visual Description:**
- **Layout:** Guided signature overlay with document preview
- **Colors:** Semi-transparent backdrop, white signature panel
- **Typography:** Clear instructions at each step (18px)
- **Components:** Signature pad, type/draw toggle, navigation buttons
- **Spacing:** Centered modal with 32px padding

**Interactive Elements:**
- **Primary Actions:** "Sign" button after each field, "Finish" at end
- **Secondary Actions:** "Clear" signature, switch input method
- **Navigation:** Previous/Next field navigation
- **Form Elements:** Signature canvas, typed signature input

**Animations & Transitions:**
- **Entry Animation:** Modal slides up from bottom on mobile
- **Micro-interactions:** Signature preview updates in real-time
- **Loading Indicators:** Processing spinner during submission
- **Transition Out:** Success animation before returning to list

**Performance Considerations:**
- **Perceived Performance:** Instant signature capture feedback
- **Progressive Loading:** Pre-load next signature field
- **Error Handling:** Auto-save signature progress

### Expense Submission

#### Expense Creation Flow

##### Receipt Capture State
**Context:** Artist photographs receipt for expense claim

**Visual Description:**
- **Layout:** Full-screen camera view with capture controls
- **Colors:** Dark camera UI with high contrast controls
- **Typography:** Minimal text, large "Capture" label
- **Components:** Camera viewfinder, capture button, image gallery
- **Spacing:** Edge-to-edge camera, 80px bottom control area

**Interactive Elements:**
- **Primary Actions:** Large capture button (80px diameter)
- **Secondary Actions:** Flash toggle, camera switch, gallery access
- **Navigation:** Cancel (X) to return to expense form
- **Form Elements:** None during capture

**Animations & Transitions:**
- **Entry Animation:** Iris animation opening to camera
- **Micro-interactions:** Capture button animates on press
- **Loading Indicators:** Processing overlay after capture
- **Transition Out:** Image slides to preview mode

**Responsive Behavior:**
- **Desktop (1200px+):** Webcam capture in modal
- **Tablet (768px-1199px):** Full-screen camera interface
- **Mobile (320px-767px):** Native camera integration

**Accessibility Considerations:**
- **Focus States:** Voice-activated capture option
- **Screen Reader:** Audio cues for capture success
- **Color Contrast:** High contrast controls over video
- **Touch Targets:** Extra large capture button

##### Expense Form State
**Context:** Artist fills out expense details after receipt capture

**Visual Description:**
- **Layout:** Single column form with receipt preview
- **Colors:** White background, standard form styling
- **Typography:** Clear field labels (14px), input text (16px)
- **Components:** Form fields, category selector, receipt thumbnails
- **Spacing:** 24px between field groups, 16px field spacing

**Interactive Elements:**
- **Primary Actions:** "Submit Expense" button (fixed on mobile)
- **Secondary Actions:** "Save Draft", "Add Another Receipt"
- **Navigation:** Back to preserve draft, breadcrumbs on desktop
- **Form Elements:** Amount, date, category, description, receipt upload

**Animations & Transitions:**
- **Entry Animation:** Form elements fade in sequence
- **Micro-interactions:** Currency formatting as user types
- **Loading Indicators:** Inline validation spinners
- **Transition Out:** Success animation to confirmation

**Performance Considerations:**
- **Perceived Performance:** Instant field interaction
- **Progressive Loading:** Category list cached locally
- **Error Handling:** Draft auto-saved every 30 seconds

##### Submission Confirmation State
**Context:** Expense successfully submitted for approval

**Visual Description:**
- **Layout:** Centered success message with tracking info
- **Colors:** Success green accent (#4CAF50), white card
- **Typography:** H2 "Expense Submitted!" with details below
- **Components:** Success icon, tracking number, next steps
- **Spacing:** Generous padding for celebration feel

**Interactive Elements:**
- **Primary Actions:** "Submit Another" or "View All Expenses"
- **Secondary Actions:** "Download Receipt" for records
- **Navigation:** Auto-redirect to list after 5 seconds
- **Form Elements:** None in confirmation

**Animations & Transitions:**
- **Entry Animation:** Success icon draws with checkmark
- **Micro-interactions:** Confetti animation on mobile
- **Loading Indicators:** N/A
- **Transition Out:** Fade to expense list

### Schedule Management

#### Calendar View

##### Month View State
**Context:** Artist views monthly schedule overview

**Visual Description:**
- **Layout:** Traditional calendar grid with event indicators
- **Colors:** Today highlighted in primary blue, event dots in category colors
- **Typography:** Date numbers (14px), event count badges (12px)
- **Components:** Calendar grid, event dots, navigation controls
- **Spacing:** Equal cell sizing, responsive to viewport

**Interactive Elements:**
- **Primary Actions:** Date cells clickable for day view
- **Secondary Actions:** Previous/next month navigation
- **Navigation:** View switcher (Month/Week/List)
- **Form Elements:** None in calendar view

**Animations & Transitions:**
- **Entry Animation:** Calendar fades in with current month
- **Micro-interactions:** Dates highlight on hover/touch
- **Loading Indicators:** Subtle spinner while loading events
- **Transition Out:** Smooth slide between months

**Responsive Behavior:**
- **Desktop (1200px+):** Full month with event previews
- **Tablet (768px-1199px):** Condensed month view
- **Mobile (320px-767px):** Scrollable month, larger touch targets

##### Event Detail State
**Context:** Artist views specific event information

**Visual Description:**
- **Layout:** Modal overlay or pushed panel with event details
- **Colors:** Event category color as accent, white background
- **Typography:** H2 event title (24px), body details (16px)
- **Components:** Event info cards, location map, attendee list
- **Spacing:** 24px sections, clear information hierarchy

**Interactive Elements:**
- **Primary Actions:** "Add to Calendar" export button
- **Secondary Actions:** "Get Directions", "Contact Organizer"
- **Navigation:** Close (X) or back arrow
- **Form Elements:** None for viewing

**Animations & Transitions:**
- **Entry Animation:** Slide up from bottom on mobile
- **Micro-interactions:** Map interaction, expandable sections
- **Loading Indicators:** Map loads progressively
- **Transition Out:** Slide down to dismiss

### Admin Dashboard

#### User Management

##### User List State
**Context:** Admin views and manages all platform users

**Visual Description:**
- **Layout:** Data table with user rows and action columns
- **Colors:** Alternating row colors for readability (#FAFAFA)
- **Typography:** Table headers (14px, 600), data cells (14px)
- **Components:** Sortable table, bulk action toolbar, filters
- **Spacing:** Comfortable row height (48px) for easy scanning

**Interactive Elements:**
- **Primary Actions:** "Add User" button, row action menus
- **Secondary Actions:** Bulk select, export, search
- **Navigation:** Pagination controls at bottom
- **Form Elements:** Search bar, filter dropdowns

**Animations & Transitions:**
- **Entry Animation:** Rows fade in staggered
- **Micro-interactions:** Row highlight on hover
- **Loading Indicators:** Skeleton rows while loading
- **Transition Out:** Selected row expands to edit view

**Responsive Behavior:**
- **Desktop (1200px+):** Full table with all columns
- **Tablet (768px-1199px):** Horizontal scroll for table
- **Mobile (320px-767px):** Card view instead of table

##### Bulk Action State
**Context:** Admin selects multiple users for bulk operations

**Visual Description:**
- **Layout:** Sticky action bar appears with selection count
- **Colors:** Primary blue background for action bar
- **Typography:** "X users selected" with action buttons
- **Components:** Checkbox column, action toolbar, confirmation modal
- **Spacing:** 16px padding in action bar

**Interactive Elements:**
- **Primary Actions:** Bulk action buttons (activate, deactivate, email)
- **Secondary Actions:** Select all, clear selection
- **Navigation:** Cancel to exit bulk mode
- **Form Elements:** Checkboxes for selection

**Performance Considerations:**
- **Perceived Performance:** Instant selection feedback
- **Progressive Loading:** Bulk operations process in background
- **Error Handling:** Partial success handling with report

#### Analytics Dashboard

##### Metrics Overview State
**Context:** Admin monitors platform usage and performance

**Visual Description:**
- **Layout:** Grid of metric cards and charts
- **Colors:** Data visualization palette, consistent with brand
- **Typography:** Large metric numbers (32px), labels (14px)
- **Components:** KPI cards, line charts, bar graphs, pie charts
- **Spacing:** 24px grid gap, consistent card padding

**Interactive Elements:**
- **Primary Actions:** Date range selector, export reports
- **Secondary Actions:** Drill-down into specific metrics
- **Navigation:** Tabs for different report types
- **Form Elements:** Date pickers, metric filters

**Animations & Transitions:**
- **Entry Animation:** Numbers count up to final value
- **Micro-interactions:** Chart hover tooltips
- **Loading Indicators:** Chart skeleton states
- **Transition Out:** Zoom animation to detailed view

**Responsive Behavior:**
- **Desktop (1200px+):** Multi-column dashboard layout
- **Tablet (768px-1199px):** 2-column responsive grid
- **Mobile (320px-767px):** Stacked cards, swipeable charts

## Cross-Feature State Patterns

### Global Loading States
**Page Loading:** Full-page loading with logo animation and progress bar
**Component Loading:** Inline spinners sized appropriately to context
**Background Processing:** Toast notification with progress for long operations

### Global Error Handling
**Network Errors:** Banner at top of screen with retry option, offline indicator
**Server Errors:** Friendly error page with illustration and support contact
**Validation Errors:** Inline field errors with helpful correction guidance

### Navigation States
**Active Navigation:** Bold text and primary color for current section
**Breadcrumbs:** Collapsible on mobile, full path on desktop
**Back/Forward:** Browser navigation supported with proper state management

### Responsive Breakpoints
**Mobile First:** Base styles for 320px, progressive enhancement
**Touch Interactions:** Swipe gestures for navigation, pull to refresh
**Orientation Changes:** Layout adapts smoothly without data loss

## Animation & Motion Guidelines

### Transition Timing
**Micro-interactions:** 150ms ease-out for hover states and small changes
**Standard Transitions:** 200ms cubic-bezier(0.4, 0, 0.2, 1) for most animations
**Modal/Overlay:** 300ms cubic-bezier(0.0, 0, 0.2, 1) for overlays
**Page Transitions:** 400ms cubic-bezier(0.4, 0, 0.2, 1) for major changes

### Animation Patterns
**Fade Transitions:** Opacity 0 to 1 for appearing content
**Slide Transitions:** TranslateY for vertical movement, translateX for horizontal
**Scale Transitions:** Scale 0.95 to 1 for subtle emphasis
**Custom Animations:** Signature draw animation, success checkmarks

### Performance Considerations
**Hardware Acceleration:** Transform and opacity only for smooth 60fps
**Reduced Motion:** Respect prefers-reduced-motion media query
**Battery Optimization:** Limit continuous animations on mobile

## Critical Questions and Clarifications

1. **Offline State Specifics:** How should the UI indicate which features are available offline vs requiring connection? Should we show a persistent offline banner or more subtle indicators?

2. **Biometric Authentication:** Should we support Face ID/Touch ID for mobile browsers that support it? This would streamline the login process for returning users.

3. **Notification Preferences UI:** How granular should notification settings be? Per event type, per time of day, or simple on/off?

4. **Multi-Organization Support:** Will artists who work with multiple organizations need a organization switcher in the UI? How should this be designed?

5. **Receipt Quality Validation:** Should we provide real-time feedback on receipt photo quality (blur detection, contrast, etc.) before submission?

6. **Contract Versioning UI:** How should we display contract version history if enabled? Inline diff view or separate version comparison screen?

7. **Expense Approval Flow:** What's the exact approval chain visualization needed? Should artists see the full approval path or just current status?

8. **Schedule Conflict UI:** How should we highlight scheduling conflicts? Modal warning, inline indicator, or separate conflict resolution screen?

9. **Data Export Formats:** Which export formats should be supported in the UI (PDF, Excel, CSV)? Should we show preview before export?

10. **Session Timeout Behavior:** Should we show a warning before session timeout? Auto-save drafts? What's the ideal timeout duration for security vs convenience?