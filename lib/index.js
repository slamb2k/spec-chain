/**
 * Main entry point for claude-spec-chain npm package
 * This file exports utilities that could be used programmatically
 */

const fs = require('fs');
const path = require('path');

module.exports = {
    // Get the path to the .claude directory in the package
    getClaudePath: () => {
        return path.join(__dirname, '..', '.claude');
    },
    
    // Check if spec-chain is installed in a directory
    isInstalled: (dir = process.cwd()) => {
        const specChainPath = path.join(dir, '.claude', 'commands', 'spec-chain');
        return fs.existsSync(specChainPath);
    },
    
    // Get installed version
    getVersion: () => {
        const packageJson = require('../package.json');
        return packageJson.version;
    }
};