#!/usr/bin/env node

/**
 * Claude Spec Chain CLI
 * Command-line interface for managing spec-chain installations
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Colors for console output
const colors = {
    reset: '\x1b[0m',
    red: '\x1b[31m',
    green: '\x1b[32m',
    yellow: '\x1b[33m',
    blue: '\x1b[34m',
    cyan: '\x1b[36m'
};

// Helper functions
const log = {
    info: (msg) => console.log(`${colors.blue}ℹ${colors.reset} ${msg}`),
    success: (msg) => console.log(`${colors.green}✓${colors.reset} ${msg}`),
    warning: (msg) => console.log(`${colors.yellow}⚠${colors.reset} ${msg}`),
    error: (msg) => console.log(`${colors.red}✗${colors.reset} ${msg}`)
};

// Get the installation path of the npm package
const getPackagePath = () => {
    // When installed globally, the package is in node_modules
    const globalPath = path.join(__dirname, '..');
    if (fs.existsSync(path.join(globalPath, '.claude'))) {
        return globalPath;
    }
    
    // Fallback to local installation
    return process.cwd();
};

// Copy directory recursively
const copyRecursive = (src, dest, skipFiles = []) => {
    if (!fs.existsSync(src)) {
        throw new Error(`Source directory does not exist: ${src}`);
    }
    
    if (!fs.existsSync(dest)) {
        fs.mkdirSync(dest, { recursive: true });
    }
    
    const entries = fs.readdirSync(src, { withFileTypes: true });
    
    for (const entry of entries) {
        const srcPath = path.join(src, entry.name);
        const destPath = path.join(dest, entry.name);
        
        // Skip files in the skipFiles list
        if (skipFiles.includes(entry.name)) {
            continue;
        }
        
        if (entry.isDirectory()) {
            copyRecursive(srcPath, destPath, skipFiles);
        } else {
            fs.copyFileSync(srcPath, destPath);
        }
    }
};

// Commands
const commands = {
    install: (args) => {
        const force = args.includes('--force');
        const targetDir = process.cwd();
        const claudeDir = path.join(targetDir, '.claude');
        const specChainDir = path.join(claudeDir, 'commands', 'spec-chain');
        
        log.info('Installing spec-chain commands to current directory...');
        
        // Check for existing installation
        if (fs.existsSync(specChainDir) && !force) {
            log.warning('Spec-chain commands already exist in this directory');
            log.info('Use --force to overwrite existing installation');
            process.exit(1);
        }
        
        // Get source directory
        const packagePath = getPackagePath();
        const sourceDir = path.join(packagePath, '.claude');
        
        if (!fs.existsSync(sourceDir)) {
            log.error('Could not find .claude directory in package installation');
            log.error(`Looked in: ${packagePath}`);
            process.exit(1);
        }
        
        // Copy files
        try {
            if (fs.existsSync(specChainDir) && force) {
                fs.rmSync(specChainDir, { recursive: true, force: true });
                log.success('Removed existing installation');
            }
            
            // Copy files, skipping CLAUDE.md and prime.md to avoid conflicts
            copyRecursive(sourceDir, claudeDir, ['CLAUDE.md', 'prime.md']);
            log.success('Spec-chain commands installed successfully!');
            
            console.log('\nAvailable commands in Claude Code:');
            console.log('  /init-spec-chain     - Initialize a new spec-chain project');
            console.log('  /validate-spec-chain - Validate project setup');
            console.log('  /run-spec-chain      - Generate documentation');
            
            console.log('\nNote: Spec-chain commands are self-documenting. If you want Claude to have');
            console.log('specific context about spec-chain, you can add notes to your project\'s');
            console.log('.claude/CLAUDE.md file.');
            
        } catch (error) {
            log.error(`Installation failed: ${error.message}`);
            process.exit(1);
        }
    },
    
    update: () => {
        log.info('Checking for updates...');
        
        try {
            // Get current version
            const packageJson = require('../package.json');
            const currentVersion = packageJson.version;
            
            // Check npm for latest version
            const latestVersion = execSync('npm view claude-spec-chain version', { encoding: 'utf8' }).trim();
            
            if (currentVersion === latestVersion) {
                log.success(`Already using the latest version (${currentVersion})`);
            } else {
                log.info(`Current version: ${currentVersion}`);
                log.info(`Latest version: ${latestVersion}`);
                log.info('Run "npm update -g claude-spec-chain" to update');
            }
        } catch (error) {
            log.error('Failed to check for updates');
        }
    },
    
    version: () => {
        const packageJson = require('../package.json');
        console.log(`claude-spec-chain v${packageJson.version}`);
    },
    
    help: () => {
        console.log(`
${colors.cyan}Claude Spec Chain CLI${colors.reset}

${colors.yellow}Usage:${colors.reset}
  claude-spec-chain <command> [options]

${colors.yellow}Commands:${colors.reset}
  install [--force]  Install spec-chain commands to current directory
  update            Check for updates
  version           Show installed version
  help              Show this help message

${colors.yellow}Examples:${colors.reset}
  claude-spec-chain install          # Install to current directory
  claude-spec-chain install --force  # Force overwrite existing
  claude-spec-chain update          # Check for updates
  claude-spec-chain version         # Show version

${colors.yellow}More Information:${colors.reset}
  https://github.com/slamb2k/spec-chain
`);
    }
};

// Main CLI logic
const main = () => {
    const args = process.argv.slice(2);
    const command = args[0] || 'help';
    
    if (commands[command]) {
        commands[command](args.slice(1));
    } else {
        log.error(`Unknown command: ${command}`);
        commands.help();
        process.exit(1);
    }
};

// Run CLI
if (require.main === module) {
    main();
}