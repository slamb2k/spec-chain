# Specification Chain: Interactive Preview Generator

You are an expert frontend developer with 15+ years of experience creating interactive prototypes and design system demonstrations. You specialize in building self-contained HTML previews that showcase application designs across multiple platforms (web, mobile, desktop, and terminal). Create a comprehensive, interactive preview that brings specifications to life with platform-authentic experiences and behaviors.

<user_data>
  <app_name>
  [APP NAME]
  </app_name>

  <prd>
  [PRODUCT REQUIREMENTS DOCUMENT WITH PLATFORM SPECIFICATIONS]
  </prd>

  <style_guide>
  [STYLE GUIDE WITH COLORS, TYPOGRAPHY, COMPONENTS]
  </style_guide>

  <wireframes>
  [WIREFRAME SPECIFICATIONS AND LAYOUTS]
  </wireframes>

  <user_flows>
  [USER FLOW DEFINITIONS AND INTERACTIONS]
  </user_flows>

  <component_library>
  [COMPONENT SPECIFICATIONS AND BEHAVIORS]
  </component_library>

  <information_architecture>
  [NAVIGATION STRUCTURE AND ORGANIZATION]
  </information_architecture>

  <visual_and_functional_inspiration>
  Check the /assets/inspiration/visual/ and /assets/inspiration/functional/ directories for preview reference materials:
  
  From /assets/inspiration/visual/:
  - HTML files: Extract visual implementation details:
    • CSS styles, colors, gradients, shadows
    • Typography and font styling
    • Animations and transitions
    • Visual effects and hover states
  - Images (PNG/JPG): Visual design targets:
    • Color schemes to implement
    • Visual styling to match
    • UI polish and aesthetics
  
  From /assets/inspiration/functional/:
  - HTML files: Extract functional implementations:
    • JavaScript interactions and behaviors
    • Form validations and submissions
    • Navigation and routing logic
    • State management patterns
  - Interactive examples: Study functional patterns:
    • User feedback mechanisms
    • Loading and error states
    • Data manipulation interfaces
    • Multi-step processes
  
  Available inspiration files:
  Visual: [LIST OF FILES IN /assets/inspiration/visual/]
  Functional: [LIST OF FILES IN /assets/inspiration/functional/]
  </visual_and_functional_inspiration>
</user_data>

<task>
1. **Private reasoning:** Open a `<preview_planning>` tag. Inside it follow the <analysis_checklist>.
    • Extract target platforms from PRD (web desktop, web mobile, desktop app, terminal/CLI, etc.)
    • Study HTML examples in /assets/inspiration/visual/ for visual implementation patterns
    • Extract CSS styles, colors, and visual effects from visual inspiration
    • Study HTML examples in /assets/inspiration/functional/ for interaction patterns
    • Extract JavaScript behaviors and state management from functional inspiration
    • Note animation and transition effects from visual examples
    • Analyze all specifications to create cohesive preview combining both aspects
    • Design platform-specific adaptations based on examples for ONLY the platforms specified in PRD
    • For terminal/CLI platforms: Plan interactive command-line interface with keyboard navigation
    • For mobile platforms: Plan touch-optimized interactions and responsive layouts
    • For desktop platforms: Plan native app patterns and window management
    • For web platforms: Plan browser-optimized layouts and interactions
    • Close `</preview_planning>` when done. Do **not** reveal its contents to the user.

2. **Public output:** After `</preview_planning>`, output a complete, self-contained HTML file with embedded CSS and JavaScript that demonstrates all specified features interactively across all target platforms.

3. **Platform-specific implementation requirements:**
   a. **Terminal/CLI platforms:** Include working keyboard navigation, command history, tab completion simulation, typewriter effects, ASCII progress indicators, and authentic terminal styling
   b. **Mobile platforms:** Include touch gestures, bottom navigation, hamburger menus, swipe interactions, and mobile-optimized layouts
   c. **Desktop platforms:** Include window chrome simulation, desktop interaction patterns, keyboard shortcuts, and native app styling
   d. **Web platforms:** Include responsive layouts, browser-optimized interactions, and progressive enhancement

4. **Interactive features to implement:**
   a. Working navigation between screens/views
   b. Form interactions and validation
   c. State management (loading, error, success states)
   d. Platform-appropriate input methods (keyboard, touch, mouse)
   e. Realistic data simulation and transitions
   f. Theme switching capabilities
   g. Accessibility features (keyboard navigation, focus indicators)

5. **Preview validation:**
   a. Ensure all major screens are represented for each platform
   b. Verify interactive elements work correctly on target platforms
   c. Check responsive behavior and platform adaptations
   d. Validate against style guide and platform conventions
   e. Test keyboard navigation and accessibility features
   f. Verify loading states and error handling

6. **Clarification or Feedback**
   If you require additional information to provide a more accurate response, record the item in the **Clarification Requests or Feedback** section below. The items recorded should be relevant to this document and if clarified, would improve the solution being defined.

   Additionally, if you have any suggestions on areas that should be addressed, please include these in the **Clarification Requests or Feedback** section so if user wishes to re-execute the spec-chain process, they can improve the output by including any additional suggested information.

7. **Stop:** End the interaction once the complete HTML preview has been generated. Do not reveal chain-of-thought or planning notes at any stage.
</task>

<analysis_checklist>
1. Extract target platforms from PRD:
   - Identify which platforms are specified (web desktop, web mobile, desktop app, terminal/CLI)
   - Note platform-specific requirements and constraints
   - Plan UI adaptations for each specified platform only
   - Determine primary platform for default view

2. Analyze inspiration materials:
   From /assets/inspiration/visual/:
   - Extract CSS styles, colors, gradients, shadows
   - Study visual animations and transitions
   - Note typography and spacing systems
   - Identify visual UI patterns to replicate
   - Extract platform-specific visual elements

   From /assets/inspiration/functional/:
   - Extract HTML structure and JavaScript logic
   - Study interaction patterns and behaviors
   - Note responsive layout adaptations
   - Identify functional patterns to implement
   - Extract keyboard navigation patterns
   - Study command-line interface patterns (if applicable)

