# UI/UX Style Guide: BIG Live Portal

## Design Philosophy

### Core Principles
1. **Clarity First**
   - Definition: Every interface element serves a clear purpose with no ambiguity
   - Application: Simplified forms, obvious CTAs, clear status indicators, minimal cognitive load
   - Example: Contract status shown with color, icon, and text label for maximum clarity

2. **Mobile Excellence**
   - Definition: Designed for one-handed use in challenging environments
   - Application: Touch-optimized interfaces, bottom navigation, minimal typing required
   - Example: Expense submission optimized for quick photo capture and minimal form filling

3. **Trust Through Design**
   - Definition: Professional appearance that instills confidence in financial and legal transactions
   - Application: Consistent layouts, secure visual cues, clear data presentation
   - Example: E-signature flow with progress indicators and security badges

### Brand Personality Traits
- **Professional:** Clean interfaces with structured layouts and clear typography
- **Approachable:** Friendly language, helpful guidance, and supportive error messages
- **Efficient:** Streamlined workflows that respect users' time and minimize friction
- **Creative-Aware:** Understanding of artistic professionals' unique needs and workflows
- **Inclusive:** Accessible to all users regardless of ability or technical proficiency

### Design Values
| Value | Description | Design Impact |
|-------|-------------|---------------|
| Respect | Honor users' time and expertise | Quick actions, remembered preferences, smart defaults |
| Reliability | Consistent and dependable experience | Predictable patterns, stable performance, clear feedback |
| Simplicity | Complexity made simple | Progressive disclosure, guided workflows, clear hierarchy |
| Accessibility | Usable by everyone | WCAG compliance, multiple input methods, flexible interfaces |

## Color System

### Primary Colors
| Color Name | Hex Value | RGB | Usage |
|------------|-----------|-----|--------|
| Primary | #1976D2 | rgb(25,118,210) | Main CTAs, active states, primary navigation |
| Primary Light | #42A5F5 | rgb(66,165,245) | Hover states, selected items, backgrounds |
| Primary Dark | #0D47A1 | rgb(13,71,161) | Active/pressed states, important text |

### Secondary Colors
| Color Name | Hex Value | RGB | Usage |
|------------|-----------|-----|--------|
| Secondary | #424242 | rgb(66,66,66) | Secondary buttons, dividers, icons |
| Secondary Light | #6D6D6D | rgb(109,109,109) | Disabled states, placeholder text |
| Secondary Dark | #212121 | rgb(33,33,33) | Primary text, headers |

### Semantic Colors
| Color Name | Hex Value | RGB | Usage |
|------------|-----------|-----|--------|
| Success | #4CAF50 | rgb(76,175,80) | Approved expenses, signed contracts, confirmations |
| Warning | #FFA726 | rgb(255,167,38) | Pending actions, expiring contracts, alerts |
| Error | #F44336 | rgb(244,67,54) | Validation errors, rejected expenses, critical alerts |
| Info | #29B6F6 | rgb(41,182,246) | Information messages, tips, schedule updates |

### Neutral Colors
| Color Name | Hex Value | RGB | Usage |
|------------|-----------|-----|--------|
| Gray 900 | #212121 | rgb(33,33,33) | Primary text, headers |
| Gray 700 | #616161 | rgb(97,97,97) | Secondary text, labels |
| Gray 500 | #9E9E9E | rgb(158,158,158) | Disabled text, placeholders |
| Gray 300 | #E0E0E0 | rgb(224,224,224) | Borders, dividers, disabled backgrounds |
| Gray 100 | #F5F5F5 | rgb(245,245,245) | Backgrounds, hover states |
| Gray 50 | #FAFAFA | rgb(250,250,250) | Light backgrounds, cards |

### Color Accessibility
- **Contrast Ratios:** All text meets WCAG 2.1 AA standards (4.5:1 normal, 3:1 large text)
- **Color Blind Safe:** Status indicators use icons and patterns in addition to color
- **Dark Mode:** Inverted color scheme with adjusted saturation to maintain readability

## Typography

### Font Families
```css
--font-primary: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
--font-mono: 'Roboto Mono', 'Courier New', monospace;
```

