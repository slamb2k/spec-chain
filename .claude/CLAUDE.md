# CLAUDE.md

Guidance for Claude Code when helping generate high-quality documentation, architecture, and innovative UI designs using Spec Chain.

## Primary Objective

Help create exceptional software specifications that result in:
- **Documentation**: Clear, comprehensive, and actionable
- **Architecture**: Scalable, maintainable, and modern
- **UI/UX**: Innovative, professional, and user-centric for any platform
- **Code**: Production-ready, well-structured, and performant

## Quick Command Reference

```bash
/init-spec-chain              # Initialize project structure
/validate-spec-chain          # Validate setup
/run-spec-chain [name]        # Generate complete documentation
```

## Platform Detection & Adaptation

When analyzing APP_DETAILS.md, identify the target platform(s) and adapt all recommendations accordingly:

### Supported Platforms

**Web Applications**
- Progressive Web Apps (PWA)
- Single Page Applications (SPA)
- Server-Side Rendered (SSR)
- Static Sites

**Mobile Applications**
- Native iOS (Swift/SwiftUI)
- Native Android (Kotlin/Jetpack Compose)
- Cross-platform (React Native, Flutter)
- Hybrid (Ionic, Capacitor)

**Desktop Applications**
- Electron-based
- Native Windows (WPF, WinUI)
- Native macOS (AppKit, SwiftUI)
- Native Linux (GTK, Qt)
- Cross-platform (Tauri, Flutter)

**Terminal/CLI Applications**
- Command-line tools
- Terminal UIs (TUI)
- REPL interfaces
- System utilities

**Specialized Interfaces**
- Embedded systems
- Kiosk applications
- TV/Large screen
- Wearables
- Voice interfaces

## Excellence Standards (Platform-Adaptive)

### 1. APP_DETAILS.md Quality

When helping fill out APP_DETAILS.md, ensure:

**Project Overview**
- Crystal-clear value proposition
- Platform-specific target audience
- Platform-appropriate success metrics
- Competitive differentiation within platform constraints

**Technical Requirements (Platform-Specific)**

For **Web**:
- Modern stack (Next.js 14+, TypeScript, Tailwind CSS)
- Progressive enhancement strategy
- SEO and performance targets

For **Mobile**:
- Platform-native or cross-platform decision rationale
- Offline capabilities
- Push notification strategy
- App store optimization considerations

For **Desktop**:
- Native vs Electron trade-offs
- OS integration requirements
- Auto-update strategy
- System resource considerations

For **Terminal/CLI**:
- Shell compatibility requirements
- Package manager distribution
- Piping and composition support
- Cross-platform considerations

**Feature Specifications**
- User stories appropriate to platform interaction model
- Platform-specific priority levels
- Technical complexity for chosen platform
- Platform-native integrations

### 2. Visual Inspiration Philosophy (Platform-Aware)

**Core Principle**: Adapt inspiration to platform conventions while innovating within constraints.

**Platform-Specific Inspiration Analysis**:

For **Web** (`visual/web/`):
- Responsive design patterns
- Browser-specific capabilities
- Web animation possibilities
- Cross-browser considerations

For **Mobile** (`visual/mobile/`):
- Platform design guidelines (HIG for iOS, Material for Android)
- Touch gestures and haptics
- Screen size adaptations
- Native component usage

For **Desktop** (`visual/desktop/`):
- Window management patterns
- Menu bar conventions
- Keyboard shortcuts
- Multi-window workflows

For **Terminal** (`visual/terminal/`):
- ASCII art and box drawing
- Color scheme constraints
- Terminal capabilities (256 color, true color)
- Keyboard-only navigation

### 3. Platform-Specific Design Excellence

**Web Design Patterns**
```css
/* Progressive enhancement approach */
.feature {
  /* Base experience */
  display: block;
  
  /* Enhanced with feature detection */
  @supports (backdrop-filter: blur(10px)) {
    backdrop-filter: blur(10px);
  }
}
```

**Mobile Design Patterns**
```swift
// iOS Native approach
struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                // Platform-native components
            }
            .navigationTitle("App Name")
            .refreshable { }
        }
    }
}
```

**Desktop Design Patterns**
```typescript
// Electron main process
const createWindow = () => {
  const win = new BrowserWindow({
    width: 1200,
    height: 800,
    titleBarStyle: 'hiddenInset', // macOS native feel
    webPreferences: {
      contextIsolation: true
    }
  })
}
```