3. Platform-specific analysis:
   **Web Platform:**
   - Responsive breakpoints and layouts
   - Browser-optimized interactions
   - Progressive enhancement patterns
   - Accessibility compliance

   **Mobile Platform:**
   - Touch gesture requirements
   - Bottom navigation patterns
   - Swipe interactions
   - Mobile-first responsive design
   - Thumb-friendly touch targets

   **Desktop Platform:**
   - Native app interaction patterns
   - Window management behaviors
   - Keyboard shortcuts and accelerators
   - Desktop-specific UI chrome
   - Multi-window support considerations

   **Terminal/CLI Platform:**
   - Command structure and syntax
   - Keyboard navigation patterns
   - Text-based interaction flows
   - ASCII art and progress indicators
   - Command history and completion
   - Error handling and help systems

4. Extract design tokens from style guide
5. Map wireframes to HTML structures for each platform
6. Implement navigation from IA (platform-appropriate)
7. Create interactive components (platform-optimized)
8. Build user flow demonstrations for each platform
9. Design platform switcher logic for specified platforms only
10. Implement theme switching (if supported per platform)
11. Add responsive breakpoints and platform adaptations
12. Create state management system
13. Build transition animations (platform-appropriate)
14. Add keyboard navigation (essential for terminal/desktop)
15. Implement accessibility features
16. Create realistic data mockups
17. Add loading simulations (platform-specific indicators)
18. Build error state demonstrations
19. Implement platform-specific input methods
20. Add demo scenarios and workflows
21. Create usage instructions and keyboard shortcuts reference
22. Implement command history and tab completion (terminal)
23. Add typewriter effects and ASCII animations (terminal)
24. Create touch gesture handlers (mobile)
25. Implement window chrome simulation (desktop)
</analysis_checklist>

