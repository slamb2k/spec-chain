# Validate Spec Chain Setup

This command validates that all required files, directories, and fields are properly configured for the Spec Chain documentation generator.

## What This Command Validates

1. **Directory Structure**: Checks for required directories
2. **File Existence**: Verifies all necessary files are present
3. **APP_DETAILS.md Completeness**: Validates that all required fields are populated
4. **Inspiration Assets**: Checks for presence of inspiration materials
5. **Permissions**: Verifies read/write access to required directories

## Validation Steps

### 1. Check Directory Structure

```bash
# Check main directories
DIRS_TO_CHECK=(
    "/specs"
    "/assets/inspiration/visual"
    "/assets/inspiration/functional"
    "/.claude/commands/spec-chain"
)

echo "# 📁 Directory Structure Validation"
echo ""
echo "| Directory | Status | Notes |"
echo "|-----------|---------|-------|"

for dir in "${DIRS_TO_CHECK[@]}"; do
    if [ -d "$dir" ]; then
        if [ -w "$dir" ]; then
            echo "| $dir | ✅ Exists | Writable |"
        else
            echo "| $dir | ⚠️  Exists | Not writable |"
        fi
    else
        echo "| $dir | ❌ Missing | Required |"
    fi
done
```

### 2. Check Required Files

```bash
echo ""
echo "# 📄 Required Files Validation"
echo ""
echo "| File | Status | Size |"
echo "|------|---------|------|"

# Check APP_DETAILS.md.template
if [ -f "/APP_DETAILS.md.template" ]; then
    template_size=$(wc -c < "/APP_DETAILS.md.template" | tr -d ' ')
    echo "| /APP_DETAILS.md.template | ✅ Exists | ${template_size} bytes |"
else
    echo "| /APP_DETAILS.md.template | ❌ Missing | Template file required |"
fi

# Check APP_DETAILS.md
if [ -f "/APP_DETAILS.md" ]; then
    size=$(wc -c < "/APP_DETAILS.md" | tr -d ' ')
    if [ $size -gt 100 ]; then
        echo "| /APP_DETAILS.md | ✅ Exists | ${size} bytes |"

        # Validate structure against template if template exists
        if [ -f "/APP_DETAILS.md.template" ]; then
            echo ""
            echo "# 🔍 APP_DETAILS.md Structure Validation"
            echo ""
            echo "| Check | Status | Details |"
            echo "|-------|---------|---------|"

            # Extract section headers from template (excluding warning block)
            TEMPLATE_SECTIONS=$(sed '/^<!--$/,/^-->$/d' /APP_DETAILS.md.template | grep -E '^##|^###' | sort)
            CURRENT_SECTIONS=$(grep -E '^##|^###' /APP_DETAILS.md | sort)

            # Find missing sections
            MISSING_SECTIONS=$(comm -23 <(echo "$TEMPLATE_SECTIONS") <(echo "$CURRENT_SECTIONS"))

            if [ -n "$MISSING_SECTIONS" ]; then
                missing_count=$(echo "$MISSING_SECTIONS" | wc -l)
                echo "| Section Structure | ⚠️  Incomplete | $missing_count sections missing |"
                echo "| Missing Sections | ❌ Found | See details below |"
                echo ""
                echo "**Missing sections that should be restored:**"
                echo "\`\`\`"
                echo "$MISSING_SECTIONS"
                echo "\`\`\`"
                echo ""
                echo "**Recommendation:** Run \`init-spec-chain\` to restore missing sections from template."
            else
                echo "| Section Structure | ✅ Complete | All template sections present |"
            fi
        fi
    else
        echo "| /APP_DETAILS.md | ⚠️  Exists | Only ${size} bytes - likely empty |"
    fi
else
    echo "| /APP_DETAILS.md | ❌ Missing | Required |"
fi

# Check spec-chain prompts
PROMPTS=(
    "doc-prompt-prd.md"
    "doc-prompt-gtm.md"
    "doc-prompt-business-rules.md"
    "doc-prompt-style.md"
    "doc-prompt-wireframes.md"
    "doc-prompt-user-flows.md"
    "doc-prompt-ia.md"
    "doc-prompt-component-library.md"
    "doc-prompt-technical.md"
    "doc-prompt-api.md"
    "doc-prompt-data-model.md"
    "doc-prompt-security.md"
    "doc-prompt-integrations.md"
    "doc-prompt-performance.md"
    "doc-prompt-preview.md"
    "doc-prompt-implementation.md"
    "doc-prompt-testing.md"
    "doc-prompt-devops.md"
    "doc-prompt-onboarding.md"
)

missing_prompts=0
for prompt in "${PROMPTS[@]}"; do
    if [ ! -f "/.claude/commands/spec-chain/$prompt" ]; then
        missing_prompts=$((missing_prompts + 1))
    fi
done

if [ $missing_prompts -eq 0 ]; then
    echo "| Spec-chain prompts (19 files) | ✅ All present | 19/19 found |"
else
    echo "| Spec-chain prompts | ⚠️  Incomplete | $((19 - missing_prompts))/19 found |"
fi
```