### Type Scale
| Level | Size | Line Height | Weight | Usage |
|-------|------|-------------|---------|--------|
| Display | 40px | 48px | 600 | Large headers, hero text |
| H1 | 32px | 40px | 600 | Page titles |
| H2 | 24px | 32px | 600 | Section headers |
| H3 | 20px | 28px | 600 | Subsection headers |
| H4 | 18px | 24px | 500 | Card headers |
| Body Large | 18px | 28px | 400 | Emphasized body text |
| Body | 16px | 24px | 400 | Default body text |
| Body Small | 14px | 20px | 400 | Helper text, captions |
| Caption | 12px | 16px | 400 | Labels, metadata |

### Typography Guidelines
- **Paragraph Spacing:** 16px (1rem) between paragraphs
- **Maximum Line Length:** 65-75 characters for optimal reading
- **Letter Spacing:** Normal for body text, +0.02em for caps
- **Text Hierarchy:** Use size, weight, and color to create clear hierarchy

## Spacing System

### Base Unit
- **Base:** 8px (0.5rem)
- **Scale:** [2, 4, 8, 12, 16, 24, 32, 48, 64, 96]

### Spacing Tokens
```css
--space-xs: 0.25rem;  /* 4px */
--space-sm: 0.5rem;   /* 8px */
--space-md: 1rem;     /* 16px */
--space-lg: 1.5rem;   /* 24px */
--space-xl: 2rem;     /* 32px */
--space-2xl: 3rem;    /* 48px */
--space-3xl: 4rem;    /* 64px */
```

### Spacing Applications
- **Component Padding:** 16px standard, 24px for cards
- **Section Spacing:** 48px between major sections
- **Grid Gutters:** 16px on mobile, 24px on desktop
- **Form Field Spacing:** 24px between field groups

## Layout System

### Grid System
```css
.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 var(--space-md);
}

.grid {
  display: grid;
  grid-template-columns: repeat(12, 1fr);
  gap: var(--space-md);
}
```

### Breakpoints
| Breakpoint | Value | Columns | Margin | Gutter |
|------------|-------|---------|---------|---------|
| Mobile | 0-768px | 4 | 16px | 16px |
| Tablet | 769-1024px | 8 | 24px | 24px |
| Desktop | 1025-1440px | 12 | 32px | 24px |
| Wide | 1441px+ | 12 | auto | 32px |

### Layout Patterns
1. **Dashboard Grid:** Card-based layout with responsive columns for metrics and actions
2. **Form Layout:** Single column on mobile, two-column on desktop for efficient data entry
3. **List-Detail:** Master list with collapsible detail view on mobile, side-by-side on desktop

## Component Library

### Buttons

#### Primary Button
```css
.btn-primary {
  background: var(--color-primary);
  color: white;
  padding: var(--space-sm) var(--space-md);
  border-radius: 4px;
  font-weight: 600;
  min-height: 44px;
  min-width: 120px;
}
```
- **States:** Default, Hover, Active, Disabled, Loading
- **Sizes:** Small (36px), Medium (44px), Large (52px)
- **Icons:** Leading, Trailing, Icon-only

#### Secondary Button
```css
.btn-secondary {
  background: transparent;
  color: var(--color-primary);
  border: 2px solid var(--color-primary);
  padding: var(--space-sm) var(--space-md);
  border-radius: 4px;
  font-weight: 600;
}
```

### Form Elements

#### Input Fields
```css
.input {
  border: 1px solid var(--gray-300);
  padding: var(--space-sm) var(--space-md);
  border-radius: 4px;
  font-size: 1rem;
  min-height: 44px;
  width: 100%;
}
```
- **States:** Default, Focus, Error, Disabled, Success
- **Types:** Text, Email, Password, Number, Date, Currency
- **Variants:** With icon, With prefix/suffix, With floating label

#### Select Dropdowns
```css
.select {
  appearance: none;
  background-image: url('chevron-down.svg');
  background-position: right 12px center;
  background-repeat: no-repeat;
  padding-right: 40px;
}
```

#### Checkboxes & Radio Buttons
- Minimum 24x24px touch target
- Custom styled with clear selected states
- Label clickable for better usability

### Cards