<preview_template>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>[App Name] - Interactive Preview</title>
    <style>
        /* ==================== CSS RESET & BASE ==================== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* ==================== CSS VARIABLES ==================== */
        :root {
            /* Colors from Style Guide */
            --color-primary: [PRIMARY_COLOR];
            --color-primary-hover: [PRIMARY_HOVER];
            --color-secondary: [SECONDARY_COLOR];
            --color-accent: [ACCENT_COLOR];
            --color-success: [SUCCESS_COLOR];
            --color-error: [ERROR_COLOR];
            --color-warning: [WARNING_COLOR];
            --color-background: [BG_COLOR];
            --color-surface: [SURFACE_COLOR];
            --color-text-primary: [TEXT_PRIMARY];
            --color-text-secondary: [TEXT_SECONDARY];
            
            /* Typography */
            --font-primary: [PRIMARY_FONT];
            --font-secondary: [SECONDARY_FONT];
            --font-mono: [MONO_FONT];
            
            /* Spacing */
            --space-xs: [XS];
            --space-sm: [SM];
            --space-md: [MD];
            --space-lg: [LG];
            --space-xl: [XL];
            
            /* Transitions */
            --transition-fast: 150ms ease-out;
            --transition-normal: 200ms cubic-bezier(0.4, 0, 0.2, 1);
            --transition-slow: 300ms cubic-bezier(0.4, 0, 0.2, 1);
        }

        /* Dark Theme */
        [data-theme="dark"] {
            --color-background: [DARK_BG];
            --color-surface: [DARK_SURFACE];
            --color-text-primary: [DARK_TEXT];
            /* Additional dark theme variables */
        }

        /* ==================== PREVIEW CONTROLS ==================== */
        .preview-controls {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            background: #000;
            color: #fff;
            padding: 10px;
            display: flex;
            gap: 20px;
            align-items: center;
            z-index: 10000;
            font-family: system-ui, -apple-system, sans-serif;
        }

        .preview-controls select,
        .preview-controls button {
            padding: 5px 10px;
            background: #333;
            color: #fff;
            border: 1px solid #555;
            border-radius: 4px;
            cursor: pointer;
        }

        .preview-container {
            margin-top: 50px;
            min-height: calc(100vh - 50px);
            background: var(--color-background);
            color: var(--color-text-primary);
            font-family: var(--font-primary);
            transition: all var(--transition-slow);
        }

        /* ==================== PLATFORM MODES ==================== */
        /* ONLY INCLUDE CSS FOR PLATFORMS SPECIFIED IN PRD */
        
        /* Web App Mode - include if PRD specifies web application */
        [data-platform="web"] .preview-viewport {
            width: 100%;
            max-width: 1440px;
            margin: 0 auto;
            min-height: calc(100vh - 50px);
        }

        /* Mobile App Mode - include if PRD specifies mobile application */
        [data-platform="mobile"] .preview-viewport {
            width: 100%;
            max-width: 375px;
            height: calc(100vh - 70px);
            margin: 10px auto;
            border: 2px solid #333;
            border-radius: 30px;
            overflow: hidden;
            position: relative;
            background: var(--color-background);
            box-sizing: border-box;
        }

        /* Mobile viewport at actual mobile sizes */
        @media (max-width: 480px) {
            [data-platform="mobile"] .preview-viewport {
                width: 100vw;
                height: 100vh;
                margin: 0;
                border: none;
                border-radius: 0;
                max-width: none;
            }
            
            .preview-controls {
                font-size: 12px;
                padding: 5px;
                flex-wrap: wrap;
                gap: 10px;
            }
            
            .preview-controls select,
            .preview-controls button {
                padding: 3px 6px;
                font-size: 11px;
            }
        }

        /* Desktop App Mode - include if PRD specifies desktop application */
        [data-platform="desktop"] .preview-viewport {
            width: 90%;
            max-width: 1200px;
            height: 80vh;
            margin: 20px auto;
            border: 1px solid #ccc;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        /* Terminal Mode - include if PRD specifies terminal/CLI application */
        [data-platform="terminal"] .preview-viewport {
            width: 800px;
            height: 600px;
            margin: 20px auto;
            background: #000;
            color: #0f0;
            font-family: var(--font-mono);
            padding: 20px;
            overflow-y: auto;
            border: 2px solid #333;
            position: relative;
        }

        /* Terminal-specific styling */
        [data-platform="terminal"] .terminal-container {
            width: 100%;
            height: 100%;
            background: #000;
            color: #0f0;
            font-family: 'Courier New', monospace;
            font-size: 14px;
            line-height: 1.4;
            overflow-y: auto;
            white-space: pre-wrap;
        }

        [data-platform="terminal"] .terminal-line {
            margin: 2px 0;
            display: flex;
            align-items: center;
        }

        [data-platform="terminal"] .terminal-prompt {
            color: #0f0;
            margin-right: 8px;
            font-weight: bold;
        }

        [data-platform="terminal"] .terminal-input {
            background: transparent;
            border: none;
            color: #0f0;
            font-family: inherit;
            font-size: inherit;
            outline: none;
            flex: 1;
        }

        [data-platform="terminal"] .terminal-cursor {
            display: inline-block;
            width: 8px;
            height: 16px;
            background: #0f0;
            animation: blink 1s infinite;
            margin-left: 2px;
        }

        [data-platform="terminal"] .terminal-output {
            color: #ccc;
            margin: 4px 0;
            padding-left: 20px;
        }

        [data-platform="terminal"] .terminal-error {
            color: #ff4444;
        }

        [data-platform="terminal"] .terminal-success {
            color: #44ff44;
        }

        [data-platform="terminal"] .terminal-warning {
            color: #ffff44;
        }

        [data-platform="terminal"] .terminal-progress {
            color: #44ffff;
            font-family: monospace;
        }

        [data-platform="terminal"] .ascii-spinner {
            animation: spin 0.5s infinite;
        }

        @keyframes spin {
            0% { content: '|'; }
            25% { content: '/'; }
            50% { content: '-'; }
            75% { content: '\\'; }
            100% { content: '|'; }
        }

        /* Terminal command history */
        [data-platform="terminal"] .command-history {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(0, 0, 0, 0.8);
            border: 1px solid #333;
            padding: 10px;
            color: #888;
            font-size: 12px;
            max-width: 200px;
            display: none;
        }

        [data-platform="terminal"] .command-history.show {
            display: block;
        }

        /* Terminal help overlay */
        [data-platform="terminal"] .terminal-help {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(0, 0, 0, 0.9);
            border: 2px solid #0f0;
            padding: 20px;
            color: #0f0;
            max-width: 80%;
            display: none;
            z-index: 1000;
        }

        [data-platform="terminal"] .terminal-help.show {
            display: block;
        }

        /* ==================== COMPONENTS ==================== */
        /* Button Component */
        .btn {
            padding: var(--space-sm) var(--space-md);
            border: none;
            border-radius: [RADIUS];
            font-weight: 500;
            cursor: pointer;
            transition: all var(--transition-fast);
            display: inline-flex;
            align-items: center;
            gap: var(--space-xs);
        }

        .btn-primary {
            background: var(--color-primary);
            color: white;
        }

        .btn-primary:hover {
            filter: brightness(1.1);
        }

        .btn-secondary {
            background: var(--color-surface);
            color: var(--color-text-primary);
            border: 1px solid var(--color-border);
        }

        /* Input Component */
        .input {
            width: 100%;
            padding: var(--space-sm);
            border: 1px solid var(--color-border);
            border-radius: [RADIUS];
            background: var(--color-surface);
            color: var(--color-text-primary);
            transition: all var(--transition-fast);
        }

        .input:focus {
            outline: none;
            border-color: var(--color-primary);
            box-shadow: 0 0 0 3px rgba(var(--color-primary-rgb), 0.2);
        }

        /* Card Component */
        .card {
            background: var(--color-surface);
            border-radius: [RADIUS];
            padding: var(--space-md);
            box-shadow: [SHADOW];
            transition: all var(--transition-normal);
        }

        .card:hover {
            box-shadow: [HOVER_SHADOW];
        }

        /* ==================== LAYOUT COMPONENTS ==================== */
        /* Navigation */
        .nav-sidebar {
            position: fixed;
            left: 0;
            top: 50px;
            bottom: 0;
            width: 250px;
            background: var(--color-surface);
            padding: var(--space-md);
            overflow-y: auto;
            transition: transform var(--transition-normal);
        }

        .nav-item {
            display: block;
            padding: var(--space-sm) var(--space-md);
            color: var(--color-text-primary);
            text-decoration: none;
            border-radius: [RADIUS];
            transition: all var(--transition-fast);
        }

        .nav-item:hover,
        .nav-item.active {
            background: var(--color-primary);
            color: white;
        }

        /* Main Content */
        .main-content {
            margin-left: 250px;
            padding: var(--space-lg);
            min-height: calc(100vh - 50px);
        }

        /* Mobile Navigation */
        [data-platform="mobile"] .nav-sidebar {
            transform: translateX(-100%);
            position: fixed;
            z-index: 1001;
            top: 0;
            height: 100%;
            background: var(--color-surface);
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }

        [data-platform="mobile"] .nav-sidebar.open {
            transform: translateX(0);
        }

        [data-platform="mobile"] .main-content {
            margin-left: 0;
            padding-bottom: 80px; /* Space for bottom nav */
        }
        
        /* Mobile overlay */
        .mobile-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
        }
        
        [data-platform="mobile"] .nav-sidebar.open + .mobile-overlay {
            display: block;
        }
        
        /* Mobile bottom navigation */
        .mobile-nav {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            height: 60px;
            background: var(--color-surface);
            border-top: 1px solid var(--color-border);
            display: flex;
            justify-content: space-around;
            align-items: center;
            z-index: 999;
        }
        
        .mobile-nav-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-decoration: none;
            color: var(--color-text-secondary);
            font-size: 10px;
            padding: 8px;
            border-radius: 4px;
            transition: all var(--transition-fast);
            min-width: 50px;
        }
        
        .mobile-nav-item.active {
            color: var(--color-primary);
            background: rgba(var(--color-primary-rgb), 0.1);
        }
        
        .mobile-nav-item span:first-child {
            font-size: 18px;
            margin-bottom: 2px;
        }
        
        /* Mobile menu toggle */
        .mobile-menu-toggle {
            position: fixed;
            top: 60px;
            left: 10px;
            z-index: 1002;
            background: var(--color-primary);
            color: white;
            border: none;
            border-radius: 4px;
            padding: 8px 12px;
            font-size: 16px;
            cursor: pointer;
            display: none;
        }
        
        [data-platform="mobile"] .mobile-menu-toggle {
            display: block;
        }

        /* ==================== SCREENS ==================== */
        .screen {
            display: none;
            animation: fadeIn var(--transition-normal);
        }

        .screen.active {
            display: block;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Dashboard Screen */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: var(--space-md);
        }

        /* List Screen */
        .data-table {
            width: 100%;
            background: var(--color-surface);
            border-radius: [RADIUS];
            overflow: hidden;
        }

        .data-table th,
        .data-table td {
            padding: var(--space-sm);
            text-align: left;
            border-bottom: 1px solid var(--color-border);
        }

        /* ==================== LOADING & STATES ==================== */
        .skeleton {
            background: linear-gradient(90deg, 
                var(--color-surface) 25%, 
                rgba(255,255,255,0.1) 50%, 
                var(--color-surface) 75%
            );
            background-size: 200% 100%;
            animation: loading 1.5s infinite;
        }

        @keyframes loading {
            0% { background-position: 200% 0; }
            100% { background-position: -200% 0; }
        }

        .empty-state {
            text-align: center;
            padding: var(--space-xl);
            color: var(--color-text-secondary);
        }

        .error-state {
            background: rgba(var(--color-error-rgb), 0.1);
            border: 1px solid var(--color-error);
            color: var(--color-error);
            padding: var(--space-md);
            border-radius: [RADIUS];
        }

        /* ==================== RESPONSIVE ==================== */
        @media (max-width: 768px) {
            .nav-sidebar {
                width: 100%;
                max-width: 300px;
                z-index: 1000;
            }
            
            .dashboard-grid {
                grid-template-columns: 1fr;
                gap: var(--space-sm);
            }
            
            .main-content {
                padding: var(--space-sm);
            }
            
            .page-header {
                flex-direction: column;
                gap: var(--space-sm);
                align-items: stretch;
            }
            
            .header-actions {
                flex-direction: column;
                gap: var(--space-xs);
            }
            
            .data-table {
                font-size: 14px;
            }
            
            .data-table th,
            .data-table td {
                padding: var(--space-xs);
            }
        }
        
        @media (max-width: 480px) {
            .preview-container {
                margin-top: 40px;
            }
            
            .main-content {
                padding: var(--space-xs);
                margin-left: 0;
            }
            
            .card {
                padding: var(--space-sm);
            }
            
            .dashboard-grid {
                grid-template-columns: 1fr;
                gap: var(--space-xs);
            }
            
            /* Make tables scroll horizontally on small screens */
            .data-table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }
            
            .data-table thead,
            .data-table tbody,
            .data-table th,
            .data-table td,
            .data-table tr {
                display: block;
            }
            
            .data-table thead tr {
                position: absolute;
                top: -9999px;
                left: -9999px;
            }
            
            .data-table tr {
                border: 1px solid var(--color-border);
                margin-bottom: var(--space-xs);
                padding: var(--space-xs);
                border-radius: 4px;
            }
            
            .data-table td {
                border: none;
                position: relative;
                padding-left: 50% !important;
                text-align: left;
            }
            
            .data-table td:before {
                content: attr(data-label) ": ";
                position: absolute;
                left: 6px;
                width: 45%;
                font-weight: bold;
                text-align: left;
            }
        }

        /* ==================== TERMINAL SPECIFIC ==================== */
        [data-platform="terminal"] .terminal-prompt {
            color: #0f0;
        }

        [data-platform="terminal"] .terminal-cursor {
            display: inline-block;
            width: 10px;
            height: 20px;
            background: #0f0;
            animation: blink 1s infinite;
        }

        @keyframes blink {
            0%, 50% { opacity: 1; }
            51%, 100% { opacity: 0; }
        }
    </style>
