#!/usr/bin/env bash

# Spec Chain Claude Commands Installer
# This script installs the .claude directory with spec-chain commands
# Usage: curl -fsSL https://raw.githubusercontent.com/yourusername/spec-chain/main/install.sh | bash
# Or: ./install.sh [--global] [--force]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/yourusername/spec-chain"
REPO_RAW_URL="https://raw.githubusercontent.com/yourusername/spec-chain/main"
CLAUDE_DIR=".claude"
COMMANDS_DIR="$CLAUDE_DIR/commands"
SPEC_CHAIN_DIR="$COMMANDS_DIR/spec-chain"

# Default values
INSTALL_MODE="local"
FORCE_INSTALL=false
INSTALL_PATH=""

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --global) INSTALL_MODE="global"; shift ;;
        --force) FORCE_INSTALL=true; shift ;;
        --help) 
            echo "Spec Chain Claude Commands Installer"
            echo ""
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  --global    Install globally to ~/.claude-commands/spec-chain"
            echo "  --force     Force installation, overwriting existing files"
            echo "  --help      Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0                    # Install to current directory"
            echo "  $0 --global           # Install globally"
            echo "  $0 --force            # Force overwrite existing installation"
            exit 0
            ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
done

# Determine installation path
if [ "$INSTALL_MODE" = "global" ]; then
    INSTALL_PATH="$HOME/.claude-commands/spec-chain"
    echo -e "${BLUE}Installing spec-chain commands globally to: $INSTALL_PATH${NC}"
else
    INSTALL_PATH="."
    echo -e "${BLUE}Installing spec-chain commands to current directory${NC}"
fi

# Function to print colored output
print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Function to download a file
download_file() {
    local url=$1
    local output=$2
    
    if command -v curl &> /dev/null; then
        curl -fsSL "$url" -o "$output"
    elif command -v wget &> /dev/null; then
        wget -q "$url" -O "$output"
    else
        print_error "Neither curl nor wget found. Please install one of them."
        exit 1
    fi
}

# Function to create directory if it doesn't exist
ensure_dir() {
    local dir=$1
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        print_status "Created directory: $dir"
    fi
}

# Check if Claude commands already exist
check_existing_installation() {
    local claude_path="$INSTALL_PATH/$CLAUDE_DIR"
    local spec_chain_path="$INSTALL_PATH/$SPEC_CHAIN_DIR"
    
    if [ -d "$spec_chain_path" ] && [ "$FORCE_INSTALL" = false ]; then
        print_warning "Spec-chain commands already exist at: $spec_chain_path"
        echo ""
        echo "Options:"
        echo "1) Backup existing and install new version"
        echo "2) Overwrite existing installation"
        echo "3) Cancel installation"
        echo ""
        read -p "Choose an option (1-3): " choice
        
        case $choice in
            1)
                local backup_dir="${spec_chain_path}_backup_$(date +%Y%m%d_%H%M%S)"
                mv "$spec_chain_path" "$backup_dir"
                print_status "Backed up existing installation to: $backup_dir"
                ;;
            2)
                rm -rf "$spec_chain_path"
                print_status "Removed existing installation"
                ;;
            3)
                echo "Installation cancelled"
                exit 0
                ;;
            *)
                print_error "Invalid choice. Installation cancelled."
                exit 1
                ;;
        esac
    elif [ -d "$spec_chain_path" ] && [ "$FORCE_INSTALL" = true ]; then
        rm -rf "$spec_chain_path"
        print_status "Removed existing installation (--force)"
    fi
}