#### Basic Card
```css
.card {
  background: white;
  border-radius: 8px;
  padding: var(--space-lg);
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  transition: box-shadow 0.2s ease;
}
```
- **Variants:** Elevated, Outlined, Interactive
- **Content Types:** Contract, Expense, Schedule, Notification

### Navigation

#### Top Navigation
- Fixed header on mobile with app title and menu
- Expanded navigation on desktop with user profile
- Search integrated on desktop, modal on mobile

#### Bottom Navigation (Mobile)
- 4-5 primary actions maximum
- Active state clearly indicated
- Labels always visible

#### Breadcrumbs
- Collapsed on mobile showing only current page
- Full path on desktop for context

### Feedback Components

#### Alerts
- **Types:** Success, Warning, Error, Info
- **Variants:** Inline, Toast (mobile), Banner (desktop)
- **Dismissible:** Optional close button

#### Loading States
- **Spinner:** 24px default, scales with context
- **Progress Bar:** For file uploads and long operations
- **Skeleton Screens:** For content loading

#### Empty States
- Helpful illustration or icon
- Clear explanation of why empty
- Action button to resolve

## Iconography

### Icon Style
- **Style:** Outlined for consistency
- **Grid Size:** 24px standard, 20px small, 32px large
- **Stroke Width:** 2px standard
- **Corner Radius:** Slightly rounded (2px radius)

### Icon Categories
| Category | Purpose | Examples |
|----------|---------|----------|
| Navigation | Wayfinding and menu | Home, Back, Menu, Search |
| Actions | User interactions | Edit, Delete, Share, Download |
| Status | State indicators | Check, Warning, Error, Info |
| File Types | Document identification | PDF, Image, Contract, Receipt |

### Icon Usage Guidelines
- **Alignment:** Center with text baseline
- **Color:** Inherit from parent text color
- **Size:** Match line height of adjacent text
- **Accessibility:** Always include aria-label

## Motion & Animation

### Animation Principles
1. **Purposeful:** Every animation has a clear function
2. **Quick:** 150-300ms for most transitions
3. **Smooth:** Ease-in-out for natural movement

### Timing Functions
```css
--ease-in-out: cubic-bezier(0.4, 0, 0.2, 1);
--ease-out: cubic-bezier(0.0, 0, 0.2, 1);
--ease-in: cubic-bezier(0.4, 0, 1, 1);
```

### Duration Scale
```css
--duration-fast: 150ms;
--duration-normal: 300ms;
--duration-slow: 500ms;
```

### Common Animations
- **Fade:** Opacity transitions for appearing/disappearing
- **Slide:** Lateral movement for panels and menus
- **Scale:** Subtle grow/shrink for interactive feedback
- **Rotate:** Loading spinners and refresh indicators

## Accessibility Guidelines

### Color Contrast
- **Normal Text:** Minimum 4.5:1 ratio
- **Large Text:** Minimum 3:1 ratio  
- **Interactive Elements:** Minimum 3:1 ratio against background
- **Testing Tools:** Contrast checker built into design system

### Keyboard Navigation
- **Tab Order:** Logical flow following visual hierarchy
- **Focus Indicators:** 2px solid outline with 2px offset
- **Skip Links:** "Skip to main content" for screen readers
- **Keyboard Shortcuts:** Optional power user features

### Screen Reader Support
- **Semantic HTML:** Proper heading hierarchy
- **ARIA Labels:** Descriptive labels for all interactive elements
- **Live Regions:** For dynamic content updates
- **Alternative Text:** Descriptive text for all images

### Interactive Elements
- **Touch Targets:** Minimum 44x44px
- **Hover States:** Not sole indicator of interactivity
- **Error Messages:** Clear, specific, and actionable
- **Form Labels:** Always visible, never placeholder-only

## Responsive Design

### Mobile-First Approach
```css
/* Mobile styles (default) */
.component { 
  padding: var(--space-md);
}

/* Tablet and up */
@media (min-width: 769px) { 
  .component {
    padding: var(--space-lg);
  }
}

/* Desktop and up */
@media (min-width: 1025px) { 
  .component {
    padding: var(--space-xl);
  }
}
```