**Terminal Design Patterns**
```python
# Rich terminal UI
from rich.console import Console
from rich.table import Table

console = Console()
table = Table(title="Data View")
table.add_column("Name", style="cyan")
table.add_column("Status", style="green")
```

### 4. Architecture Excellence (Platform-Optimized)

**Web Architecture**
- Client-server separation
- API design (REST/GraphQL)
- CDN strategy
- State management (client vs server)

**Mobile Architecture**
- Offline-first design
- Background task handling
- Push notification infrastructure
- Deep linking architecture

**Desktop Architecture**
- Main/renderer process separation (Electron)
- Native API access patterns
- File system integration
- System tray/menu bar services

**Terminal Architecture**
- Pipe-friendly design
- Configuration file patterns
- Plugin systems
- Shell integration

### 5. Innovative UI/UX Design (Platform-Native)

**Adapt Innovation to Platform Constraints**:

**Web Innovations**
- Progressive Web App features
- WebGL/WebGPU for graphics
- Web Components for reusability
- Service Workers for offline

**Mobile Innovations**
- Gesture-based navigation
- Haptic feedback
- AR/VR capabilities
- Platform-specific features (Live Activities, Widgets)

**Desktop Innovations**
- Multi-window coordination
- System integration (notifications, file associations)
- Dock/taskbar integration
- Global shortcuts

**Terminal Innovations**
- Interactive TUI elements
- Syntax highlighting
- Auto-completion
- Progress visualization

### 6. Code Generation Patterns (Platform-Specific)

**Web Patterns**
```typescript
// React component pattern
export const Component: FC<Props> = ({ data }) => {
  // Web-specific hooks
  useEffect(() => {
    // Browser API usage
  }, [])
}
```

**Mobile Patterns**
```kotlin
// Android Compose pattern
@Composable
fun Screen(navController: NavController) {
    // Platform-specific UI
    LazyColumn {
        items(data) { item ->
            Card(modifier = Modifier.fillMaxWidth())
        }
    }
}
```

**Desktop Patterns**
```csharp
// WPF MVVM pattern
public class MainViewModel : INotifyPropertyChanged {
    // Desktop-specific binding
    public ICommand FileOpenCommand { get; }
}
```

**Terminal Patterns**
```rust
// CLI pattern with clap
#[derive(Parser)]
#[command(author, version, about)]
struct Args {
    /// Input file path
    #[arg(short, long)]
    input: PathBuf,
}
```

## Platform-Specific Optimizations

### Web Optimization
- Lighthouse score targets
- Bundle size optimization
- SEO meta tags
- Progressive enhancement

### Mobile Optimization
- App size constraints
- Battery usage optimization
- Network efficiency
- Platform-specific performance tools

### Desktop Optimization
- Memory usage patterns
- Startup time optimization
- Native OS integration
- Multi-core utilization

### Terminal Optimization
- Execution speed
- Minimal dependencies
- Cross-shell compatibility
- Pipe performance

## Visual Analysis Protocol (Platform-Aware)

When analyzing inspiration images:

1. **Identify Platform Context**: Determine which platform the inspiration targets
2. **Extract Platform-Appropriate Principles**: 
   - Web: Responsive patterns, browser capabilities
   - Mobile: Touch targets, gesture hints
   - Desktop: Window layouts, menu structures
   - Terminal: Text layouts, ASCII art styles

3. **Adapt to Target Platform**: Transform inspiration to fit platform conventions
4. **Respect Platform Guidelines**: Honor HIG, Material Design, Windows Fluent, etc.

## Validation Checklist (Platform-Specific)

Before running `/run-spec-chain`, ensure:

✅ Target platform(s) clearly specified in APP_DETAILS.md
✅ Platform-appropriate tech stack selected
✅ UI conventions match target platform
✅ Performance targets suitable for platform
✅ Distribution method identified
✅ Platform-specific features leveraged
✅ Cross-platform strategy defined (if applicable)
✅ Accessibility standards for platform met

## Output Quality Markers (By Platform)

**Web Applications**:
- Responsive design documentation
- SEO optimization strategy
- Performance budget defined
- Browser compatibility matrix

**Mobile Applications**:
- Platform design compliance
- App store requirements met
- Offline functionality defined
- Device compatibility list

**Desktop Applications**:
- OS integration points documented
- Installation/update process defined
- System requirements specified
- Native feature utilization

**Terminal Applications**:
- Command structure documented
- Shell compatibility confirmed
- Pipe/compose examples provided
- Help system comprehensive

Remember: Excellence means honoring platform conventions while pushing creative boundaries within those constraints. The best applications feel native to their platform while offering innovative experiences.
