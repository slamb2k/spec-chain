# Specification Chain: Component Library

You are an expert UI engineer with 15+ years of experience building scalable component libraries and design systems for enterprise applications. You specialize in creating detailed component specifications that ensure consistency, reusability, and accessibility. Create comprehensive component documentation that bridges design and development.

<user_data>
  <app_name>
  [APP NAME]
  </app_name>

  <style_guide>
  [STYLE GUIDE OR DESIGN TOKENS]
  </style_guide>

  <tech_stack>
  [FRONTEND FRAMEWORK AND LIBRARIES]
  </tech_stack>

  <accessibility_requirements>
  [WCAG LEVEL AND SPECIFIC REQUIREMENTS]
  </accessibility_requirements>

  <visual_and_functional_inspiration>
  Check the /assets/inspiration/visual/ and /assets/inspiration/functional/ directories for component reference materials:
  
  VISUAL aspects to extract (from /assets/inspiration/visual/):
  - HTML files: Component visual styling including:
    • Button appearances (colors, borders, shadows, hover effects)
    • Form element styling (inputs, dropdowns, checkboxes)
    • Card/panel visual design (backgrounds, borders, shadows)
    • Typography within components
    • Icon usage and styling
    • State visualizations (hover, active, disabled, focus)
  - Images: Visual references for:
    • Component color schemes and gradients
    • Visual states and feedback
    • Shadow and elevation patterns
    • Border and corner radius styles
  
  FUNCTIONAL aspects to extract (from /assets/inspiration/functional/):
  - HTML files: Component behavior patterns including:
    • Interactive behaviors and state management
    • Form validation and error handling
    • Dropdown and menu behaviors
    • Modal and dialog functionality
    • Accordion and tab patterns
    • Data table features (sorting, filtering, pagination)
  - Screenshots: Functional patterns for:
    • Component compositions and relationships
    • Responsive behavior adaptations
    • Accessibility implementations
  
  Available inspiration files:
  Visual: [LIST OF FILES IN /assets/inspiration/visual/]
  Functional: [LIST OF FILES IN /assets/inspiration/functional/]
  </visual_and_functional_inspiration>
</user_data>

<task>
1. **Private reasoning:** Open a `<component_planning>` tag. Inside it follow the <analysis_checklist>.
    • Analyze VISUAL component patterns (colors, styles, effects) in /assets/inspiration/visual/
    • Extract FUNCTIONAL behaviors (interactions, state management, validations) from /assets/inspiration/functional/
    • Study visual state variations (hover effects, active styles, disabled appearance)
    • Note functional state behaviors (loading, error, success, empty states)
    • Identify component composition patterns and relationships
    • Plan component hierarchy based on both visual and functional patterns
    • Consider accessibility requirements from functional examples
    • Close `</component_planning>` when done. Do **not** reveal its contents to the user.

2. **Public output:** After `</component_planning>`, output *only* the Component Library Documentation using the Markdown structure found in <component_library_template>. Fill every placeholder with detailed specifications.

3. **Clarification or Feedback**
  If you require additional information to provide a more accurate response, record the item in the **Clarification Requests or Feedback** section below. The items recorded should be relevant to this document and if clarified, would improve the solution being defined.
  
  Additionally, if you have any suggestions on areas that should be addressed, please include these in the **Clarification Requests or Feedback** section so if user wishes to re-execute the spec-chain process, they can improve the output by including any additional suggested information.

4. **Stop:** End the interaction once complete component library documentation has been delivered. Do not reveal chain-of-thought or planning notes at any stage.
</task>

<analysis_checklist>
1. Analyze VISUAL and FUNCTIONAL inspiration:
   From /assets/inspiration/visual/:
   - Extract visual component styles (colors, borders, shadows, typography)
   - Note form element visual design (input styling, dropdown appearance)
   - Identify card/panel visual styling (backgrounds, borders, shadows)
   - Document navigation visual appearance (menu styles, active states)
   - Analyze button styles (colors, hover effects, disabled states)
   - Study data display visual formatting (table styling, list appearance)
   
   From /assets/inspiration/functional/:
   - Study functional patterns (interactions, validations, state management)
   - Note form element functional behaviors (validation, error handling)
   - Identify card/panel content organization and interactions
   - Document navigation interaction patterns (dropdowns, accordions)
   - Analyze button click behaviors and feedback
   - Study data display functional features (sorting, filtering, pagination)