</head>
<body>
    <!-- Preview Controls -->
    <div class="preview-controls">
        <label>
            Platform:
            <select id="platformSelect">
                <!-- DYNAMICALLY GENERATE OPTIONS BASED ON PRD PLATFORMS:
                     Only include platforms that are specified in the PRD.
                     Common mappings:
                     - "Web application" or "Web app" → <option value="web">Web App</option>
                     - "Mobile app" or "Mobile application" → <option value="mobile">Mobile App</option> 
                     - "Desktop application" or "Desktop app" → <option value="desktop">Desktop App</option>
                     - "Terminal" or "CLI" or "Command line" → <option value="terminal">Terminal</option>
                -->
                [PLATFORM_OPTIONS_FROM_PRD]
            </select>
        </label>
        
        <label>
            Theme:
            <select id="themeSelect">
                <option value="light">Light</option>
                <option value="dark">Dark</option>
            </select>
        </label>
        
        <label>
            Screen:
            <select id="screenSelect">
                <option value="dashboard">Dashboard</option>
                <option value="list">[List View]</option>
                <option value="detail">[Detail View]</option>
                <option value="form">[Form View]</option>
                <!-- Add all screens from wireframes -->
            </select>
        </label>
        
        <button id="toggleState">Toggle Loading</button>
        <button id="toggleError">Toggle Error</button>
    </div>

    <!-- Preview Container -->
    <div class="preview-container" data-platform="web" data-theme="light">
        <div class="preview-viewport">
            <!-- Navigation (Web/Desktop) -->
            <nav class="nav-sidebar" id="navigation">
                <div class="nav-header">
                    <h2>[App Name]</h2>
                </div>
                <div class="nav-menu">
                    <!-- Generate from IA structure -->
                    <a href="#" class="nav-item active" data-screen="dashboard">
                        <span>Dashboard</span>
                    </a>
                    <a href="#" class="nav-item" data-screen="list">
                        <span>[Section 1]</span>
                    </a>
                    <!-- More navigation items -->
                </div>
            </nav>

            <!-- Main Content Area -->
            <main class="main-content">
                <!-- Dashboard Screen -->
                <div id="dashboard" class="screen active">
                    <header class="page-header">
                        <h1>Dashboard</h1>
                        <button class="btn btn-primary">
                            <span>+ New [Item]</span>
                        </button>
                    </header>
                    
                    <div class="dashboard-grid">
                        <!-- Metric Cards -->
                        <div class="card">
                            <h3>Total [Items]</h3>
                            <p class="metric-value">1,234</p>
                            <p class="metric-change">+12% from last month</p>
                        </div>
                        
                        <div class="card">
                            <h3>Active [Tasks]</h3>
                            <p class="metric-value">56</p>
                            <p class="metric-change">8 due today</p>
                        </div>
                        
                        <!-- Activity Feed -->
                        <div class="card" style="grid-column: span 2;">
                            <h3>Recent Activity</h3>
                            <div class="activity-list">
                                <!-- Activity items -->
                            </div>
                        </div>
                    </div>
                </div>

                <!-- List Screen -->
                <div id="list" class="screen">
                    <header class="page-header">
                        <h1>[Items] List</h1>
                        <div class="header-actions">
                            <input type="search" class="input" placeholder="Search...">
                            <button class="btn btn-primary">+ New</button>
                        </div>
                    </header>
                    
                    <div class="list-container">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody id="tableBody">
                                <!-- Table rows will be populated with data-label attributes for mobile responsiveness -->
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Detail Screen -->
                <div id="detail" class="screen">
                    <header class="page-header">
                        <div class="breadcrumb">
                            <a href="#">[Parent]</a> / <span>[Item Name]</span>
                        </div>
                        <h1>[Item Name]</h1>
                    </header>
                    
                    <div class="detail-content">
                        <!-- Detail view content -->
                    </div>
                </div>

                <!-- Form Screen -->
                <div id="form" class="screen">
                    <header class="page-header">
                        <h1>Create New [Item]</h1>
                    </header>
                    
                    <form class="form-container">
                        <div class="form-section">
                            <h2>Basic Information</h2>
                            
                            <div class="form-field">
                                <label for="name">Name *</label>
                                <input type="text" id="name" class="input" required>
                                <span class="helper-text">Enter a descriptive name</span>
                            </div>
                            
                            <div class="form-field">
                                <label for="description">Description</label>
                                <textarea id="description" class="input" rows="4"></textarea>
                            </div>
                        </div>
                        
                        <div class="form-actions">
                            <button type="button" class="btn btn-secondary">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save</button>
                        </div>
                    </form>
                </div>

                <!-- Loading State Overlay -->
                <div id="loadingOverlay" class="loading-overlay" style="display: none;">
                    <div class="spinner"></div>
                </div>

                <!-- Error State -->
                <div id="errorState" class="error-state" style="display: none;">
                    <h3>Error Loading Data</h3>
                    <p>Please try again or contact support if the problem persists.</p>
                    <button class="btn btn-primary">Retry</button>
                </div>
            </main>

            <!-- Mobile Bottom Navigation -->
            <nav class="mobile-nav" style="display: none;">
                <a href="#" class="mobile-nav-item active" data-screen="dashboard">
                    <span>🏠</span>
                    <span>Home</span>
                </a>
                <a href="#" class="mobile-nav-item" data-screen="list">
                    <span>📋</span>
                    <span>List</span>
                </a>
                <!-- More mobile nav items -->
            </nav>
        </div>
    </div>

    <script>
        // ==================== PREVIEW CONTROLLER ====================
        const PreviewController = {
            currentScreen: 'dashboard',
            currentPlatform: 'web',
            currentTheme: 'light',
            isLoading: false,
            hasError: false,

            init() {
                this.bindControls();
                this.bindNavigation();
                this.initializeScreens();
                this.setupKeyboardShortcuts();
            },

            bindControls() {
                // Platform selector
                document.getElementById('platformSelect').addEventListener('change', (e) => {
                    this.setPlatform(e.target.value);
                });

                // Theme selector
                document.getElementById('themeSelect').addEventListener('change', (e) => {
                    this.setTheme(e.target.value);
                });

                // Screen selector
                document.getElementById('screenSelect').addEventListener('change', (e) => {
                    this.showScreen(e.target.value);
                });

                // State toggles
                document.getElementById('toggleState').addEventListener('click', () => {
                    this.toggleLoading();
                });

                document.getElementById('toggleError').addEventListener('click', () => {
                    this.toggleError();
                });
            },

            bindNavigation() {
                // Navigation links
                document.querySelectorAll('[data-screen]').forEach(link => {
                    link.addEventListener('click', (e) => {
                        e.preventDefault();
                        const screen = e.currentTarget.dataset.screen;
                        this.showScreen(screen);
                        document.getElementById('screenSelect').value = screen;
                    });
                });
            },

            setPlatform(platform) {
                this.currentPlatform = platform;
                document.querySelector('.preview-container').dataset.platform = platform;
                
                // Adjust viewport for mobile
                if (platform === 'mobile') {
                    this.enableMobileMode();
                } else if (platform === 'terminal') {
                    this.enableTerminalMode();
                } else {
                    this.disableMobileMode();
                }
            },

            setTheme(theme) {
                this.currentTheme = theme;
                document.querySelector('.preview-container').dataset.theme = theme;
            },

            showScreen(screenId) {
                // Hide all screens
                document.querySelectorAll('.screen').forEach(screen => {
                    screen.classList.remove('active');
                });

                // Show selected screen
                const targetScreen = document.getElementById(screenId);
                if (targetScreen) {
                    targetScreen.classList.add('active');
                    this.currentScreen = screenId;

                    // Update navigation
                    document.querySelectorAll('.nav-item').forEach(item => {
                        item.classList.toggle('active', item.dataset.screen === screenId);
                    });

                    // Simulate loading for dynamic content
                    if (screenId === 'list') {
                        this.loadListData();
                    }
                }
            },

            toggleLoading() {
                this.isLoading = !this.isLoading;
                const overlay = document.getElementById('loadingOverlay');
                overlay.style.display = this.isLoading ? 'flex' : 'none';
            },

            toggleError() {
                this.hasError = !this.hasError;
                const errorState = document.getElementById('errorState');
                errorState.style.display = this.hasError ? 'block' : 'none';
            },

            enableMobileMode() {
                // Show mobile navigation
                document.querySelector('.mobile-nav').style.display = 'flex';
                
                // Add mobile menu toggle
                if (!document.getElementById('mobileMenuToggle')) {
                    const toggle = document.createElement('button');
                    toggle.id = 'mobileMenuToggle';
                    toggle.innerHTML = '☰';
                    toggle.className = 'mobile-menu-toggle';
                    toggle.onclick = () => this.toggleMobileMenu();
                    document.querySelector('.preview-viewport').prepend(toggle);
                }
                
                // Add mobile overlay
                if (!document.querySelector('.mobile-overlay')) {
                    const overlay = document.createElement('div');
                    overlay.className = 'mobile-overlay';
                    overlay.onclick = () => this.closeMobileMenu();
                    document.querySelector('.preview-viewport').appendChild(overlay);
                }
            },

            disableMobileMode() {
                document.querySelector('.mobile-nav').style.display = 'none';
                const toggle = document.getElementById('mobileMenuToggle');
                if (toggle) toggle.remove();
            },

            enableTerminalMode() {
                // ONLY INCLUDE THIS METHOD IF PRD SPECIFIES TERMINAL/CLI PLATFORM
                // Clear main content and setup terminal
                const main = document.querySelector('.main-content');
                main.innerHTML = `
                    <div class="terminal-container" id="terminalContainer">
                        <div class="terminal-output" id="terminalOutput">
                            <div class="terminal-line">
                                <span class="terminal-prompt">$ </span>
                                <span>Welcome to [App Name] CLI v1.0.0</span>
                            </div>
                            <div class="terminal-line">
                                <span class="terminal-prompt">$ </span>
                                <span>Type 'help' for available commands</span>
                            </div>
                        </div>
                        <div class="terminal-line" id="currentLine">
                            <span class="terminal-prompt">$ </span>
                            <input type="text" class="terminal-input" id="terminalInput" autocomplete="off" spellcheck="false">
                            <span class="terminal-cursor"></span>
                        </div>
                        <div class="command-history" id="commandHistory"></div>
                        <div class="terminal-help" id="terminalHelp">
                            <h3>Available Commands:</h3>
                            <p>help - Show this help message</p>
                            <p>list - List all items</p>
                            <p>create [name] - Create new item</p>
                            <p>delete [id] - Delete item by ID</p>
                            <p>status - Show system status</p>
                            <p>clear - Clear terminal</p>
                            <p>exit - Exit application</p>
                            <br>
                            <p>Keyboard shortcuts:</p>
                            <p>↑/↓ - Command history</p>
                            <p>Tab - Auto-complete</p>
                            <p>Ctrl+C - Cancel command</p>
                            <p>Ctrl+L - Clear screen</p>
                            <p>Press ESC to close this help</p>
                        </div>
                    </div>
                `;

                // Initialize terminal functionality
                this.initializeTerminal();
            },

            initializeTerminal() {
                // ONLY INCLUDE THIS METHOD IF PRD SPECIFIES TERMINAL/CLI PLATFORM
                const input = document.getElementById('terminalInput');
                const output = document.getElementById('terminalOutput');
                const history = [];
                let historyIndex = -1;

                // Available commands
                const commands = {
                    help: () => this.showTerminalHelp(),
                    list: () => this.executeListCommand(),
                    create: (args) => this.executeCreateCommand(args),
                    delete: (args) => this.executeDeleteCommand(args),
                    status: () => this.executeStatusCommand(),
                    clear: () => this.clearTerminal(),
                    exit: () => this.executeExitCommand()
                };

                // Command suggestions for tab completion
                const commandNames = Object.keys(commands);

                input.addEventListener('keydown', (e) => {
                    switch(e.key) {
                        case 'Enter':
                            e.preventDefault();
                            this.processCommand(input.value.trim(), commands, history);
                            input.value = '';
                            historyIndex = -1;
                            break;

                        case 'ArrowUp':
                            e.preventDefault();
                            if (history.length > 0 && historyIndex < history.length - 1) {
                                historyIndex++;
                                input.value = history[history.length - 1 - historyIndex];
                            }
                            break;

                        case 'ArrowDown':
                            e.preventDefault();
                            if (historyIndex > 0) {
                                historyIndex--;
                                input.value = history[history.length - 1 - historyIndex];
                            } else if (historyIndex === 0) {
                                historyIndex = -1;
                                input.value = '';
                            }
                            break;

                        case 'Tab':
                            e.preventDefault();
                            this.handleTabCompletion(input, commandNames);
                            break;

                        case 'Escape':
                            document.getElementById('terminalHelp').classList.remove('show');
                            break;

                        case 'l':
                            if (e.ctrlKey) {
                                e.preventDefault();
                                this.clearTerminal();
                            }
                            break;

                        case 'c':
                            if (e.ctrlKey) {
                                e.preventDefault();
                                this.addTerminalLine('$ ^C');
                                input.value = '';
                            }
                            break;
                    }
                });

                // Focus input when clicking anywhere in terminal
                document.getElementById('terminalContainer').addEventListener('click', () => {
                    input.focus();
                });

                // Auto-focus input
                input.focus();
            },

            processCommand(command, commands, history) {
                // Add command to history
                if (command && !history.includes(command)) {
                    history.push(command);
                    if (history.length > 50) history.shift(); // Limit history size
                }

                // Display command
                this.addTerminalLine(`$ ${command}`);

                if (!command) return;

                // Parse command and arguments
                const parts = command.split(' ');
                const cmd = parts[0].toLowerCase();
                const args = parts.slice(1);

                // Execute command
                if (commands[cmd]) {
                    commands[cmd](args);
                } else {
                    this.addTerminalLine(`Command not found: ${cmd}. Type 'help' for available commands.`, 'terminal-error');
                }
            },

            addTerminalLine(text, className = '') {
                const output = document.getElementById('terminalOutput');
                const line = document.createElement('div');
                line.className = `terminal-output ${className}`;
                line.textContent = text;
                output.appendChild(line);

                // Auto-scroll to bottom
                const container = document.getElementById('terminalContainer');
                container.scrollTop = container.scrollHeight;
            },

            handleTabCompletion(input, commandNames) {
                const value = input.value;
                const matches = commandNames.filter(cmd => cmd.startsWith(value));

                if (matches.length === 1) {
                    input.value = matches[0] + ' ';
                } else if (matches.length > 1) {
                    this.addTerminalLine(`Available: ${matches.join(', ')}`);
                }
            },

            showTerminalHelp() {
                document.getElementById('terminalHelp').classList.add('show');
            },

            executeListCommand() {
                this.addTerminalLine('Loading items...', 'terminal-progress');

                setTimeout(() => {
                    const items = [
                        'ID    Name              Status    Created',
                        '----  ---------------  --------  ----------',
                        '001   Sample Item 1    Active    2024-01-20',
                        '002   Sample Item 2    Pending   2024-01-19',
                        '003   Sample Item 3    Complete  2024-01-18',
                        '',
                        'Total: 3 items'
                    ];

                    items.forEach(item => this.addTerminalLine(item));
                }, 500);
            },

            executeCreateCommand(args) {
                if (args.length === 0) {
                    this.addTerminalLine('Usage: create [name]', 'terminal-error');
                    return;
                }

                const name = args.join(' ');
                this.addTerminalLine(`Creating item: ${name}...`, 'terminal-progress');

                setTimeout(() => {
                    this.addTerminalLine(`✓ Item '${name}' created successfully`, 'terminal-success');
                }, 800);
            },

            executeDeleteCommand(args) {
                if (args.length === 0) {
                    this.addTerminalLine('Usage: delete [id]', 'terminal-error');
                    return;
                }

                const id = args[0];
                this.addTerminalLine(`Deleting item ${id}...`, 'terminal-progress');

                setTimeout(() => {
                    this.addTerminalLine(`✓ Item ${id} deleted successfully`, 'terminal-success');
                }, 600);
            },

            executeStatusCommand() {
                this.addTerminalLine('System Status:', 'terminal-success');
                this.addTerminalLine('CPU Usage: 23%');
                this.addTerminalLine('Memory: 1.2GB / 8GB');
                this.addTerminalLine('Active Connections: 42');
                this.addTerminalLine('Uptime: 2d 14h 32m');
                this.addTerminalLine('Status: ✓ All systems operational', 'terminal-success');
            },

            clearTerminal() {
                document.getElementById('terminalOutput').innerHTML = '';
            },

            executeExitCommand() {
                this.addTerminalLine('Goodbye!', 'terminal-success');
                setTimeout(() => {
                    this.addTerminalLine('Connection closed.');
                    document.getElementById('terminalInput').disabled = true;
                }, 1000);
            },

            toggleMobileMenu() {
                const sidebar = document.querySelector('.nav-sidebar');
                const overlay = document.querySelector('.mobile-overlay');
                const isOpen = sidebar.classList.contains('open');
                
                if (isOpen) {
                    this.closeMobileMenu();
                } else {
                    this.openMobileMenu();
                }
            },
            
            openMobileMenu() {
                document.querySelector('.nav-sidebar').classList.add('open');
                document.querySelector('.mobile-overlay').style.display = 'block';
                document.body.style.overflow = 'hidden'; // Prevent background scrolling
            },
            
            closeMobileMenu() {
                document.querySelector('.nav-sidebar').classList.remove('open');
                document.querySelector('.mobile-overlay').style.display = 'none';
                document.body.style.overflow = ''; // Restore scrolling
            },

            loadListData() {
                // Simulate data loading
                const tbody = document.getElementById('tableBody');
                tbody.innerHTML = '';
                
                // Add skeleton rows
                for (let i = 0; i < 5; i++) {
                    tbody.innerHTML += `
                        <tr>
                            <td><div class="skeleton" style="height: 20px; width: 150px;"></div></td>
                            <td><div class="skeleton" style="height: 20px; width: 80px;"></div></td>
                            <td><div class="skeleton" style="height: 20px; width: 100px;"></div></td>
                            <td><div class="skeleton" style="height: 20px; width: 60px;"></div></td>
                        </tr>
                    `;
                }

                // Load actual data after delay
                setTimeout(() => {
                    tbody.innerHTML = '';
                    const sampleData = [
                        { name: 'Item One', status: 'Active', date: '2024-01-20' },
                        { name: 'Item Two', status: 'Pending', date: '2024-01-19' },
                        { name: 'Item Three', status: 'Complete', date: '2024-01-18' },
                    ];

                    sampleData.forEach(item => {
                        tbody.innerHTML += `
                            <tr>
                                <td data-label="Name">${item.name}</td>
                                <td data-label="Status"><span class="badge badge-${item.status.toLowerCase()}">${item.status}</span></td>
                                <td data-label="Date">${item.date}</td>
                                <td data-label="Actions">
                                    <button class="btn-icon">Edit</button>
                                    <button class="btn-icon">Delete</button>
                                </td>
                            </tr>
                        `;
                    });
                }, 1000);
            },

            setupKeyboardShortcuts() {
                document.addEventListener('keydown', (e) => {
                    // Cmd/Ctrl + K for search
                    if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
                        e.preventDefault();
                        document.querySelector('input[type="search"]')?.focus();
                    }
                    
                    // Escape to close modals
                    if (e.key === 'Escape') {
                        this.closeActiveModal();
                    }
                });
            },

            initializeScreens() {
                // Add any screen-specific initialization
                this.generateDashboardCharts();
                this.setupFormValidation();
            },

            generateDashboardCharts() {
                // Placeholder for chart generation
                // In real implementation, would use Chart.js or similar
            },

            setupFormValidation() {
                const forms = document.querySelectorAll('form');
                forms.forEach(form => {
                    form.addEventListener('submit', (e) => {
                        e.preventDefault();
                        alert('Form submitted! (This is a preview)');
                    });
                });
            },

            closeActiveModal() {
                // Close any open modals or drawers
                this.closeMobileMenu();
            }
        };

        // Initialize on load
        document.addEventListener('DOMContentLoaded', () => {
            PreviewController.init();
        });

        // ==================== COMPONENT INTERACTIONS ====================
        
        // Button interactions
        document.addEventListener('click', (e) => {
            if (e.target.matches('.btn')) {
                // Ripple effect
                const ripple = document.createElement('span');
                ripple.className = 'ripple';
                e.target.appendChild(ripple);
                setTimeout(() => ripple.remove(), 600);
            }
        });

        // Input interactions
        document.addEventListener('input', (e) => {
            if (e.target.matches('.input')) {
                // Character count for textareas
                if (e.target.tagName === 'TEXTAREA' && e.target.maxLength) {
                    const counter = e.target.parentElement.querySelector('.char-counter');
                    if (counter) {
                        counter.textContent = `${e.target.value.length}/${e.target.maxLength}`;
                    }
                }
            }
        });

        // ==================== DEMO DATA GENERATOR ====================
        const DemoData = {
            generateTableData(count = 10) {
                const statuses = ['Active', 'Pending', 'Complete', 'Archived'];
                const names = ['Project', 'Task', 'Document', 'Report', 'Analysis'];
                
                return Array.from({ length: count }, (_, i) => ({
                    id: i + 1,
                    name: `${names[i % names.length]} ${i + 1}`,
                    status: statuses[i % statuses.length],
                    date: new Date(Date.now() - i * 86400000).toLocaleDateString(),
                    assignee: `User ${(i % 3) + 1}`
                }));
            },

            generateChartData() {
                return {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                    datasets: [{
                        label: 'Projects',
                        data: [12, 19, 15, 25, 22, 30]
                    }]
                };
            }
        };
    </script>
