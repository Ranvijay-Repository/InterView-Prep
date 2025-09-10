# Scripts Directory

This directory contains all the shell scripts used for setting up and maintaining the Interview Prep documentation site.

## 📁 Scripts Overview

### **Setup Scripts**

#### `setup-production-branch.sh`
- **Purpose**: Sets up the production branch for CI/CD deployment
- **Usage**: `./scripts/setup-production-branch.sh`
- **What it does**:
  - Creates production branch from current branch
  - Pushes production branch to remote
  - Provides instructions for branch protection setup
  - Optionally sets up branch protection rules via GitHub CLI

### **Liquid Syntax Fix Scripts**

#### `fix-liquid-syntax.sh`
- **Purpose**: Comprehensive Liquid syntax fixer (original version)
- **Usage**: `./scripts/fix-liquid-syntax.sh`
- **What it does**:
  - Fixes malformed raw tags
  - Wraps code blocks with proper raw tags
  - Tests Jekyll build
  - **Note**: This script had some issues and was superseded

#### `fix-liquid-syntax-simple.sh`
- **Purpose**: Simplified Liquid syntax fixer
- **Usage**: `./scripts/fix-liquid-syntax-simple.sh`
- **What it does**:
  - Fixes malformed raw tags
  - Removes empty raw blocks
  - Tests Jekyll build
  - **Note**: This was a simpler approach that also had issues

#### `fix-liquid-final.sh`
- **Purpose**: Final attempt at fixing Liquid syntax issues
- **Usage**: `./scripts/fix-liquid-final.sh`
- **What it does**:
  - Fixes specific problematic patterns
  - Uses HTML entities as fallback
  - Tests Jekyll build
  - **Note**: This approach had mixed results

#### `fix-liquid-complete.sh`
- **Purpose**: Complete Liquid syntax solution
- **Usage**: `./scripts/fix-liquid-complete.sh`
- **What it does**:
  - Reverts HTML entities to normal curly braces
  - Creates robust Jekyll configuration
  - Updates Jekyll plugin for better Liquid handling
  - Tests with different markdown processors
  - **Note**: This was the most comprehensive approach

#### `fix-liquid-final-complete.sh`
- **Purpose**: Final comprehensive Liquid syntax fix
- **Usage**: `./scripts/fix-liquid-final-complete.sh`
- **What it does**:
  - Reverts all HTML entities to normal curly braces
  - Creates robust Jekyll configuration
  - Updates Jekyll plugin for better Liquid handling
  - Tests Jekyll build
  - **Status**: Most recent and comprehensive solution

## 🚀 **Recommended Usage**

### **For Initial Setup**
```bash
# Set up production branch
./scripts/setup-production-branch.sh

# Fix any Liquid syntax issues
./scripts/fix-liquid-final-complete.sh
```

### **For Maintenance**
```bash
# If you encounter Liquid syntax errors
./scripts/fix-liquid-final-complete.sh
```

## 📋 **Script Development History**

1. **`fix-liquid-syntax.sh`** - First attempt, had complexity issues
2. **`fix-liquid-syntax-simple.sh`** - Simplified approach, still had issues
3. **`fix-liquid-final.sh`** - HTML entity approach, mixed results
4. **`fix-liquid-complete.sh`** - Comprehensive solution, better results
5. **`fix-liquid-final-complete.sh`** - Final comprehensive solution

## ⚠️ **Important Notes**

- **Backup**: All scripts create backups before making changes
- **Testing**: Each script tests the Jekyll build after making changes
- **Rollback**: If a script fails, you can restore from backups
- **Permissions**: All scripts are executable (`chmod +x`)

## 🔧 **Troubleshooting**

### **If Scripts Fail**
1. Check that you're in the project root directory
2. Ensure you have the required dependencies (Ruby, Jekyll, etc.)
3. Check the script output for specific error messages
4. Try running the most recent script: `fix-liquid-final-complete.sh`

### **If Jekyll Build Still Fails**
1. Check the specific error message
2. Look for the problematic file mentioned in the error
3. Manually fix the Liquid syntax in that file
4. Test with `bundle exec jekyll build`

## 📚 **Related Documentation**

- `../BRANCH-PROTECTION-SETUP.md` - Branch protection setup guide
- `../CI-CD-SETUP.md` - CI/CD pipeline documentation
- `../LIQUID-SYNTAX-SOLUTION.md` - Liquid syntax solution summary
- `../WORKFLOW-FIXES-SUMMARY.md` - Workflow fixes documentation

---

**🎯 All scripts are organized and ready for use!**
