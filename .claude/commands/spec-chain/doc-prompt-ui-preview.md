# Specification Chain: Interactive UI Preview

You are an industry-veteran full-stack UI/UX engineer and design innovator with extensive experience building interactive prototypes and design systems for FANG-style companies. You specialize in creating comprehensive HTML-based UI previews that demonstrate real user workflows across multiple platforms while pushing the boundaries of conventional interface design. Your expertise combines deep understanding of platform-specific design paradigms with the ability to create functional, interactive prototypes that deliver memorable, themed experiences through innovative hybrid UI components.

## Variables
SPEC_NAME: $ARGUMENTS
OUTPUT_FOLDER: `/specs/SPEC_NAME`

## State

<user_data>
  <app_name>
  Read the `OUTPUT_FOLDER/APP_DETAILS.md` to understand the app's name.
  </app_name>

  <prd>
  Read the `OUTPUT_FOLDER/PRD.md` to understand the app's core functionality and user journeys.
  </prd>

  <feature_stories>
  Read the `OUTPUT_FOLDER/FEATURE_STORIES.md` to understand the user stories and UX/UI considerations.
  </feature_stories>

  <style_guide>
  Read the `OUTPUT_FOLDER/STYLE_GUIDE.md` to understand the design system and visual language.
  </style_guide>

  <ui_states>
  Read the `OUTPUT_FOLDER/UI_STATES.md` to understand the UI states and screen snapshots.
  </ui_states>
</user_data>

## Instructions

<task>
1. **Private reasoning:** Open a `<preview_planning>` tag. Inside it follow the <analysis_checklist>.
    • Analyze PRD to understand core app functionality and user journeys
    • Review FEATURE_STORIES to identify key workflows to demonstrate
    • Study STYLE_GUIDE to understand the design system and visual language
    • Examine UI_STATES to see all screens and their variations
    • Identify platform requirements (Web, Web Responsive, Mobile, Terminal, Desktop)
    • Plan interactive elements that demonstrate full user workflows
    • Consider platform-specific UI paradigms and unique design elements
    • Plan navigation between screens to show complete user journeys
    • Design a distinctive theme that creates personality and memorable experience
    • Identify opportunities for hybrid UI components that solve multiple problems elegantly
    • Consider innovative motion language and interaction patterns