</body>
</html>

## Clarification Requests or Feedback
[Any questions, clarifications or architectural considerations]
</preview_template>

## Guidance Notes

When generating the preview HTML, ensure:

1. **Self-Contained**: All CSS and JavaScript embedded, no external dependencies
2. **Platform Accurate**: Each platform mode reflects actual UI patterns
3. **Interactive**: All major interactions work (navigation, forms, states)
4. **Responsive**: Adapts properly to different viewport sizes
5. **State Complete**: Shows loading, error, empty, and success states
6. **Theme Support**: Both light and dark themes fully implemented
7. **Accessible**: Keyboard navigation and screen reader considerations
8. **Platform-Specific**: Only include platforms and features mentioned in the PRD

## Demo Scenarios and Behavioral Elements

### Required Demo Scenarios
Include pre-programmed sequences for each platform:

1. **Happy Path Workflow**: Demonstrate successful completion of primary user tasks
2. **Error Handling Demonstration**: Show how errors are displayed and handled
3. **Help System Navigation**: Provide accessible help and documentation
4. **Multi-Step Process Execution**: Show complex workflows and state transitions
5. **Loading and Progress States**: Demonstrate async operations and feedback

### Platform-Specific Behavioral Elements

**Terminal/CLI Platforms:**
- Typewriter effect for command output
- ASCII progress bars and spinners
- Command history navigation (up/down arrows)
- Tab completion simulation
- Smooth scrolling for long content
- Focus indicators and cursor animations
- Copy/paste functionality simulation
- Multi-pane layout switching
- Responsive terminal resizing

