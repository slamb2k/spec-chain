# Changelog

All notable changes to spec-chain will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-01-XX

### Added
- Initial release of spec-chain Claude Code commands
- 9 document generation prompts for comprehensive software documentation
- Parallel execution support for improved performance
- Interactive APP_DETAILS.md gathering
- Iterative validation for implementation plans
- Multiple installation methods:
  - npm package with CLI tool
  - Shell script installer for Unix/macOS/Linux/WSL
  - PowerShell installer for Windows
  - Manual download options
- Global and local installation support
- Comprehensive documentation including README, INSTALL, and command guides

### Features
- `/init-spec-chain` - Initialize spec-chain in any directory
- `/validate-spec-chain` - Validate project setup
- `/run-spec-chain` - Generate documentation with parallel execution
- `/prime` - Prime Claude with project context
- Document generators:
  - PRD (Product Requirements Document)
  - Feature Stories
  - Technical Overview
  - Style Guide
  - UI States
  - UI Preview
  - Technical Specification
  - Implementation Plan with validation

### Technical
- Isolated `.spec-chain/` directory structure
- Embedded APP_DETAILS.md template
- Support for inspiration materials (visual/functional)
- Timestamped output directories
- Cross-platform compatibility