# Spec Chain Claude Commands Installer for Windows
# This script installs the .claude directory with spec-chain commands
# Usage: irm https://raw.githubusercontent.com/yourusername/spec-chain/main/install.ps1 | iex
# Or: .\install.ps1 [-Global] [-Force]

param(
    [switch]$Global,
    [switch]$Force,
    [switch]$Help
)

# Configuration
$RepoUrl = "https://github.com/yourusername/spec-chain"
$RepoRawUrl = "https://raw.githubusercontent.com/yourusername/spec-chain/main"
$ClaudeDir = ".claude"
$CommandsDir = "$ClaudeDir\commands"
$SpecChainDir = "$CommandsDir\spec-chain"

# Colors for output
$Host.UI.RawUI.WindowTitle = "Spec Chain Installer"

function Write-Status {
    param([string]$Message)
    Write-Host "✓ " -ForegroundColor Green -NoNewline
    Write-Host $Message
}

function Write-Error {
    param([string]$Message)
    Write-Host "✗ " -ForegroundColor Red -NoNewline
    Write-Host $Message
}

function Write-Warning {
    param([string]$Message)
    Write-Host "⚠ " -ForegroundColor Yellow -NoNewline
    Write-Host $Message
}

# Show help if requested
if ($Help) {
    Write-Host "Spec Chain Claude Commands Installer" -ForegroundColor Blue
    Write-Host ""
    Write-Host "Usage: .\install.ps1 [options]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -Global    Install globally to ~\.claude-commands\spec-chain"
    Write-Host "  -Force     Force installation, overwriting existing files"
    Write-Host "  -Help      Show this help message"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\install.ps1                # Install to current directory"
    Write-Host "  .\install.ps1 -Global        # Install globally"
    Write-Host "  .\install.ps1 -Force         # Force overwrite existing installation"
    exit 0
}

# Determine installation path
if ($Global) {
    $InstallPath = "$env:USERPROFILE\.claude-commands\spec-chain"
    Write-Host "Installing spec-chain commands globally to: $InstallPath" -ForegroundColor Blue
} else {
    $InstallPath = "."
    Write-Host "Installing spec-chain commands to current directory" -ForegroundColor Blue
}

# Function to download a file
function Download-File {
    param(
        [string]$Url,
        [string]$Output
    )
    
    try {
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri $Url -OutFile $Output -UseBasicParsing
        $ProgressPreference = 'Continue'
        return $true
    } catch {
        Write-Error "Failed to download: $Url"
        Write-Error $_.Exception.Message
        return $false
    }
}