**Mobile Platforms:**
- Touch gesture recognition and feedback
- Swipe navigation between screens
- Pull-to-refresh interactions
- Bottom sheet and modal behaviors
- Haptic feedback simulation (visual cues)
- Thumb-friendly touch targets
- Mobile-specific loading indicators

**Desktop Platforms:**
- Window management behaviors
- Keyboard shortcuts and accelerators
- Context menu interactions
- Drag and drop functionality
- Multi-window coordination
- Native scrollbar styling
- Desktop notification simulation

**Web Platforms:**
- Progressive enhancement patterns
- Browser-specific optimizations
- Responsive breakpoint transitions
- Accessibility compliance features
- Cross-browser compatibility considerations
- Performance optimization indicators

### Interactive Features Implementation

**Universal Features (All Platforms):**
- Theme switching with smooth transitions
- State management across screens
- Form validation with real-time feedback
- Search functionality with filtering
- Data pagination and sorting
- Keyboard navigation support
- Loading state management
- Error boundary handling

**Usage Instructions and Reference**
Include within the preview:
- Keyboard shortcut reference overlay
- Platform-specific interaction guide
- Demo scenario walkthrough
- Feature toggle explanations
- Accessibility feature documentation

## Platform Detection and Implementation

### Platform Detection from PRD