### 3. Validate APP_DETAILS.md Content

```bash
echo ""
echo "# 📋 APP_DETAILS.md Content Validation"
echo ""
echo "| Section | Field | Status | Notes |"
echo "|---------|-------|---------|-------|"

# Read APP_DETAILS.md content
if [ -f "/APP_DETAILS.md" ]; then
    content=$(cat "/APP_DETAILS.md")
    
    # Function to check if a section has content (not just placeholder)
    check_field() {
        section=$1
        field=$2
        pattern=$3
        
        if echo "$content" | grep -A 5 "$pattern" | grep -E "\[.*\]|Example:|INSTRUCTIONS:" > /dev/null; then
            echo "| $section | $field | ⚠️  Empty | Contains placeholder |"
        elif echo "$content" | grep -A 5 "$pattern" | grep -E "[A-Za-z0-9]{10,}" > /dev/null; then
            echo "| $section | $field | ✅ Filled | |"
        else
            echo "| $section | $field | ❌ Missing | Required field |"
        fi
    }
    
    # Check all required fields
    check_field "Basic Info" "App Name" "### App Name"
    check_field "Basic Info" "App Idea" "### App Idea"
    check_field "Basic Info" "MVP Features" "### MVP Features"
    
    check_field "Target Users" "Primary Users" "### Primary Users"
    check_field "Target Users" "Secondary Users" "### Secondary Users"
    
    check_field "Business" "Market Context" "### Market Context"
    check_field "Business" "Competition" "### Competition"
    check_field "Business" "Business Model" "### Business Model"
    
    check_field "Technical" "Platform" "### Platform"
    check_field "Technical" "Technology" "### Technology Preferences"
    check_field "Technical" "Performance" "### Performance Requirements"
    check_field "Technical" "Scale" "### Scale Requirements"
    
    check_field "Design" "Brand" "### Brand Personality"
    check_field "Design" "Visual Style" "### Visual Style"
    check_field "Design" "Accessibility" "### Accessibility Requirements"
    
    check_field "Features" "Workflows" "### Core Workflows"
    check_field "Features" "Content Types" "### Content Types"
    check_field "Features" "Priority" "### Key Features Priority"
    
    check_field "GTM" "Target Market" "### Target Market"
    check_field "GTM" "Value Prop" "### Value Proposition"
else
    echo "| All Sections | All Fields | ❌ N/A | APP_DETAILS.md not found |"
fi
```

### 4. Check Inspiration Assets

```bash
echo ""
echo "# 🎨 Inspiration Assets Validation"
echo ""
echo "| Directory | File Count | Status | File Types |"
echo "|-----------|------------|---------|------------|"

check_inspiration_dir() {
    dir=$1
    name=$2
    
    if [ -d "$dir" ]; then
        total_files=$(find "$dir" -type f -not -name "README.md" 2>/dev/null | wc -l)
        
        if [ $total_files -gt 0 ]; then
            html_count=$(find "$dir" -name "*.html" -o -name "*.htm" 2>/dev/null | wc -l)
            img_count=$(find "$dir" -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.gif" 2>/dev/null | wc -l)
            pdf_count=$(find "$dir" -name "*.pdf" 2>/dev/null | wc -l)
            
            types=""
            [ $html_count -gt 0 ] && types="${types}HTML($html_count) "
            [ $img_count -gt 0 ] && types="${types}Images($img_count) "
            [ $pdf_count -gt 0 ] && types="${types}PDF($pdf_count) "
            
            echo "| $name | $total_files files | ✅ Has content | $types |"
        else
            echo "| $name | 0 files | ⚠️  Empty | Add inspiration materials |"
        fi
    else
        echo "| $name | N/A | ❌ Missing | Directory not found |"
    fi
}

check_inspiration_dir "/assets/inspiration/visual" "Visual Inspiration"
check_inspiration_dir "/assets/inspiration/functional" "Functional Inspiration"
```