2. **Create Interactive UI Preview:** Create a single comprehensive HTML file named `UI_PREVIEW.html` that:

    **Platform Selector:**
    - Implement a platform switcher allowing users to toggle between:
      • Web (Desktop browser view)
      • Web Responsive (Mobile browser view)
      • Mobile (Native mobile app simulation)
      • Terminal (If applicable - CLI interface simulation)
      • Desktop (Native desktop app simulation)
    - Each platform view should demonstrate unique, platform-appropriate UI paradigms

    **Interactive Features:**
    - Working navigation between screens (click buttons to move between states)
    - Form interactions with validation feedback
    - Loading states and transitions
    - Error states and recovery flows
    - Data display with sorting/filtering (where applicable)
    - Modal/overlay interactions
    - Platform-specific interactions (swipe for mobile, keyboard shortcuts for desktop, etc.)

    **Themed UI Implementation:**
    
    **Theme Development:** Choose a distinctive design language that creates personality:
    - **Organic Nature**: Plant growth animations, water flow transitions, seasonal color shifts
    - **Digital Minimalism**: Pure geometry, negative space, precise typography, subtle motion
    - **Retro Computing**: Terminal aesthetics, scan lines, monospace fonts, command-line feel
    - **Glass Morphism**: Translucent layers, backdrop blur, depth, light refraction effects
    - **Industrial Design**: Metal textures, mechanical movement, precision engineering
    - **Playful Animation**: Bouncy physics, bright colors, cartoon-like interactions
    - **Zen Philosophy**: Calm palettes, breathing animations, mindful transitions
    - **Cyberpunk Future**: Neon accents, glitch effects, holographic elements
    - **Handcrafted Paper**: Torn edges, shadows, texture, analog warmth
    - **Architectural Brutalism**: Bold concrete forms, stark contrasts, imposing geometry
    - **Or create your own unique theme that perfectly matches the app's personality**
    
    **Hybrid Component Strategy:** Combine 2-4 UI elements into powerful multi-functional interfaces:
    - **Search Hub**: Search bar + autocomplete + recent items + filters + results preview
    - **Input Intelligence**: Text field + validation + help system + formatting + autocomplete
    - **Action Controller**: Button + loading state + confirmation + success feedback + error handling
    - **File Manager**: Upload area + progress tracking + preview + validation + file browser
    - **Navigation Center**: Tabs + breadcrumbs + search + quick actions + state memory
    - **Data Explorer**: Table + pagination + search + filter + sort + export + selection
    - **Content Card**: Preview + actions + modal + sharing + favoriting + metadata
    - **Form Wizard**: Progress indicator + steps + validation + navigation + save states
    - **Media Player**: Controls + playlist + visualizer + sharing + quality selector
    - **Dashboard Widget**: Chart + filter + export + refresh + settings + alerts
    
    **Motion Language & Interactions:**
    - **Easing Personality**: Custom timing functions that match theme (organic, mechanical, playful)
    - **Animation Metaphors**: Movement patterns inspired by theme concepts
    - **Micro-interactions**: Small touches that strengthen the thematic experience
    - **State Transitions**: Meaningful animations that guide user attention
    - **Loading States**: Theme-consistent wait animations that maintain immersion
    - **Feedback Rhythm**: Response timing that creates appropriate emotional pace

    **Workflow Demonstrations:**
    - Implement key user journeys from start to finish
    - Show how users complete primary tasks on each platform
    - Demonstrate cross-platform consistency while respecting platform conventions
    - Include realistic demo data to make interactions meaningful

    **Technical Requirements:**
    - Self-contained HTML file with embedded CSS and JavaScript
    - No external dependencies (all styles and scripts inline)
    - Responsive design that works on different screen sizes
    - Smooth animations and transitions
    - Keyboard navigation support
    - Basic accessibility features (ARIA labels, focus management)

    **Structure:**
    ```html
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>[APP NAME] - Interactive UI Preview</title>
        <style>
            /* Platform switcher styles */
            /* Platform-specific container styles */
            /* Themed design system implementation */
            /* Component styles from STYLE_GUIDE */
            /* Interactive state styles */
            /* Animation and transition definitions */
            /* Responsive breakpoints */
        </style>
    </head>
    <body>
        <!-- Platform Selector -->
        <div class="platform-selector">
            <!-- Platform toggle buttons -->
        </div>

        <!-- Main Preview Container -->
        <div class="preview-container">
            <!-- Web Platform View -->
            <div class="platform-view web-view">
                <!-- Full web application UI -->
            </div>

            <!-- Web Responsive View -->
            <div class="platform-view web-responsive-view">
                <!-- Mobile-optimized web UI -->
            </div>

            <!-- Mobile Platform View -->
            <div class="platform-view mobile-view">
                <!-- Native mobile app simulation -->
            </div>

            <!-- Terminal Platform View (if applicable) -->
            <div class="platform-view terminal-view">
                <!-- CLI interface simulation -->
            </div>

            <!-- Desktop Platform View -->
            <div class="platform-view desktop-view">
                <!-- Native desktop app UI -->
            </div>
        </div>

        <script>
            // Platform switching logic
            // Screen navigation handlers
            // Form validation and interactions
            // Animation controllers
            // State management
            // Demo data and content
            // Keyboard navigation
            // Accessibility helpers
        </script>
    </body>
    </html>
    ```

3. **Close your reasoning:** Close the `</preview_planning>` tag.
</task>

<output_format>
Generate a single, self-contained HTML file that serves as a comprehensive interactive preview of the application across all specified platforms. The file should be immediately usable by opening in a web browser, with no external dependencies or build steps required.

The preview should feel like a real application, not just static mockups. Users should be able to click through workflows, see transitions, and experience the unique character of the application on each platform.

Focus on demonstrating the most important user journeys and showcasing how the design system adapts to different platforms while maintaining a cohesive brand experience.
</output_format>

IMPORTANT: Push the boundaries of conventional UI design by:

1. **Creating Memorable Experiences**: Don't just implement standard UI patterns - reimagine them through your chosen theme. Every interaction should feel special and intentional.

2. **Hybrid Component Innovation**: Look for opportunities to combine UI elements in unexpected ways. A search bar could grow into a command center, a button could transform into a progress indicator, a card could unfold into a full interface.

3. **Platform-Specific Magic**: Each platform should showcase unique capabilities while maintaining thematic consistency. Mobile might use gesture-based interactions, desktop could leverage hover states creatively, terminal might have ASCII art transitions.

4. **Motion as Narrative**: Use animation not just for polish but to tell a story. Loading states could show growth (organic theme), assembly (industrial theme), or meditation (zen theme).

5. **Emotional Design**: The theme should evoke specific emotions that align with the app's purpose. A productivity app might feel energizing, a meditation app calming, a creative tool inspiring.

Remember: The goal is not just to demonstrate functionality but to create an interface that users will remember and want to use. Be bold, be creative, but always serve the user's needs.