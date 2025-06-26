# Installing Spec Chain Claude Commands

This guide provides detailed instructions for installing the spec-chain commands for Claude Code. Choose the method that works best for your setup.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Quick Install](#quick-install)
- [Installation Methods](#installation-methods)
  - [npm (Recommended)](#npm-recommended)
  - [Shell Script](#shell-script)
  - [Manual Installation](#manual-installation)
  - [Git Clone](#git-clone)
- [Global vs Local Installation](#global-vs-local-installation)
- [Verifying Installation](#verifying-installation)
- [Updating](#updating)
- [Uninstalling](#uninstalling)
- [Troubleshooting](#troubleshooting)

## Prerequisites

- **Claude Code**: You must have access to [Claude Code](https://claude.ai/code)
- **Linux Environment**: Claude Code runs on Linux (including WSL for Windows users)
- **Project Directory**: A directory where you want to use spec-chain
- **Optional**: Node.js/npm for npm installation method

## Quick Install

### Shell Script (Linux/macOS/WSL)
```bash
curl -fsSL https://raw.githubusercontent.com/yourusername/spec-chain/main/install.sh | bash
```

### npm (Any Platform with Node.js)
```bash
npm install -g claude-spec-chain
claude-spec-chain install
```

**Note:** Windows users must use WSL (Windows Subsystem for Linux) as Claude Code only runs on Linux.

## Installation Methods

### npm (Recommended)

The npm package provides the easiest installation and update experience.

#### Global Installation

Install once, use in any project:

```bash
# Install globally
npm install -g claude-spec-chain

# Navigate to your project
cd your-project

# Install spec-chain commands
claude-spec-chain install
```

#### Local Installation

Install per project:

```bash
# In your project directory
npm install --save-dev claude-spec-chain

# Install commands
npx claude-spec-chain install
```

#### npm Commands

- `claude-spec-chain install` - Install commands to current directory
- `claude-spec-chain install --force` - Force overwrite existing installation
- `claude-spec-chain update` - Check for updates
- `claude-spec-chain version` - Show installed version
- `claude-spec-chain help` - Show help

### Shell Script

For Linux, macOS, and WSL (Windows Subsystem for Linux).

#### Local Installation (Default)

```bash
# Install to current directory
curl -fsSL https://raw.githubusercontent.com/yourusername/spec-chain/main/install.sh | bash
```

#### Global Installation

```bash
# Install globally
curl -fsSL https://raw.githubusercontent.com/yourusername/spec-chain/main/install.sh | bash -s -- --global

# Then in any project
claude-spec-chain install
```

#### Force Installation

```bash
# Overwrite existing installation
curl -fsSL https://raw.githubusercontent.com/yourusername/spec-chain/main/install.sh | bash -s -- --force
```


### Manual Installation

1. **Download the release:**
   - Go to [Releases](https://github.com/yourusername/spec-chain/releases)
   - Download `claude-commands.zip` or `claude-commands.tar.gz`

2. **Extract to your project:**
   ```bash
   # For zip
   unzip claude-commands.zip -d your-project/

   # For tar.gz
   tar -xzf claude-commands.tar.gz -C your-project/
   ```

3. **Verify structure:**
   Your project should now have:
   ```
   your-project/
   ├── .claude/
   │   ├── CLAUDE.md
   │   └── commands/
   │       ├── prime.md
   │       └── spec-chain/
   │           ├── COMMANDS.md
   │           └── [all command files]
   └── [your existing files]
   ```

### Git Clone

For developers who want the full repository:

```bash
# Clone the repository
git clone https://github.com/yourusername/spec-chain.git

# Copy just the .claude directory
cp -r spec-chain/.claude your-project/

# Or use as a git submodule
cd your-project
git submodule add https://github.com/yourusername/spec-chain .spec-chain-commands
ln -s .spec-chain-commands/.claude .claude
```

## Global vs Local Installation

### Local Installation (Default)
- Commands are copied to the current project's `.claude` directory
- Each project has its own copy
- Good for project-specific customization
- No cross-project dependencies

### Global Installation
- Commands are installed to `~/.claude-commands/spec-chain/`
- Single installation serves multiple projects
- Use `claude-spec-chain install` to copy to projects
- Easier updates with single location

## Verifying Installation

After installation, verify everything is working:

1. **Check files exist:**
   ```bash
   ls -la .claude/commands/spec-chain/
   ```

2. **Open in Claude Code:**
   Open your project directory in Claude Code

3. **Test commands:**
   Try running `/prime` to see if commands are recognized

4. **Initialize spec-chain:**
   Run `/init-spec-chain` to set up your first project

## Updating

### npm Method
```bash
# Check for updates
claude-spec-chain update

# Update global installation
npm update -g claude-spec-chain

# Update local installation
npm update claude-spec-chain
```

### Shell Script Method
```bash
# Reinstall with latest version
curl -fsSL https://raw.githubusercontent.com/yourusername/spec-chain/main/install.sh | bash -s -- --force
```


## Uninstalling

### Remove from Project
```bash
rm -rf .claude/commands/spec-chain
```

### Uninstall npm Package
```bash
# Global
npm uninstall -g claude-spec-chain

# Local
npm uninstall claude-spec-chain
```

### Remove Global Installation
```bash
# Unix/macOS/Linux
rm -rf ~/.claude-commands/spec-chain
rm -f ~/.local/bin/claude-spec-chain

```

## Troubleshooting

### Common Issues

#### "Command not found" after global installation
The global command might not be in your PATH. Add to your shell configuration:

```bash
# Bash/Zsh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

#### "Permission denied" errors when creating .spec-chain directory
Claude Code requires explicit permissions for new directories. If you get permission errors:

1. **Add permissions to your .claude/settings.local.json:**
```json
{
  "permissions": {
    "allow": [
      "Read(.spec-chain/**)",
      "Write(.spec-chain/**)",
      "Edit(.spec-chain/**)",
      "MultiEdit(.spec-chain/**)"
    ]
  }
}
```

2. **If settings.local.json doesn't exist, create it:**
```bash
mkdir -p .claude
echo '{
  "permissions": {
    "allow": [
      "Read(.spec-chain/**)",
      "Write(.spec-chain/**)",
      "Edit(.spec-chain/**)",
      "MultiEdit(.spec-chain/**)"
    ]
  }
}' > .claude/settings.local.json
```

3. **Restart Claude Code** after adding permissions

#### "Permission denied" for executable files
```bash
# Make scripts executable
chmod +x ~/.local/bin/claude-spec-chain

# Or reinstall with proper permissions
sudo npm install -g claude-spec-chain
```

#### Commands not showing in Claude Code
1. Ensure `.claude` directory is in your project root
2. Restart Claude Code
3. Check that files have correct structure
4. Verify no `.claudeignore` is blocking the commands

#### SSL/Certificate errors
```bash
# Bypass SSL for installation (not recommended for production)
curl -fsSL --insecure https://... | bash

# Or download manually and install
```

### Getting Help

1. Check the [README](https://github.com/yourusername/spec-chain/blob/main/README.md)
2. Review [closed issues](https://github.com/yourusername/spec-chain/issues?q=is%3Aissue+is%3Aclosed)
3. Open a [new issue](https://github.com/yourusername/spec-chain/issues/new)
4. Contact via [discussions](https://github.com/yourusername/spec-chain/discussions)

## Platform-Specific Notes

### macOS
- May need to allow script execution in System Preferences
- Use Homebrew for system-wide tools: `brew install node`

### Windows (via WSL)
- Claude Code requires WSL (Windows Subsystem for Linux)
- Install WSL: `wsl --install` in PowerShell as Administrator
- Use Linux instructions within WSL
- Access files from Windows at `\\wsl$\Ubuntu\...`

### Linux
- Package managers vary by distribution
- May need `sudo` for global npm installs
- Ensure `~/.local/bin` is in PATH

### WSL (Windows Subsystem for Linux)
- Use Linux instructions within WSL
- Files accessible from Windows at `\\wsl$\Ubuntu\...`
- Consider installing in Windows directory for Claude Code access

## Next Steps

After installation:

1. Run `/init-spec-chain` to initialize your project
2. Fill out `.spec-chain/APP_DETAILS.md`
3. Add inspiration materials (optional)
4. Run `/run-spec-chain` to generate documentation
5. Review generated specs in `.spec-chain/specs/`

For more details, see the [main documentation](https://github.com/yourusername/spec-chain#readme).