### 5. Check Previous Generations

```bash
echo ""
echo "# 📊 Previous Generations"
echo ""

if [ -d "/specs" ]; then
    gen_count=$(find "/specs" -maxdepth 1 -type d -name "20*" 2>/dev/null | wc -l)
    
    if [ $gen_count -gt 0 ]; then
        echo "| Metric | Value |"
        echo "|--------|-------|"
        echo "| Total Generations | $gen_count |"
        
        # Get latest generation
        latest=$(ls -t /specs/20* 2>/dev/null | head -1)
        if [ -n "$latest" ]; then
            latest_name=$(basename "$latest")
            doc_count=$(find "$latest" -name "*.md" -o -name "*.html" 2>/dev/null | wc -l)
            echo "| Latest Generation | $latest_name |"
            echo "| Documents in Latest | $doc_count files |"
        fi
    else
        echo "ℹ️  No previous documentation generations found in /specs/"
    fi
else
    echo "❌ /specs directory not found"
fi
```

### 6. Mode Detection Analysis

```bash
echo ""
echo "# 🎯 Generation Mode Analysis"
echo ""

if [ -f "/APP_DETAILS.md" ]; then
    content=$(cat "/APP_DETAILS.md")

    # Count required fields that have substantial content
    required_fields=(
        "### App Name"
        "### App Idea"
        "### MVP Features"
        "### Primary Users"
    )

    filled_count=0
    total_required=${#required_fields[@]}

    for field in "${required_fields[@]}"; do
        if echo "$content" | grep -A 10 "$field" | grep -E "[A-Za-z0-9]{20,}" > /dev/null; then
            if ! echo "$content" | grep -A 10 "$field" | grep -E "\[.*\]|Example:|INSTRUCTIONS:" > /dev/null; then
                filled_count=$((filled_count + 1))
            fi
        fi
    done

    # Calculate completion percentage
    completion_percent=$((filled_count * 100 / total_required))

    echo "| Metric | Value | Status |"
    echo "|--------|-------|---------|"
    echo "| Required Fields Filled | $filled_count/$total_required | $completion_percent% |"

    if [ $completion_percent -lt 50 ]; then
        echo "| **Recommended Mode** | **COLLABORATIVE** | ✅ Best for iterative refinement |"
        echo "| Mode Description | Interactive consultation | Refine through conversation |"
        echo "| Process | Basic idea → Collaborative PRD → Iteration → Comprehensive docs | |"
    else
        echo "| **Recommended Mode** | **COMPREHENSIVE** | ✅ Ready for full generation |"
        echo "| Mode Description | Complete documentation suite | One-shot comprehensive PRD |"
        echo "| Process | Detailed input → Full PRD → All technical docs | |"
    fi

    echo ""
    echo "### Mode-Specific Recommendations:"
    echo ""

    if [ $completion_percent -lt 50 ]; then
        echo "**COLLABORATIVE MODE** is recommended because:"
        echo "- You have a basic idea but need to refine requirements"
        echo "- Interactive consultation will help clarify your vision"
        echo "- You can iterate and improve the specification through conversation"
        echo ""
        echo "**Next Steps for Collaborative Mode:**"
        echo "1. Ensure basic required fields (App Name, App Idea, MVP Features) are filled"
        echo "2. Run \`run-spec-chain\` - it will detect collaborative mode automatically"
        echo "3. Engage in the iterative refinement process"
        echo "4. Graduate to comprehensive documentation when ready"
    else
        echo "**COMPREHENSIVE MODE** is recommended because:"
        echo "- You have detailed requirements ready"
        echo "- Your APP_DETAILS.md is substantially complete"
        echo "- You can generate the full documentation suite immediately"
        echo ""
        echo "**Next Steps for Comprehensive Mode:**"
        echo "1. Complete any remaining optional fields (or let auto-research handle them)"
        echo "2. Run \`run-spec-chain\` for full documentation generation"
        echo "3. Review and iterate on the generated comprehensive documentation"
    fi
else
    echo "| Status | Value |"
    echo "|--------|-------|"
    echo "| APP_DETAILS.md | ❌ Not found |"
    echo "| **Recommended Mode** | **COLLABORATIVE** |"
    echo "| Reason | Start with basic idea input |"
fi
```

