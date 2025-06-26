# Changelog

All notable changes to spec-chain will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.0.0] - 2025-01-XX

### 🎯 Major Features
- **Isolated Project Structure**: Complete isolation with `.spec-chain/` directory
- **Clean Deployment Strategy**: Only core commands deployed, development files excluded
- **Enhanced Documentation**: Comprehensive README, INSTALL, and CLAUDE guidance
- **Multiple Installation Methods**: npm, shell script, GitHub releases, manual download

### ✨ Added
- **Project Isolation**: All spec-chain files now in `.spec-chain/` directory
- **Clean Installation**: Only `.claude/commands/spec-chain/` deployed to user projects
- **Development Separation**: `prime.md`, `CLAUDE.md`, `settings.local.json` excluded from packages
- **Repository Structure**: Clear separation between development and user experience
- **Enhanced Permissions**: Dynamic permission requests with optional pre-configuration
- **Comprehensive Documentation**: Updated README, INSTALL, CLAUDE, and COMMANDS guides

### 🔄 Changed
- **Directory Structure**: Moved from project root to `.spec-chain/` isolation
- **Deployment Strategy**: Simplified to include only core commands
- **File Organization**: Moved COMMANDS.md to spec-chain subdirectory
- **Installation Process**: Streamlined with consistent exclusions across all methods
- **Documentation Flow**: Improved structure and reduced redundancy

### 🛠️ Technical Improvements
- **npm Package**: Only includes `.claude/commands/spec-chain/` directory
- **GitHub Releases**: Clean archives with proper structure
- **Shell Script**: Downloads only core command files
- **CLI Tool**: Creates proper directory structure on installation

## [2.0.0] - 2024-12-XX

### 🚀 Performance & Architecture
- **File-Based Architecture**: Simplified execution with file-based loading
- **Parallel Execution**: Task agents for independent document generation
- **Iterative Validation**: Implementation plan validation with up to 5 iterations
- **Interactive Setup**: Dynamic APP_DETAILS.md gathering

### ✨ Added
- **Parallel Processing**: 25-33% faster generation using Task agents
- **Single Argument Interface**: All prompts use consistent spec-name parameter
- **Validation Loop**: Quality assurance for implementation plans
- **Auto-Research**: Optional field auto-completion
- **Playbook Integration**: Development rules and guidelines integration

### 🔄 Changed
- **Execution Flow**: Optimized phases with parallel execution where possible
- **Command Interface**: Simplified to single argument pattern
- **File Persistence**: Automatic saving to timestamped directories
- **Dependencies**: Smart dependency management between prompts

## [1.0.0] - 2024-11-XX

### 🎉 Initial Release
- **Core Commands**: `/init-spec-chain`, `/validate-spec-chain`, `/run-spec-chain`
- **Document Generators**: 9 specialized prompts for 8 core documents
- **Installation Methods**: Multiple installation options
- **Documentation**: Comprehensive guides and examples

### 📋 Features
- **PRD Generation**: Product Requirements Document
- **Feature Stories**: Detailed user scenarios
- **Technical Docs**: Architecture and specifications
- **UI/UX Guides**: Style guides and state documentation
- **Implementation Plans**: AI-optimized development planning

### 🛠️ Technical Foundation
- **Claude Code Integration**: Custom command system
- **Template System**: Embedded APP_DETAILS.md template
- **Inspiration Support**: Visual and functional reference materials
- **Cross-Platform**: Linux, macOS, WSL compatibility
