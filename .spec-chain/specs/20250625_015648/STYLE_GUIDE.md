# Functional UX/UI Style Guide: BIG Live Portal

## Design Philosophy
A professional yet approachable design system that empowers performing artists and administrators to efficiently manage contracts, expenses, and schedules through clear visual hierarchy, intuitive workflows, and mobile-first accessibility.

## Color Palette

### Primary Colors
**Portal Blue** - #1976D2 (Primary actions, navigation, and brand identity)
**Deep Navy** - #0D47A1 (Headers, important text, and emphasis)

### Secondary Colors
**Warm Gray** - #616161 (Secondary text and subtle UI elements)
**Light Gray** - #E0E0E0 (Borders, dividers, and input backgrounds)
**Background Gray** - #F5F5F5 (Page backgrounds and card surfaces)

### Accent Colors
**Creative Purple** - #7B1FA2 (Artist-specific features and creative elements)
**Admin Orange** - #F57C00 (Administrative alerts and important notices)
**Schedule Teal** - #00796B (Calendar events and schedule-related features)

### Functional Colors
**Success Green** - #4CAF50 (Approved expenses, signed contracts, confirmations)
**Error Red** - #F44336 (Failed submissions, validation errors, urgent alerts)
**Warning Amber** - #FFA726 (Pending approvals, approaching deadlines)
**Info Blue** - #29B6F6 (Informational messages, tips, and guidance)

### Neutral Colors
**Neutral 100** - #FAFAFA (Lightest backgrounds and hover states)
**Neutral 400** - #BDBDBD (Disabled states and subtle borders)
**Neutral 900** - #212121 (Primary text and high contrast elements)

### Background Colors
**Background Primary** - #FFFFFF (Main app background)
**Background Secondary** - #F5F5F5 (Card and panel backgrounds)
**Background Elevated** - #FFFFFF (Modal and overlay backgrounds)
**Background Overlay** - rgba(0, 0, 0, 0.5) (Modal backdrops)

## Typography

### Font Family
**Primary Font:** Inter (Clean, professional interface text)
**Secondary Font:** Roboto (Fallback for wider browser support)
**Monospace Font:** 'Roboto Mono', monospace (Contract numbers, financial data)

### Font Weights
**Light:** 300
**Regular:** 400
**Medium:** 500
**Semibold:** 600
**Bold:** 700

### Text Styles

#### Headings
**H1:** 32px/40px, Semibold, Letter spacing -0.02em
Used for page titles and major section headers in admin dashboards

**H2:** 24px/32px, Semibold, Letter spacing -0.01em
Used for card titles, contract names, and subsection headers

**H3:** 20px/28px, Medium, Letter spacing 0em
Used for form section titles and expense category headers

**H4:** 16px/24px, Medium, Letter spacing 0.01em
Used for field labels, navigation items, and minor headers

#### Body Text
**Body Large:** 18px/28px, Regular, Letter spacing 0em
Primary reading text for contract details and important notices

**Body:** 16px/24px, Regular, Letter spacing 0em
Standard text for form fields, descriptions, and general content

**Body Small:** 14px/20px, Regular, Letter spacing 0.01em
Secondary information like timestamps, helper text, and metadata

#### Special Text
**Caption:** 12px/16px, Regular, Letter spacing 0.02em
Used for form hints, character counts, and status indicators

**Button Text:** 14px/20px, Medium, Letter spacing 0.02em
Used specifically for all interactive buttons and CTAs

**Link Text:** 16px/24px, Regular, Letter spacing 0em, #1976D2
Clickable text with underline on hover for clear affordance

## Component Styling

### Buttons

#### Primary Button
**Background:** #1976D2
**Text:** #FFFFFF
**Height:** 44px
**Padding:** 12px 24px
**Border Radius:** 4px
**Font:** 14px/20px, Medium
**Shadow:** 0px 2px 4px rgba(0, 0, 0, 0.1)
**Hover:** Background #1565C0, Shadow 0px 4px 8px rgba(0, 0, 0, 0.15)
**Active:** Background #0D47A1
**Transition:** 200ms ease-out

