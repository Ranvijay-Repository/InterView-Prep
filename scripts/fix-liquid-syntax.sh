#!/bin/bash

# Fix Liquid Syntax Issues in Markdown Files
# This script fixes common Liquid syntax conflicts in Jekyll

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_status "🔧 Fixing Liquid syntax issues in Markdown files..."

# Find all Markdown files
find . -name "*.md" -not -path "./_site/*" -not -path "./.git/*" | while read -r file; do
    print_status "Processing: $file"
    
    # Create a backup
    cp "$file" "$file.backup"
    
    # Fix malformed raw tags
    sed -i '' 's/{\% raw \%}/{% raw %}/g' "$file"
    sed -i '' 's/{\% endraw \%}/{% endraw %}/g' "$file"
    
    # Fix any remaining malformed raw tags
    sed -i '' 's/{{% raw %}/{% raw %}/g' "$file"
    sed -i '' 's/% endraw %}}/{% endraw %}/g' "$file"
    
    # Remove any standalone malformed raw tags
    sed -i '' '/^{% raw %}$/d' "$file"
    sed -i '' '/^{% endraw %}$/d' "$file"
    
    # Fix code blocks with curly braces by wrapping them properly
    # This is a more sophisticated approach using awk
    awk '
    BEGIN { in_code_block = 0; in_raw_block = 0 }
    
    # Detect code block start
    /^```/ {
        if (!in_code_block) {
            in_code_block = 1
            print $0
            next
        } else {
            in_code_block = 0
            print $0
            next
        }
    }
    
    # Inside code block
    in_code_block {
        # Check if line contains problematic Liquid syntax
        if ($0 ~ /\{\{[^%]/ && $0 !~ /{% raw %}/ && $0 !~ /{% endraw %}/) {
            # If we are not already in a raw block, start one
            if (!in_raw_block) {
                print "{% raw %}"
                in_raw_block = 1
            }
        }
        print $0
        # End raw block at end of code block
        if (!in_code_block && in_raw_block) {
            print "{% endraw %}"
            in_raw_block = 0
        }
        next
    }
    
    # Outside code block
    {
        print $0
    }
    ' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
    
    # Clean up any remaining issues
    # Remove empty raw blocks
    sed -i '' '/^{% raw %}$/{N;s/^{% raw %}\n{% endraw %}//;}' "$file"
    
    # Fix any remaining malformed patterns
    sed -i '' 's/{{% raw %}/{% raw %}/g' "$file"
    sed -i '' 's/% endraw %}}/{% endraw %}/g' "$file"
    
    print_success "Fixed: $file"
done

print_status "🧹 Cleaning up backup files..."
find . -name "*.backup" -delete

print_status "🔍 Checking for remaining issues..."

# Check for any remaining problematic patterns
remaining_issues=0

find . -name "*.md" -not -path "./_site/*" -not -path "./.git/*" | while read -r file; do
    # Check for malformed raw tags
    if grep -q "{{% raw %}" "$file" || grep -q "% endraw %}}" "$file"; then
        print_warning "Still has issues: $file"
        remaining_issues=$((remaining_issues + 1))
    fi
    
    # Check for unescaped double curly braces outside code blocks
    if grep -n "{{[^%]" "$file" | grep -v "{% raw %}" | grep -v "{% endraw %}" | grep -v "^[0-9]*:```" | grep -v "^[0-9]*:    " | grep -v "^[0-9]*:\t"; then
        print_warning "Potential Liquid syntax issue in: $file"
        remaining_issues=$((remaining_issues + 1))
    fi
done

if [ $remaining_issues -eq 0 ]; then
    print_success "🎉 All Liquid syntax issues fixed!"
else
    print_warning "⚠️  $remaining_issues files still have potential issues"
fi

print_status "🧪 Testing Jekyll build..."

# Test Jekyll build
if command -v bundle &> /dev/null; then
    if bundle exec jekyll build --dry-run 2>/dev/null; then
        print_success "✅ Jekyll build test passed!"
    else
        print_error "❌ Jekyll build test failed. Check the output above."
        exit 1
    fi
else
    print_warning "Bundle not found. Skipping Jekyll build test."
fi

print_success "🎯 Liquid syntax fix complete!"
echo
echo "📋 Summary:"
echo "  • Fixed malformed {% raw %} tags"
echo "  • Wrapped code blocks with proper raw tags"
echo "  • Cleaned up backup files"
echo "  • Tested Jekyll build"
echo
echo "🚀 Your site should now build without Liquid syntax errors!"
