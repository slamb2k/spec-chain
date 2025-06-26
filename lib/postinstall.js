/**
 * Post-install script for claude-spec-chain
 * Shows usage instructions after npm installation
 */

const colors = {
    reset: '\x1b[0m',
    green: '\x1b[32m',
    yellow: '\x1b[33m',
    blue: '\x1b[34m',
    cyan: '\x1b[36m'
};

console.log(`
${colors.green}✓ claude-spec-chain installed successfully!${colors.reset}

${colors.cyan}Quick Start:${colors.reset}
1. Navigate to your project directory
2. Run: ${colors.yellow}claude-spec-chain install${colors.reset}
3. Open the project in Claude Code
4. Use ${colors.yellow}/init-spec-chain${colors.reset} to initialize

${colors.cyan}Available Commands:${colors.reset}
  ${colors.yellow}claude-spec-chain install${colors.reset}   Install commands to current directory
  ${colors.yellow}claude-spec-chain update${colors.reset}    Check for updates
  ${colors.yellow}claude-spec-chain version${colors.reset}   Show version
  ${colors.yellow}claude-spec-chain help${colors.reset}      Show help

${colors.yellow}Permission Note:${colors.reset}
If you encounter permission errors with .spec-chain directory,
add this to your .claude/settings.local.json:

  "permissions": {
    "allow": [
      "Read(.spec-chain/**)",
      "Write(.spec-chain/**)",
      "Edit(.spec-chain/**)",
      "MultiEdit(.spec-chain/**)",
      "Bash(mkdir:.spec-chain/**)",
      "Bash(ls:.spec-chain/**)",
      "Bash(pwd)",
      "Bash(cp:.spec-chain/**)",
      "Bash(echo:*)",
      "Bash(date)",
      "Bash(test:.spec-chain/**)"
    ]
  }

${colors.cyan}More Information:${colors.reset}
  https://github.com/yourusername/spec-chain
`);