#### Secondary Button
**Background:** Transparent
**Border:** 1px solid #1976D2
**Text:** #1976D2
**Height:** 44px
**Padding:** 12px 24px
**Border Radius:** 4px
**Hover:** Background rgba(25, 118, 210, 0.08)

#### Ghost Button
**Background:** Transparent
**Text:** #616161
**Height:** 44px
**Padding:** 12px 24px
**Hover:** Background rgba(0, 0, 0, 0.04)

### Cards
**Background:** #FFFFFF
**Border:** 1px solid #E0E0E0
**Border Radius:** 8px
**Padding:** 24px
**Shadow:** 0px 1px 3px rgba(0, 0, 0, 0.1)
**Hover Shadow:** 0px 4px 12px rgba(0, 0, 0, 0.15)
**Transition:** 200ms ease-out

### Input Fields
**Height:** 44px
**Background:** #FAFAFA
**Border:** 1px solid #E0E0E0
**Border Radius:** 4px
**Padding:** 12px 16px
**Font Size:** 16px
**Text Color:** #212121
**Placeholder:** #9E9E9E
**Focus Border:** 2px solid #1976D2
**Focus Shadow:** 0px 0px 0px 3px rgba(25, 118, 210, 0.1)

### Text Areas
**Min Height:** 120px
**Background:** #FAFAFA
**Border:** 1px solid #E0E0E0
**Border Radius:** 4px
**Padding:** 12px 16px
**Font:** 16px/24px Inter
**Resize:** Vertical only

### Modals/Dialogs
**Background:** #FFFFFF
**Border Radius:** 8px
**Shadow:** 0px 24px 48px rgba(0, 0, 0, 0.2)
**Backdrop:** rgba(0, 0, 0, 0.5)
**Max Width:** 600px
**Padding:** 32px

### Icons
**Small:** 16px × 16px
**Default:** 24px × 24px
**Large:** 32px × 32px
**Interactive Color:** #1976D2
**Active/Hover Color:** #1565C0
**Accent Color:** #7B1FA2

## Spacing System
**4px** - Micro (Icon margins, compact element spacing)
**8px** - Tiny (Form field helper text, list item padding)
**12px** - Small (Button padding, input field padding)
**16px** - Base (Standard margins between elements)
**24px** - Medium (Card padding, section spacing)
**32px** - Large (Modal padding, major section breaks)
**48px** - Extra Large (Page margins on desktop)
**64px** - Huge (Major section dividers)

## Motion & Animation

### Transitions
**Micro:** 150ms ease-out (Hover states, small changes)
**Default:** 200ms ease-out (Most interactions)
**Smooth:** 300ms ease-in-out (Modals, dropdowns)
**Entrance:** 400ms cubic-bezier(0.0, 0.0, 0.2, 1) (Page transitions)

### Animation Patterns
**Fade In:** opacity 0 → 1
**Slide Up:** translateY(16px) → translateY(0)
**Scale:** scale(0.95) → scale(1)
**Loading Pulse:** Subtle opacity animation for skeleton screens

### Interactive States
**Hover:** Elevation increase, color shift for actionable elements
**Active:** Scale down to 0.98 for tactile feedback
**Focus:** High contrast outline for keyboard navigation
**Loading:** Spinner overlay with semi-transparent background

# Special UI Elements

## Progress Indicators
- **Progress Bars:** Height 4px, Border radius 2px
- **Progress Ring:** 3px stroke width, #1976D2
- **Loading Spinner:** 24px default size, 2px stroke

## Tags and Badges
- **Background:** rgba(25, 118, 210, 0.1)
- **Text:** #1976D2
- **Padding:** 4px 8px
- **Border Radius:** 12px
- **Font Size:** 12px

## Tooltips
- **Background:** #424242
- **Border:** None
- **Text:** #FFFFFF
- **Padding:** 8px 12px
- **Border Radius:** 4px
- **Shadow:** 0px 4px 8px rgba(0, 0, 0, 0.2)

## Data Visualization
- **Chart Colors:** #1976D2, #00796B, #7B1FA2, #F57C00, #616161
- **Grid Lines:** #F5F5F5
- **Axis Text:** #616161
- **Chart Background:** Transparent