# Function to ensure directory exists
function Ensure-Directory {
    param([string]$Path)
    
    if (!(Test-Path -Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
        Write-Status "Created directory: $Path"
    }
}

# Check for existing installation
function Check-ExistingInstallation {
    $SpecChainPath = Join-Path $InstallPath $SpecChainDir
    
    if ((Test-Path -Path $SpecChainPath) -and !$Force) {
        Write-Warning "Spec-chain commands already exist at: $SpecChainPath"
        Write-Host ""
        Write-Host "Options:"
        Write-Host "1) Backup existing and install new version"
        Write-Host "2) Overwrite existing installation"
        Write-Host "3) Cancel installation"
        Write-Host ""
        
        $choice = Read-Host "Choose an option (1-3)"
        
        switch ($choice) {
            "1" {
                $backupDir = "${SpecChainPath}_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
                Move-Item -Path $SpecChainPath -Destination $backupDir
                Write-Status "Backed up existing installation to: $backupDir"
            }
            "2" {
                Remove-Item -Path $SpecChainPath -Recurse -Force
                Write-Status "Removed existing installation"
            }
            "3" {
                Write-Host "Installation cancelled"
                exit 0
            }
            default {
                Write-Error "Invalid choice. Installation cancelled."
                exit 1
            }
        }
    } elseif ((Test-Path -Path $SpecChainPath) -and $Force) {
        Remove-Item -Path $SpecChainPath -Recurse -Force
        Write-Status "Removed existing installation (--force)"
    }
}

# Download and install files
function Install-Files {
    Write-Host ""
    Write-Host "Downloading spec-chain commands..."
    
    # Create directories
    Ensure-Directory (Join-Path $InstallPath $CommandsDir)
    Ensure-Directory (Join-Path $InstallPath $SpecChainDir)
    
    # List of files to download
    $files = @(
        "CLAUDE.md",
        "commands\COMMANDS.md",
        "commands\prime.md",
        "commands\spec-chain\init-spec-chain.md",
        "commands\spec-chain\validate-spec-chain.md",
        "commands\spec-chain\run-spec-chain.md",
        "commands\spec-chain\doc-prompt-prd.md",
        "commands\spec-chain\doc-prompt-feature-stories.md",
        "commands\spec-chain\doc-prompt-technical-overview.md",
        "commands\spec-chain\doc-prompt-style.md",
        "commands\spec-chain\doc-prompt-states.md",
        "commands\spec-chain\doc-prompt-ui-preview.md",
        "commands\spec-chain\doc-prompt-technical.md",
        "commands\spec-chain\doc-prompt-planner.md",
        "commands\spec-chain\doc-prompt-planner-validator.md"
    )
    
    # Download each file
    $total = $files.Count
    $count = 0
    $failed = $false
    
    foreach ($file in $files) {
        $count++
        Write-Progress -Activity "Downloading files" -Status "$count of $total" -PercentComplete (($count / $total) * 100)
        
        $url = "$RepoRawUrl/.claude/$file"
        $output = Join-Path $InstallPath "$ClaudeDir\$file"
        
        # Ensure parent directory exists
        $parentDir = Split-Path -Parent $output
        Ensure-Directory $parentDir
        
        if (!(Download-File -Url $url -Output $output)) {
            $failed = $true
            break
        }
    }
    
    Write-Progress -Activity "Downloading files" -Completed
    
    if ($failed) {
        Write-Error "Installation failed due to download errors"
        exit 1
    }
    
    Write-Status "Downloaded all spec-chain command files"
}

# Create global command if installing globally
function Create-GlobalCommand {
    if ($Global) {
        $binDir = "$env:USERPROFILE\.local\bin"
        Ensure-Directory $binDir
        
        # Create claude-spec-chain.ps1
        $scriptPath = Join-Path $binDir "claude-spec-chain.ps1"
        
        @'
# Claude Spec Chain Command
# This command helps manage spec-chain installation in projects

param(
    [string]$Command = "help"
)

$GlobalInstall = "$env:USERPROFILE\.claude-commands\spec-chain"

switch ($Command) {
    "install" {
        if (!(Test-Path "$GlobalInstall\.claude")) {
            Write-Host "Error: Global spec-chain installation not found at $GlobalInstall" -ForegroundColor Red
            Write-Host "Please run: irm https://raw.githubusercontent.com/yourusername/spec-chain/main/install.ps1 | iex -Global"
            exit 1
        }
        
        Write-Host "Copying spec-chain commands to current directory..."
        Copy-Item -Path "$GlobalInstall\.claude" -Destination "." -Recurse -Force
        Write-Host "✓ Spec-chain commands installed to .\.claude\" -ForegroundColor Green
    }
    
    "update" {
        Write-Host "Updating global spec-chain installation..."
        if (Test-Path "$GlobalInstall\.git") {
            Push-Location $GlobalInstall
            git pull
            Pop-Location
        } else {
            Write-Host "Reinstalling spec-chain..."
            Remove-Item -Path $GlobalInstall -Recurse -Force -ErrorAction SilentlyContinue
            & ([scriptblock]::Create((irm https://raw.githubusercontent.com/yourusername/spec-chain/main/install.ps1))) -Global
        }
    }
    
    "version" {
        if (Test-Path "$GlobalInstall\.claude\.version") {
            Get-Content "$GlobalInstall\.claude\.version"
        } else {
            Write-Host "Version information not found"
        }
    }
    
    default {
        Write-Host "Claude Spec Chain Command Manager" -ForegroundColor Blue
        Write-Host ""
        Write-Host "Usage: claude-spec-chain [command]"
        Write-Host ""
        Write-Host "Commands:"
        Write-Host "  install    Copy spec-chain commands to current directory"
        Write-Host "  update     Update global spec-chain installation"
        Write-Host "  version    Show installed version"
        Write-Host ""
        Write-Host "Global installation path: $GlobalInstall"
    }
}
'@ | Set-Content -Path $scriptPath
        
        Write-Status "Created global command: claude-spec-chain.ps1"
        
        # Create batch wrapper for easier execution
        $batchPath = Join-Path $binDir "claude-spec-chain.cmd"
        '@echo off
powershell -ExecutionPolicy Bypass -File "%~dp0claude-spec-chain.ps1" %*
' | Set-Content -Path $batchPath
        
        Write-Status "Created global command: claude-spec-chain.cmd"
        
        # Check if bin directory is in PATH
        $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
        if ($currentPath -notlike "*$binDir*") {
            Write-Warning "$binDir is not in your PATH"
            Write-Host ""
            Write-Host "To add it to your PATH, run:" -ForegroundColor Yellow
            Write-Host '[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$env:USERPROFILE\.local\bin", "User")'
            Write-Host ""
            Write-Host "Then restart your terminal for the changes to take effect."
        }
    }
}

# Main installation process
function Main {
    Write-Host ""
    Write-Host "🚀 Spec Chain Claude Commands Installer" -ForegroundColor Cyan
    Write-Host "======================================" -ForegroundColor Cyan
    Write-Host ""
    
    # Check for existing installation
    Check-ExistingInstallation
    
    # Install files
    Install-Files
    
    # Create version file
    "v1.0.0" | Set-Content -Path (Join-Path $InstallPath "$ClaudeDir\.version")
    
    # Create global command if needed
    Create-GlobalCommand
    
    # Success message
    Write-Host ""
    Write-Host "🎉 Installation complete!" -ForegroundColor Green
    Write-Host ""
    
    if ($Global) {
        Write-Host "Spec-chain commands installed globally to: $InstallPath"
        Write-Host ""
        Write-Host "To use in a project:"
        Write-Host "  cd your-project"
        Write-Host "  claude-spec-chain install"
        Write-Host ""
        Write-Host "To update the global installation:"
        Write-Host "  claude-spec-chain update"
    } else {
        Write-Host "Spec-chain commands installed to: $InstallPath\$ClaudeDir"
        Write-Host ""
        Write-Host "Available commands in Claude Code:" -ForegroundColor Blue
        Write-Host "  /init-spec-chain    - Initialize a new spec-chain project"
        Write-Host "  /validate-spec-chain - Validate project setup"
        Write-Host "  /run-spec-chain     - Generate documentation"
        Write-Host "  /prime             - Prime Claude with project context"
        Write-Host ""
        Write-Host "To get started:" -ForegroundColor Yellow
        Write-Host "  1. Open this directory in Claude Code"
        Write-Host "  2. Run /init-spec-chain to set up your project"
        Write-Host "  3. Fill out .spec-chain\APP_DETAILS.md"
        Write-Host "  4. Run /run-spec-chain to generate documentation"
    }
    
    Write-Host ""
    Write-Host "For more information, visit: $RepoUrl"
}

# Run main installation
Main