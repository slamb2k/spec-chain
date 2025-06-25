# Validate Spec Chain Setup

This command validates that all required files, directories, and fields are properly configured for the Spec Chain documentation generator.

## What This Command Validates

1. **Directory Structure**: Checks for required .spec-chain directories
2. **File Existence**: Verifies all necessary files are present in .spec-chain
3. **.spec-chain/APP_DETAILS.md Completeness**: Validates that all required fields are populated
4. **Inspiration Assets**: Checks for presence of inspiration materials
5. **Previous Generations**: Reviews documentation history

## How Validation Works

This command uses Claude Code's file system tools (Read, LS, Glob) to perform all validations without requiring user confirmation or executing shell commands. The validation process:

1. Checks each required directory using the LS tool
2. Reads files to verify content and structure
3. Uses pattern matching to validate field completeness
4. Generates a comprehensive report with clear status indicators

## Validation Process

### 1. Directory Structure Check

The following directories are validated:
- `.spec-chain` - Root directory for spec-chain project
- `.spec-chain/specs` - For generated documentation output
- `.spec-chain/assets/inspiration/visual` - For visual inspiration materials
- `.spec-chain/assets/inspiration/functional` - For functional inspiration materials
- `.claude/commands/spec-chain` - For spec-chain command files (in the spec-chain package)

### 2. Required Files Check

Validates the existence and quality of:
- **.spec-chain/APP_DETAILS.md** - The actual project configuration file
- **Spec-chain prompts** (9 files in `.claude/commands/spec-chain/`)

### 3. .spec-chain/APP_DETAILS.md Content Validation

Examines each required field for:
- ❌ **Missing**: Field header not found
- ⚠️ **Empty**: Contains only placeholders or instructions
- ✅ **Filled**: Contains substantial content

### 4. Inspiration Assets Check

Counts and categorizes files in inspiration directories:
- Images (PNG, JPG, JPEG, GIF)
- HTML files
- PDF documents

### 5. Readiness Analysis

Based on .spec-chain/APP_DETAILS.md completeness:
- **< 50% Complete**: Recommends completing interactive information gathering first
- **≥ 50% Complete**: Ready for comprehensive documentation generation

### 6. Summary Report

Provides:
- Total counts of errors, warnings, and passed validations
- Specific recommendations based on findings
- Clear next steps for addressing any issues

## Output Format

The validation report uses:
- ✅ Green checkmarks for passed validations
- ⚠️ Warning symbols for non-critical issues
- ❌ Red X marks for critical failures
- 📁 📄 📋 🎨 📊 📈 Icons for different sections
- Formatted tables for clear presentation

## Success Criteria

Validation is successful when:
- All required directories exist
- .spec-chain/APP_DETAILS.md exists with substantial content
- All 9 spec-chain prompts are present
- No critical errors are found

## Error Handling

- Missing directories or files are clearly reported
- Specific fixes are suggested for each issue
- Validation continues even if some checks fail
- Non-critical warnings don't prevent documentation generation