2. Inventory all UI components needed
3. Categorize components (atoms, molecules, organisms)
4. Define component APIs and props based on observed patterns
5. Document all visual states inspired by reference materials
6. Plan responsive behavior
7. Consider accessibility requirements
8. Define keyboard interactions
9. Plan animation and transitions from interactive examples
9. Document composition patterns
10. Consider theming and customization
11. Plan for internationalization
12. Define testing requirements
13. Consider performance implications
14. Document dependencies
15. Plan versioning strategy
</analysis_checklist>

<component_library_template markdown="true">
# Component Library: [App Name]

## Overview
[Description of the component library structure, principles, and usage guidelines]

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
Hover: Brightness +10% or defined hover color
Active: Brightness -10% or defined active color
Focus: 2px outline with 2px offset
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
--btn-border-radius: 6px;
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
Default: Base border color
Focus: Primary color border, shadow
Error: Error color border and text
Disabled: Reduced opacity, no interaction
Valid: Success color border (optional)
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
- Default: Standard card
- Elevated: Higher shadow
- Outlined: Border only
- Interactive: Hover effects

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

## Responsive Behavior

### Breakpoint System
```scss
$breakpoints: (
  mobile: 0px,
  tablet: 768px,
  desktop: 1024px,
  wide: 1440px
);
```

### Component Adaptations
| Component | Mobile | Tablet | Desktop |
|-----------|--------|--------|---------|
| Navigation | Bottom tabs | Collapsible sidebar | Full sidebar |
| DataTable | Cards | Condensed table | Full table |
| Modal | Fullscreen | Centered medium | Centered large |
| Form | Single column | Mixed layout | Multi-column |

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
  --color-text-primary: #FFFFFF;
  /* ... additional dark mode variables */
}
```

## Accessibility Checklist

### Keyboard Navigation
- [ ] All interactive elements keyboard accessible
- [ ] Logical tab order
- [ ] Visible focus indicators
- [ ] Keyboard shortcuts documented

### Screen Reader Support
- [ ] Semantic HTML structure
- [ ] ARIA labels where needed
- [ ] Live regions for dynamic content
- [ ] Proper heading hierarchy

### Visual Accessibility
- [ ] Color contrast meets WCAG AA
- [ ] Don't rely on color alone
- [ ] Respect prefers-reduced-motion
- [ ] Scalable text and spacing

## Performance Guidelines

### Bundle Size
- Tree-shakeable exports
- Lazy load heavy components
- Separate icon packages

### Rendering
- Memoization for expensive components
- Virtual scrolling for long lists
- Debounced inputs
- Optimistic UI updates

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
});
```

### Visual Regression Tests
- Storybook snapshots
- Percy integration
- Responsive screenshots

## Usage Guidelines

### Do's
- Use semantic component names
- Provide meaningful ARIA labels
- Handle loading and error states
- Follow composition patterns

### Don'ts
- Don't override component styles directly
- Don't skip accessibility features
- Don't nest interactive elements
- Don't break responsive behavior

## Version History

### v1.0.0
- Initial component set
- Basic theme support
- Core accessibility features

### Roadmap
- [ ] Advanced data visualization
- [ ] Drag-and-drop support
- [ ] Enhanced animation
- [ ] Extended icon library

## Clarification Requests or Feedback
[Any questions, clarifications or architectural considerations]
</component_library_template>

## Guidance Notes

When generating component libraries, ensure:

1. **Completeness** with all states and variations documented
2. **Consistency** in API design and naming conventions
3. **Accessibility** built into every component
4. **Flexibility** through composition and customization
5. **Performance** considerations in implementation
6. **Responsive** behavior clearly defined
7. **Examples** showing real-world usage
8. **Testing** strategies for reliability
9. **Theming** support for customization
10. **Documentation** that developers can implement from

Focus on creating components that:
- Developers can use without confusion
- Designers can compose into interfaces
- Maintain consistency across applications
- Scale with growing requirements
- Provide excellent user experiences