### 7. Generate Summary Report

```bash
echo ""
echo "# 📈 Validation Summary"
echo ""

# Count issues
errors=0
warnings=0

# Add logic to count errors and warnings from above checks
# This would be done by capturing the output and counting ❌ and ⚠️ symbols

echo "| Status | Count | Description |"
echo "|--------|-------|-------------|"
echo "| ❌ Errors | $errors | Critical issues that must be fixed |"
echo "| ⚠️  Warnings | $warnings | Non-critical issues to address |"
echo "| ✅ Passed | $passed | Checks that passed validation |"

echo ""
echo "## 🚀 Next Steps"
echo ""

if [ $errors -gt 0 ]; then
    echo "### Critical Issues to Fix:"
    echo "1. Run \`init-spec-chain\` to create missing directories and files"
    echo "2. Fill out all required fields in APP_DETAILS.md"
    echo "3. Ensure all spec-chain prompt files are present"
fi

if [ $warnings -gt 0 ]; then
    echo ""
    echo "### Recommended Improvements:"
    echo "1. Complete any placeholder content in APP_DETAILS.md"
    echo "2. Add inspiration materials to empty directories"
    echo "3. Review and expand minimal field entries"
fi

if [ $errors -eq 0 ] && [ $warnings -eq 0 ]; then
    echo "✅ **All validations passed!** Your Spec Chain setup is ready."
    echo ""
    echo "**Ready for Documentation Generation:**"
    echo "- The system will automatically detect the appropriate mode (Collaborative/Comprehensive)"
    echo "- Run \`run-spec-chain\` to begin the documentation generation process"
    echo ""
    echo "\`\`\`"
    echo "run-spec-chain"
    echo "\`\`\`"
fi
```

### 7. Detailed Field Validation Function

For more thorough APP_DETAILS.md validation, create a function that checks field quality:

```bash
validate_field_quality() {
    echo ""
    echo "# 🔍 Field Quality Analysis"
    echo ""
    echo "| Field | Word Count | Quality | Recommendation |"
    echo "|-------|------------|----------|----------------|"
    
    # Function to count words in a section
    check_section_quality() {
        field=$1
        min_words=$2
        section_text=$3
        
        word_count=$(echo "$section_text" | wc -w)
        
        if [ $word_count -lt $min_words ]; then
            echo "| $field | $word_count words | ⚠️  Too brief | Expand to at least $min_words words |"
        else
            echo "| $field | $word_count words | ✅ Adequate | |"
        fi
    }
    
    # Extract and check each major section
    # (Implementation would extract text between section headers)
}
```

## Error Handling

- Handle missing files gracefully
- Provide clear error messages
- Suggest specific fixes for each issue
- Continue validation even if some checks fail

## Success Indicators

The validation is considered successful when:
- All required directories exist and are writable
- APP_DETAILS.md.template exists and is accessible
- APP_DETAILS.md exists with complete structure matching template
- All required fields in APP_DETAILS.md are filled
- All 19 spec-chain prompts are present
- At least some inspiration materials are provided

## Output Format

The report uses:
- ✅ Green checkmarks for passed validations
- ⚠️  Warning symbols for non-critical issues
- ❌ Red X marks for critical failures
- 📁 📄 📋 🎨 📊 📈 Icons for different sections
- Tables for organized presentation
- Clear next steps based on validation results