# Responsive Breakpoints
- **Mobile:** < 768px
- **Tablet:** 768px - 1024px
- **Desktop:** 1024px - 1440px
- **Large Desktop:** > 1440px

# Accessibility Guidelines
- **Focus Indicators:** 2px solid #1976D2 with 2px offset
- **Contrast Ratios:** Minimum 4.5:1 for normal text, 3:1 for large text
- **Touch Targets:** Minimum 44px x 44px
- **Keyboard Navigation:** Tab order follows visual hierarchy
- **Screen Reader Support:** ARIA labels for all interactive elements

# Dark Mode (Optional)

## Color Adjustments
- **Background Primary Dark:** #121212
- **Background Secondary Dark:** #1E1E1E
- **Text Primary Dark:** #FFFFFF
- **Text Secondary Dark:** #B3B3B3

## Component Adjustments
- **Card Background Dark:** #1E1E1E
- **Input Background Dark:** #2C2C2C
- **Border Dark:** #383838

# Design Tokens

## Color Tokens
```css
--color-primary: #1976D2;
--color-primary-hover: #1565C0;
--color-secondary: #616161;
--color-success: #4CAF50;
--color-error: #F44336;
--color-warning: #FFA726;
--color-info: #29B6F6;
```

## Spacing Tokens
```css
--space-xs: 4px;
--space-sm: 8px;
--space-md: 16px;
--space-lg: 24px;
--space-xl: 32px;
--space-xxl: 48px;
```

## Typography Tokens
```css
--font-size-xs: 12px;
--font-size-sm: 14px;
--font-size-md: 16px;
--font-size-lg: 18px;
--font-size-xl: 24px;
--font-size-xxl: 32px;
```

# Usage Guidelines

## Color Usage
- Use Portal Blue (#1976D2) for primary actions and navigation to maintain brand consistency
- Apply functional colors consistently: Green for success, Red for errors, Amber for warnings
- Maintain 60-30-10 color ratio: 60% neutral, 30% primary, 10% accent
- Use color to guide user attention to important actions and information

## Typography Usage
- Maintain clear hierarchy with consistent heading sizes across all pages
- Use 16px minimum for body text to ensure mobile readability
- Apply Inter font family for interface text, Roboto Mono for financial data
- Limit text line length to 65-75 characters for optimal reading

## Component Usage
- Ensure all interactive elements have 44px minimum touch targets
- Use consistent spacing between related and unrelated elements
- Apply hover states to all clickable elements for clear affordance
- Maintain visual consistency by using predefined component styles

## Accessibility Best Practices
- Test all color combinations for WCAG AA compliance
- Provide clear focus indicators for keyboard navigation
- Include descriptive labels for all form fields and buttons
- Ensure error messages are clear and actionable
- Design for one-handed mobile operation

## Critical Questions and Clarifications
1. **Brand Evolution:** Should the color palette incorporate any existing BIG Live brand colors or visual elements to maintain brand continuity?

2. **Industry-Specific Patterns:** Are there specific visual conventions from the performing arts industry (like theater programs or concert posters) that should influence the design language?

3. **Accessibility Requirements:** Beyond WCAG AA compliance, are there specific accessibility needs for artists with visual impairments or color blindness that should be addressed?

4. **Cultural Considerations:** For international touring artists, should the design system account for cultural color meanings or visual preferences?

5. **Performance Contexts:** Should the interface have a "performance mode" with higher contrast or larger elements for backstage/low-light usage?

6. **Financial Visualization:** What specific data visualization needs exist for expense tracking and financial reporting that might require additional chart types or visual patterns?

7. **Document Preview:** How should contracts and documents be visually presented in the preview mode to ensure readability on mobile devices?

8. **Notification Design:** What visual priority system should be used for different notification types (urgent schedule changes vs. routine updates)?

9. **Offline Indicators:** How should the interface visually communicate offline status and sync states to users in areas with poor connectivity?

10. **Custom Branding:** To what extent should organizations be able to customize the visual appearance while maintaining usability standards?