### Responsive Patterns
1. **Stack to Inline:** Form fields stack on mobile, inline on desktop
2. **Collapse to Modal:** Side panels become full-screen modals on mobile
3. **Progressive Disclosure:** Show core info on mobile, details on desktop

### Touch Optimization
- **Touch Targets:** 44x44px minimum
- **Gesture Support:** Swipe for navigation, pull to refresh
- **Hover Alternatives:** Long press for additional options

## Dark Mode

### Color Adaptations
| Light Mode | Dark Mode | Usage |
|------------|-----------|--------|
| #FFFFFF | #121212 | Background |
| #F5F5F5 | #1E1E1E | Card background |
| #212121 | #FFFFFF | Primary text |
| #616161 | #B0B0B0 | Secondary text |
| #1976D2 | #42A5F5 | Primary color |
| #E0E0E0 | #2C2C2C | Borders |

### Implementation Strategy
- **CSS Variables:** Dynamic color swapping
- **Image Handling:** SVG icons adapt automatically
- **User Preference:** System preference detection with manual override

## Design Tokens

### Token Structure
```json
{
  "color": {
    "primary": {
      "value": "#1976D2",
      "type": "color"
    }
  },
  "spacing": {
    "small": {
      "value": "8px",
      "type": "dimension"
    }
  }
}
```

### Token Categories
- **Colors:** All color values including semantic colors
- **Typography:** Font families, sizes, weights, line heights
- **Spacing:** All spacing values from xs to 3xl
- **Shadows:** Elevation shadows for depth
- **Borders:** Border widths, styles, and radii

## Implementation Guidelines

### CSS Architecture
- **Methodology:** BEM (Block Element Modifier)
- **Naming Convention:** `.block__element--modifier`
- **File Organization:** Components, utilities, variables

### Component Development
- **Atomic Design:** Atoms → Molecules → Organisms
- **Props/Variants:** Documented prop interfaces
- **Documentation:** Storybook for component library

### Design Handoff
- **Specs:** Detailed measurements and states
- **Assets:** SVG icons, optimized images
- **Annotations:** Interaction notes and edge cases

## Quality Checklist

### Design Review
- [ ] Follows design principles
- [ ] Consistent with style guide
- [ ] Accessible (WCAG 2.1 AA)
- [ ] Responsive across devices
- [ ] Performance optimized

### Implementation Review
- [ ] Matches design specs
- [ ] Smooth animations
- [ ] Keyboard navigable
- [ ] Screen reader tested
- [ ] Cross-browser compatible

## Version History

### Current Version: 1.0
- **Release Date:** 2025-06-26
- **Major Changes:** Initial style guide for BIG Live Portal

### Planned Updates
- **Dark Mode Refinements:** Enhanced contrast and color adjustments based on user testing
- **Component Expansion:** Additional patterns for complex workflows
- **Animation Library:** Comprehensive motion guidelines
- **Accessibility Enhancements:** WCAG 2.1 AAA compliance options

## Critical Questions and Clarifications

1. **Visual Inspiration Integration:** The inspiration files in `/assets/inspiration/visual/` should be reviewed to ensure the style guide aligns with any existing design direction. Are these mockups to follow or just inspiration?

2. **Brand Colors:** While professional blue is specified, should we incorporate any performing arts-specific colors or allow organization-specific theming?

3. **Icon Library:** Should we use an existing icon library (Material Icons, Feather, etc.) or create custom icons for arts-specific needs?

4. **Mobile Navigation Pattern:** Bottom navigation is recommended for mobile, but should we consider a hamburger menu for secondary options?

5. **Dark Mode Priority:** Given backstage use cases, should dark mode be the default rather than an option?

6. **Multi-tenant Theming:** How much visual customization should each organization have (logo only vs. color themes)?

7. **Offline Patterns:** What specific UI patterns should indicate offline status and cached vs. live data?

8. **Loading State Priorities:** Which operations are most critical for loading state design (contract loading, expense submission, etc.)?

9. **Error Recovery Patterns:** What specific error scenarios need detailed UI patterns (network failures, validation errors, etc.)?

10. **Progressive Enhancement:** How should the UI gracefully degrade for older browsers and devices while maintaining core functionality?