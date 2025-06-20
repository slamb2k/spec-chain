# Component Library: BIG Live Portal

## Overview
The BIG Live Portal component library provides a comprehensive set of reusable UI components designed specifically for the performing arts community. Built with React and TypeScript, this library emphasizes accessibility, mobile-first design, and consistent user experience across all artist and administrator workflows. Each component follows atomic design principles and incorporates the vibrant orange brand color (#EA580C) with the Inter font family for optimal readability.

## Component Architecture

### Atomic Design Hierarchy
- **Atoms**: Basic building blocks (buttons, inputs, labels)
- **Molecules**: Simple component groups (form fields, cards)
- **Organisms**: Complex components (headers, forms, tables)
- **Templates**: Page-level layout components
- **Pages**: Specific page implementations

### Naming Conventions
- Component names: PascalCase (e.g., `ButtonPrimary`)
- Props: camelCase (e.g., `isDisabled`)
- CSS classes: kebab-case (e.g., `btn-primary`)
- Events: on[Event] (e.g., `onClick`)

## Core Components

### Atoms

#### Button

**Description**: Interactive element for user actions

**Variants**:
- Primary: Main actions
- Secondary: Alternative actions
- Ghost: Tertiary actions
- Danger: Destructive actions
- Icon: Icon-only buttons

**Props**:
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| variant | 'primary' \| 'secondary' \| 'ghost' \| 'danger' | 'primary' | Visual style variant |
| size | 'small' \| 'medium' \| 'large' | 'medium' | Button size |
| disabled | boolean | false | Disabled state |
| loading | boolean | false | Show loading spinner |
| fullWidth | boolean | false | Expand to container width |
| icon | ReactNode | null | Icon component |
| iconPosition | 'left' \| 'right' | 'left' | Icon placement |
| onClick | function | - | Click handler |
| type | 'button' \| 'submit' \| 'reset' | 'button' | HTML button type |

**States**:
```
Default: Base appearance
Hover: Background #DC2626, transform scale(1.02)
Active: Background #B91C1C, transform scale(0.98)
Focus: 2px #EA580C outline with 2px offset
Disabled: Opacity 0.5, cursor not-allowed
Loading: Spinner icon, disabled interaction
```

**Examples**:
```jsx
// Primary button
<Button variant="primary" onClick={handleSave}>
  Save Changes
</Button>

// Loading state
<Button variant="primary" loading disabled>
  Saving...
</Button>

// With icon
<Button variant="secondary" icon={<PlusIcon />}>
  Add Item
</Button>

// Icon only
<Button variant="ghost" icon={<CloseIcon />} aria-label="Close" />
```

**Accessibility**:
- Keyboard: Space/Enter to activate
- ARIA: Proper roles and labels
- Focus: Visible focus indicator
- Loading: aria-busy="true" when loading

**CSS Variables**:
```css
--btn-height-small: 32px;
--btn-height-medium: 40px;
--btn-height-large: 48px;
--btn-padding-x: 16px;
--btn-border-radius: 8px;
```

#### Input

**Description**: Text input field for user data entry

**Types**:
- text: Standard text input
- email: Email validation
- password: Masked input
- number: Numeric input
- search: Search with clear button
- textarea: Multi-line text
- date: Date picker
- file: File upload

**Props**:
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| type | string | 'text' | Input type |
| value | string | '' | Controlled value |
| placeholder | string | '' | Placeholder text |
| label | string | '' | Associated label |
| helperText | string | '' | Helper message |
| error | boolean | false | Error state |
| errorMessage | string | '' | Error message |
| disabled | boolean | false | Disabled state |
| required | boolean | false | Required field |
| maxLength | number | - | Character limit |
| onChange | function | - | Change handler |
| onBlur | function | - | Blur handler |

**States**:
```
Default: 1px #D1D5DB border
Focus: 2px #EA580C border, 0 0 0 3px rgba(234, 88, 12, 0.1) shadow
Error: #EF4444 border and text
Disabled: #F9FAFB background, opacity 0.5
Valid: #22C55E border (optional)
```

**Examples**:
```jsx
// Basic input
<Input
  label="Email"
  type="email"
  placeholder="user@example.com"
  value={email}
  onChange={setEmail}
/>

// With error
<Input
  label="Password"
  type="password"
  error
  errorMessage="Password must be at least 8 characters"
  value={password}
  onChange={setPassword}
/>

// Textarea
<Input
  type="textarea"
  label="Description"
  rows={4}
  maxLength={500}
  helperText={`${value.length}/500 characters`}
/>
```

#### Badge

**Description**: Small status indicator or label

**Variants**:
- default: Neutral gray
- primary: Orange brand color
- success: Green for positive states
- warning: Amber for attention
- error: Red for critical states
- info: Blue for information

**Props**:
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| variant | string | 'default' | Color variant |
| size | 'small' \| 'medium' | 'medium' | Badge size |
| icon | ReactNode | null | Optional icon |
| children | ReactNode | - | Badge content |

**Examples**:
```jsx
<Badge variant="success">Active</Badge>
<Badge variant="warning" icon={<AlertIcon />}>Pending</Badge>
<Badge variant="error">Expired</Badge>
```

#### Icon

**Description**: Consistent icon component wrapper

**Props**:
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| name | string | - | Icon name from library |
| size | 'small' \| 'medium' \| 'large' | 'medium' | Icon size |
| color | string | 'currentColor' | Icon color |
| className | string | '' | Additional CSS classes |

**Sizes**:
- Small: 16px x 16px
- Medium: 20px x 20px  
- Large: 24px x 24px
- Navigation: 24px x 24px

#### Spinner

**Description**: Loading indicator

**Props**:
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| size | 'small' \| 'medium' \| 'large' | 'medium' | Spinner size |
| color | string | '#EA580C' | Spinner color |
| className | string | '' | Additional CSS classes |

**Examples**:
```jsx
<Spinner size="large" />
<Spinner size="small" color="#3B82F6" />
```

### Molecules

#### FormField

**Description**: Complete form field with label, input, and validation

**Composition**:
```
FormField
├── Label
├── Input/Select/Textarea
├── HelperText
└── ErrorMessage
```

**Props**:
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| name | string | - | Field name |
| label | string | - | Field label |
| type | string | 'text' | Input type |
| required | boolean | false | Required field |
| tooltip | string | '' | Help tooltip |
| validation | object | {} | Validation rules |

**Example**:
```jsx
<FormField
  name="username"
  label="Username"
  required
  tooltip="Your unique identifier"
  validation={{
    minLength: 3,
    maxLength: 20,
    pattern: /^[a-zA-Z0-9_]+$/
  }}
/>
```

#### Card

**Description**: Container component for grouped content

**Variants**:
- Default: Standard card with border
- Elevated: Higher shadow for emphasis
- Outlined: Border only, no shadow
- Interactive: Hover effects for clickable cards

**Props**:
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| variant | string | 'default' | Visual variant |
| padding | string | 'medium' | Padding size |
| onClick | function | - | Click handler |
| header | ReactNode | - | Card header |
| footer | ReactNode | - | Card footer |

**Structure**:
```jsx
<Card variant="elevated">
  <CardHeader>
    <CardTitle>Card Title</CardTitle>
    <CardActions>
      <Button variant="ghost" icon={<MoreIcon />} />
    </CardActions>
  </CardHeader>
  <CardBody>
    Content goes here
  </CardBody>
  <CardFooter>
    <Button variant="primary">Action</Button>
  </CardFooter>
</Card>
```

#### SearchInput

**Description**: Search field with icon and clear functionality

**Props**:
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| value | string | '' | Search value |
| placeholder | string | 'Search...' | Placeholder text |
| onSearch | function | - | Search handler |
| onClear | function | - | Clear handler |
| debounceMs | number | 300 | Debounce delay |

**Example**:
```jsx
<SearchInput
  placeholder="Search projects, clients..."
  onSearch={handleSearch}
  debounceMs={300}
/>
```

#### DatePicker

**Description**: Date selection component

**Props**:
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| value | Date | null | Selected date |
| onChange | function | - | Date change handler |
| minDate | Date | null | Minimum selectable date |
| maxDate | Date | null | Maximum selectable date |
| format | string | 'MM/DD/YYYY' | Display format |
| native | boolean | true | Use native picker on mobile |

**Example**:
```jsx
<DatePicker
  value={selectedDate}
  onChange={setSelectedDate}
  minDate={new Date()}
  native={isMobile}
/>
```

#### FileUpload

**Description**: File upload with drag-and-drop

**Props**:
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| accept | string | '*' | Accepted file types |
| multiple | boolean | false | Allow multiple files |
| maxSize | number | - | Max file size in bytes |
| onUpload | function | - | Upload handler |
| preview | boolean | true | Show file preview |

**Example**:
```jsx
<FileUpload
  accept="image/*,.pdf"
  maxSize={5 * 1024 * 1024} // 5MB
  onUpload={handleFileUpload}
  preview
/>
```

### Organisms

#### DataTable

**Description**: Complex table component with sorting, filtering, and pagination

**Features**:
- Sortable columns
- Row selection
- Pagination
- Responsive behavior
- Loading states
- Empty states

**Props**:
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| columns | Column[] | [] | Column definitions |
| data | any[] | [] | Table data |
| loading | boolean | false | Loading state |
| selectable | boolean | false | Enable selection |
| sortable | boolean | true | Enable sorting |
| paginated | boolean | true | Enable pagination |
| pageSize | number | 20 | Rows per page |
| onSort | function | - | Sort handler |
| onSelect | function | - | Selection handler |

**Column Definition**:
```typescript
interface Column {
  key: string;
  label: string;
  width?: string;
  sortable?: boolean;
  render?: (value: any, row: any) => ReactNode;
  align?: 'left' | 'center' | 'right';
}
```

**Responsive Behavior**:
- Desktop: Full table layout
- Tablet: Hide secondary columns
- Mobile: Card-based layout

**Example**:
```jsx
<DataTable
  columns={[
    { key: 'name', label: 'Name', sortable: true },
    { key: 'status', label: 'Status', render: (v) => <Badge>{v}</Badge> },
    { key: 'actions', label: '', render: (_, row) => <Actions row={row} /> }
  ]}
  data={users}
  selectable
  onSelect={setSelectedUsers}
/>
```

#### Modal

**Description**: Overlay dialog for focused interactions

**Variants**:
- Default: Standard modal
- Fullscreen: Mobile fullscreen
- Drawer: Side drawer variant

**Props**:
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| open | boolean | false | Open state |
| onClose | function | - | Close handler |
| title | string | - | Modal title |
| size | 'small' \| 'medium' \| 'large' | 'medium' | Modal size |
| actions | ReactNode | - | Footer actions |
| closeOnOverlay | boolean | true | Close on backdrop click |
| closeOnEscape | boolean | true | Close on ESC key |

**Accessibility**:
- Focus trap when open
- Return focus on close
- Proper ARIA attributes
- Keyboard navigation

**Example**:
```jsx
<Modal
  open={isOpen}
  onClose={handleClose}
  title="Sign Contract"
  actions={
    <>
      <Button variant="secondary" onClick={handleClose}>Cancel</Button>
      <Button variant="primary" onClick={handleSign}>Sign</Button>
    </>
  }
>
  <SignatureCanvas />
</Modal>
```

#### Navigation

**Description**: Responsive navigation component

**Variants**:
- Sidebar: Desktop side navigation
- Hamburger: Mobile drawer navigation
- Tabs: Horizontal tab navigation

**Props**:
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| items | NavItem[] | [] | Navigation items |
| variant | string | 'sidebar' | Navigation style |
| collapsed | boolean | false | Collapsed state |
| activeItem | string | '' | Active item key |
| onNavigate | function | - | Navigation handler |

**Example**:
```jsx
<Navigation
  variant={isMobile ? 'hamburger' : 'sidebar'}
  items={[
    { key: 'dashboard', label: 'Dashboard', icon: <HomeIcon /> },
    { key: 'contracts', label: 'Contracts', icon: <DocumentIcon /> },
    { key: 'expenses', label: 'Expenses', icon: <DollarIcon /> }
  ]}
  activeItem={currentRoute}
  onNavigate={handleNavigate}
/>
```

#### Form

**Description**: Form wrapper with validation and submission handling

**Props**:
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| onSubmit | function | - | Submit handler |
| validation | object | {} | Validation schema |
| initialValues | object | {} | Initial form values |
| loading | boolean | false | Submission loading state |

**Example**:
```jsx
<Form
  onSubmit={handleSubmit}
  initialValues={{ email: '', password: '' }}
  validation={{
    email: { required: true, email: true },
    password: { required: true, minLength: 8 }
  }}
>
  <FormField name="email" type="email" label="Email" />
  <FormField name="password" type="password" label="Password" />
  <Button type="submit">Sign In</Button>
</Form>
```

#### ExpenseCard

**Description**: Specialized card for expense display

**Props**:
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| expense | Expense | - | Expense data |
| onView | function | - | View handler |
| onApprove | function | - | Approve handler |
| onReject | function | - | Reject handler |
| showActions | boolean | false | Show admin actions |

**Example**:
```jsx
<ExpenseCard
  expense={{
    id: '123',
    date: '2024-01-20',
    description: 'Costume cleaning',
    amount: 45.00,
    status: 'pending',
    hasReceipt: true
  }}
  onView={handleView}
  showActions={isAdmin}
  onApprove={handleApprove}
  onReject={handleReject}
/>
```

#### ContractCard

**Description**: Contract display with status and actions

**Props**:
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| contract | Contract | - | Contract data |
| onView | function | - | View handler |
| onSign | function | - | Sign handler |
| showUrgent | boolean | true | Highlight urgent items |

**Example**:
```jsx
<ContractCard
  contract={{
    id: '456',
    production: 'Swan Lake',
    status: 'pending',
    dates: 'Feb 1 - Apr 30',
    amount: 12500,
    dueDate: '2024-01-25'
  }}
  onView={handleView}
  onSign={handleSign}
  showUrgent
/>
```

#### SignatureCanvas

**Description**: Touch-enabled signature capture

**Props**:
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| onSign | function | - | Signature complete handler |
| onClear | function | - | Clear handler |
| width | number | 300 | Canvas width |
| height | number | 150 | Canvas height |
| strokeColor | string | '#111827' | Stroke color |

**Example**:
```jsx
<SignatureCanvas
  onSign={handleSignatureComplete}
  width={isMobile ? 280 : 400}
  height={150}
/>
```

## Composite Patterns

### Form Pattern
```jsx
<Form onSubmit={handleSubmit}>
  <FormSection title="Basic Information">
    <FormField name="firstName" label="First Name" required />
    <FormField name="lastName" label="Last Name" required />
  </FormSection>
  
  <FormSection title="Contact">
    <FormField name="email" type="email" label="Email" required />
    <FormField name="phone" type="tel" label="Phone" />
  </FormSection>
  
  <FormActions>
    <Button variant="secondary" onClick={handleCancel}>
      Cancel
    </Button>
    <Button variant="primary" type="submit">
      Save
    </Button>
  </FormActions>
</Form>
```

### List Pattern
```jsx
<List>
  <ListHeader>
    <SearchInput onSearch={handleSearch} />
    <FilterDropdown filters={filters} />
  </ListHeader>
  
  <ListBody>
    {items.map(item => (
      <ListItem key={item.id}>
        <ListItemContent>
          <ListItemTitle>{item.title}</ListItemTitle>
          <ListItemMeta>{item.date}</ListItemMeta>
        </ListItemContent>
        <ListItemActions>
          <IconButton icon={<EditIcon />} />
          <IconButton icon={<DeleteIcon />} />
        </ListItemActions>
      </ListItem>
    ))}
  </ListBody>
  
  <ListFooter>
    <Pagination
      currentPage={page}
      totalPages={totalPages}
      onPageChange={setPage}
    />
  </ListFooter>
</List>
```

### Dashboard Pattern
```jsx
<DashboardLayout>
  <DashboardHeader>
    <h1>Welcome back, {userName}!</h1>
    <DateDisplay />
  </DashboardHeader>
  
  <MetricCards>
    <MetricCard
      label="Pending Contracts"
      value={3}
      trend="+2"
      icon={<DocumentIcon />}
      color="warning"
    />
    <MetricCard
      label="Total Expenses"
      value="$567.89"
      trend="-$50"
      icon={<DollarIcon />}
      color="primary"
    />
  </MetricCards>
  
  <DashboardGrid>
    <DashboardSection title="Recent Activity">
      <ActivityFeed items={recentActivity} />
    </DashboardSection>
    <DashboardSection title="Quick Actions">
      <QuickActionButtons />
    </DashboardSection>
  </DashboardGrid>
</DashboardLayout>
```

## Responsive Behavior

### Breakpoint System
```scss
$breakpoints: (
  mobile: 0px,
  tablet: 640px,
  desktop: 1024px,
  wide: 1440px
);
```

### Component Adaptations
| Component | Mobile | Tablet | Desktop |
|-----------|--------|--------|---------|
| Navigation | Hamburger drawer | Collapsible sidebar | Full sidebar |
| DataTable | Stacked cards | Condensed table | Full table |
| Modal | Fullscreen | Centered medium | Centered large |
| Form | Single column | Mixed layout | Multi-column |
| Cards | Full width | 2 columns | 3-4 columns |

## Theming

### Theme Structure
```typescript
interface Theme {
  colors: {
    primary: ColorScale;
    secondary: ColorScale;
    error: ColorScale;
    warning: ColorScale;
    success: ColorScale;
    neutral: ColorScale;
  };
  typography: {
    fontFamily: string;
    fontSize: Scale;
    fontWeight: Scale;
    lineHeight: Scale;
  };
  spacing: Scale;
  borderRadius: Scale;
  shadows: Scale;
  transitions: {
    duration: Scale;
    easing: Record<string, string>;
  };
}
```

### Dark Mode Support
All components support dark mode through CSS variables:
```css
[data-theme="dark"] {
  --color-background: #0F0F0F;
  --color-surface: #1A1A1A;
  --color-text-primary: #F9FAFB;
  --color-text-secondary: #D1D5DB;
  --color-border: #374151;
}
```

## Accessibility Checklist

### Keyboard Navigation
- [x] All interactive elements keyboard accessible
- [x] Logical tab order
- [x] Visible focus indicators
- [x] Keyboard shortcuts documented

### Screen Reader Support
- [x] Semantic HTML structure
- [x] ARIA labels where needed
- [x] Live regions for dynamic content
- [x] Proper heading hierarchy

### Visual Accessibility
- [x] Color contrast meets WCAG AA
- [x] Don't rely on color alone
- [x] Respect prefers-reduced-motion
- [x] Scalable text and spacing

## Performance Guidelines

### Bundle Size
- Tree-shakeable exports
- Lazy load heavy components
- Separate icon packages
- Code splitting by route

### Rendering
- React.memo for expensive components
- Virtual scrolling for lists > 100 items
- Debounced inputs (300ms default)
- Optimistic UI updates

### Image Optimization
- Lazy loading for images below fold
- Progressive image loading
- WebP with fallbacks
- Responsive image sizes

## Testing

### Unit Tests
```jsx
describe('Button', () => {
  it('renders with correct variant', () => {
    const { getByRole } = render(
      <Button variant="primary">Click me</Button>
    );
    expect(getByRole('button')).toHaveClass('btn-primary');
  });
  
  it('handles click events', () => {
    const onClick = jest.fn();
    const { getByRole } = render(
      <Button onClick={onClick}>Click me</Button>
    );
    fireEvent.click(getByRole('button'));
    expect(onClick).toHaveBeenCalled();
  });
  
  it('shows loading state', () => {
    const { getByRole } = render(
      <Button loading>Loading</Button>
    );
    expect(getByRole('button')).toHaveAttribute('aria-busy', 'true');
  });
});
```

### Visual Regression Tests
- Storybook snapshots for all components
- Chromatic or Percy integration
- Responsive screenshots at all breakpoints
- Dark mode variations

### Accessibility Tests
```jsx
describe('Accessibility', () => {
  it('meets WCAG AA standards', async () => {
    const { container } = render(<Button>Test</Button>);
    const results = await axe(container);
    expect(results).toHaveNoViolations();
  });
  
  it('supports keyboard navigation', () => {
    const { getByRole } = render(<Button>Test</Button>);
    const button = getByRole('button');
    button.focus();
    expect(document.activeElement).toBe(button);
  });
});
```

## Usage Guidelines

### Do's
- Use semantic component names
- Provide meaningful ARIA labels
- Handle loading and error states
- Follow composition patterns
- Test with real data

### Don'ts
- Don't override component styles directly
- Don't skip accessibility features
- Don't nest interactive elements
- Don't break responsive behavior
- Don't ignore performance budgets

## Component Status

### Production Ready
- Button, Input, Badge, Card
- FormField, SearchInput
- DataTable, Modal, Navigation
- All form patterns

### Beta
- SignatureCanvas (mobile testing ongoing)
- FileUpload (large file handling)
- DatePicker (timezone support)

### Planned
- RichTextEditor
- VideoPlayer
- AudioRecorder
- AdvancedFilters

## Version History

### v1.0.0
- Initial component set
- Basic theme support
- Core accessibility features
- Mobile-first responsive design

### v1.1.0 (Planned)
- Advanced data visualization
- Drag-and-drop support
- Enhanced animations
- Extended icon library

## Migration Guide

### From Bootstrap/Material-UI
```jsx
// Old Bootstrap
<button className="btn btn-primary">Submit</button>

// New Component Library
<Button variant="primary">Submit</Button>

// Old Material-UI
<TextField label="Email" error={hasError} />

// New Component Library
<Input label="Email" error={hasError} />
```

## Clarification Requests or Feedback

1. **Animation Performance**: Given the requirement to support 5-year-old devices, should complex animations (like signature drawing smoothness) be simplified on lower-end devices? This would help maintain 60fps performance.

2. **Offline Component Behavior**: For components that might be used offline (like ExpenseCard or ContractCard), should we implement local state management and sync indicators?

3. **Custom Theme Support**: Would administrators need the ability to customize the theme colors for their organization, or should we maintain strict brand consistency?

4. **Component Analytics**: Should interactive components track usage analytics (e.g., button clicks, form completions) for improving UX, and if so, what privacy considerations apply?

5. **Accessibility Testing Depth**: Beyond WCAG AA compliance, should we test with specific screen readers (NVDA, JAWS, VoiceOver) and document component-specific announcements?

6. **Touch Gesture Support**: For mobile-heavy usage, should we implement swipe gestures on components like cards (swipe to delete/archive) or keep interactions to taps only?

7. **Internationalization**: Should components be built with i18n support from the start, particularly for date/time formats and currency displays?