# Download and install files
install_files() {
    echo ""
    echo "Downloading spec-chain commands..."
    
    # Create directories
    ensure_dir "$INSTALL_PATH/$COMMANDS_DIR"
    ensure_dir "$INSTALL_PATH/$SPEC_CHAIN_DIR"
    
    # List of files to download
    local files=(
        "commands/spec-chain/COMMANDS.md"
        "commands/spec-chain/init-spec-chain.md"
        "commands/spec-chain/validate-spec-chain.md"
        "commands/spec-chain/run-spec-chain.md"
        "commands/spec-chain/doc-prompt-prd.md"
        "commands/spec-chain/doc-prompt-feature-stories.md"
        "commands/spec-chain/doc-prompt-technical-overview.md"
        "commands/spec-chain/doc-prompt-style.md"
        "commands/spec-chain/doc-prompt-states.md"
        "commands/spec-chain/doc-prompt-ui-preview.md"
        "commands/spec-chain/doc-prompt-technical.md"
        "commands/spec-chain/doc-prompt-planner.md"
        "commands/spec-chain/doc-prompt-planner-validator.md"
    )
    
    # Download each file
    local total=${#files[@]}
    local count=0
    
    for file in "${files[@]}"; do
        count=$((count + 1))
        echo -ne "\rDownloading files... [$count/$total]"
        
        local url="$REPO_RAW_URL/.claude/$file"
        local output="$INSTALL_PATH/$CLAUDE_DIR/$file"
        
        # Ensure parent directory exists
        ensure_dir "$(dirname "$output")"
        
        if download_file "$url" "$output"; then
            :
        else
            echo ""
            print_error "Failed to download: $file"
            exit 1
        fi
    done
    
    echo ""
    print_status "Downloaded all spec-chain command files"
}

# Create global command if installing globally
create_global_command() {
    if [ "$INSTALL_MODE" = "global" ]; then
        local bin_dir="$HOME/.local/bin"
        ensure_dir "$bin_dir"
        
        # Create claude-spec-chain command
        cat > "$bin_dir/claude-spec-chain" << 'EOF'
#!/usr/bin/env bash
# Claude Spec Chain Command
# This command helps manage spec-chain installation in projects

GLOBAL_INSTALL="$HOME/.claude-commands/spec-chain"

case "$1" in
    install)
        if [ ! -d "$GLOBAL_INSTALL/.claude" ]; then
            echo "Error: Global spec-chain installation not found at $GLOBAL_INSTALL"
            echo "Please run: curl -fsSL https://raw.githubusercontent.com/yourusername/spec-chain/main/install.sh | bash -s -- --global"
            exit 1
        fi
        
        echo "Copying spec-chain commands to current directory..."
        cp -r "$GLOBAL_INSTALL/.claude" .
        echo "✓ Spec-chain commands installed to ./.claude/"
        ;;
    
    update)
        echo "Updating global spec-chain installation..."
        cd "$GLOBAL_INSTALL" && git pull || {
            echo "Reinstalling spec-chain..."
            rm -rf "$GLOBAL_INSTALL"
            curl -fsSL https://raw.githubusercontent.com/yourusername/spec-chain/main/install.sh | bash -s -- --global
        }
        ;;
    
    version)
        if [ -f "$GLOBAL_INSTALL/.claude/.version" ]; then
            cat "$GLOBAL_INSTALL/.claude/.version"
        else
            echo "Version information not found"
        fi
        ;;
    
    *)
        echo "Claude Spec Chain Command Manager"
        echo ""
        echo "Usage: claude-spec-chain [command]"
        echo ""
        echo "Commands:"
        echo "  install    Copy spec-chain commands to current directory"
        echo "  update     Update global spec-chain installation"
        echo "  version    Show installed version"
        echo ""
        echo "Global installation path: $GLOBAL_INSTALL"
        ;;
esac
EOF
        
        chmod +x "$bin_dir/claude-spec-chain"
        print_status "Created global command: claude-spec-chain"
        
        # Check if bin directory is in PATH
        if [[ ":$PATH:" != *":$bin_dir:"* ]]; then
            print_warning "$bin_dir is not in your PATH"
            echo ""
            echo "Add this line to your shell configuration file (.bashrc, .zshrc, etc.):"
            echo "export PATH=\"\$HOME/.local/bin:\$PATH\""
        fi
    fi
}

# Main installation process
main() {
    echo ""
    echo "🚀 Spec Chain Claude Commands Installer"
    echo "======================================"
    echo ""
    
    # Check for existing installation
    check_existing_installation
    
    # Install files
    install_files
    
    # Create version file
    echo "v1.0.0" > "$INSTALL_PATH/$CLAUDE_DIR/.version"
    
    # Create global command if needed
    create_global_command
    
    # Success message
    echo ""
    echo "🎉 Installation complete!"
    echo ""
    
    if [ "$INSTALL_MODE" = "global" ]; then
        echo "Spec-chain commands installed globally to: $INSTALL_PATH"
        echo ""
        echo "To use in a project:"
        echo "  cd your-project"
        echo "  claude-spec-chain install"
        echo ""
        echo "To update the global installation:"
        echo "  claude-spec-chain update"
    else
        echo "Spec-chain commands installed to: $INSTALL_PATH/$CLAUDE_DIR"
        echo ""
        echo "Available commands in Claude Code:"
        echo "  /init-spec-chain    - Initialize a new spec-chain project"
        echo "  /validate-spec-chain - Validate project setup"
        echo "  /run-spec-chain     - Generate documentation"
        echo ""
        echo "To get started:"
        echo "  1. Open this directory in Claude Code"
        echo "  2. Run /init-spec-chain to set up your project"
        echo "  3. Fill out spec-chain/APP_DETAILS.md"
        echo "  4. Run /run-spec-chain to generate documentation"
    fi
    
    echo ""
    echo "Note: Spec-chain commands are self-documenting. If you want Claude to have"
    echo "specific context about spec-chain, you can add notes to your project's"
    echo ".claude/CLAUDE.md file."
    echo ""
    print_warning "Permission Configuration (if needed):"
    echo "If you encounter permission errors when spec-chain tries to create the spec-chain"
    echo "directory, add this to your .claude/settings.local.json:"
    echo ""
    echo '  "permissions": {'
    echo '    "allow": ['
    echo '      "Read(spec-chain/**)",'
    echo '      "Write(spec-chain/**)",'
    echo '      "Edit(spec-chain/**)",'
    echo '      "MultiEdit(spec-chain/**)",'
    echo '      "Bash(mkdir:spec-chain/**)",'
    echo '      "Bash(ls:spec-chain/**)",'
    echo '      "Bash(pwd)",'
    echo '      "Bash(cp:spec-chain/**)",'
    echo '      "Bash(echo:*)",'
    echo '      "Bash(date)",'
    echo '      "Bash(test:spec-chain/**)"'
    echo '    ]'
    echo '  }'
    echo ""
    echo "For more information, visit: $REPO_URL"
}

# Run main installation
main