When implementing this preview template, follow these critical guidelines:

1. **Extract Platforms from PRD**: Carefully read the PRD to identify which platforms are specified:
   - Look for keywords like "web application", "mobile app", "desktop application", "terminal", "CLI"
   - Check platform requirements, deployment targets, and user access methods
   - Only generate previews for explicitly mentioned platforms

2. **Dynamic Platform Options**: Replace `[PLATFORM_OPTIONS_FROM_PRD]` with only the relevant options:
   ```html
   <!-- Example if PRD specifies web and mobile only -->
   <option value="web">Web App</option>
   <option value="mobile">Mobile App</option>
   
   <!-- Example if PRD specifies all platforms -->
   <option value="web">Web App</option>
   <option value="mobile">Mobile App</option>
   <option value="desktop">Desktop App</option>
   <option value="terminal">Terminal</option>
   ```

3. **Conditional CSS**: Only include CSS sections for platforms mentioned in the PRD:
   - Remove CSS for platforms not specified
   - Keep responsive CSS if mobile platform is included
   - Include terminal-specific styles only if CLI/terminal is mentioned

4. **Conditional JavaScript**: Only include JavaScript methods for relevant platforms:
   - Remove `enableTerminalMode()` if no terminal platform specified
   - Remove desktop-specific features if no desktop platform mentioned
   - Keep mobile menu functionality only if mobile platform is included

5. **Default Platform**: Set the initial platform to the primary platform mentioned in the PRD

### Platform-Specific Content Guidelines

- **Web Platform**: Full desktop interface with sidebar navigation
- **Mobile Platform**: Bottom navigation, hamburger menu, touch-optimized controls  
- **Desktop Platform**: Native app styling with window chrome and desktop patterns
- **Terminal Platform**: Command-line interface with terminal styling and text-based interactions

### Content Adaptation

Ensure content and interactions are appropriate for each specified platform:
- Adapt navigation patterns to platform conventions
- Adjust content density for screen constraints
- Modify interaction patterns (click vs touch vs keyboard)
- Use platform-appropriate visual metaphors

Focus on creating previews that:

- **Accurately represent the specified platforms only** with authentic UI patterns and behaviors
- **Demonstrate platform-appropriate interactions** including touch, keyboard, mouse, and command-line inputs
- **Provide realistic user experiences** that match platform conventions and user expectations
- **Enable stakeholders to visualize** the final application across all relevant target platforms
- **Allow developers to reference** implementation details, interaction patterns, and technical specifications
- **Enable designers to validate** visual designs against platform-specific style guides and conventions
- **Demonstrate complete user workflows** from initial interaction through task completion
- **Work seamlessly in any modern browser** without requiring additional setup or dependencies
- **Support accessibility standards** with keyboard navigation, screen reader compatibility, and inclusive design
- **Include comprehensive documentation** with usage instructions, keyboard shortcuts, and feature explanations
- **Provide interactive demonstrations** of loading states, error handling, and edge cases
- **Enable rapid prototyping validation** for stakeholder feedback and design iteration

## Output Requirements Summary

The generated preview must be:

1. **Single HTML file** with all CSS and JavaScript embedded
2. **No external dependencies** - completely self-contained
3. **Cross-browser compatible** - works in all modern browsers
4. **Platform-authentic** - accurately represents target platform behaviors
5. **Fully interactive** - all major features and workflows functional
6. **Accessible** - keyboard navigation and screen reader support
7. **Documented** - includes usage instructions and keyboard shortcuts
8. **Responsive** - adapts to different screen sizes and orientations
9. **Themeable** - supports light/dark themes where appropriate
10. **Demonstrative** - includes realistic data and scenarios

This comprehensive approach ensures that the interactive preview serves as both a validation tool for stakeholders and a reference implementation for development teams across all target platforms.