#!/bin/bash

# Simple Liquid Syntax Fix Script
set -e

echo "🔧 Fixing Liquid syntax issues..."

# Find all Markdown files and fix common issues
find . -name "*.md" -not -path "./_site/*" -not -path "./.git/*" | while read -r file; do
    echo "Processing: $file"
    
    # Fix malformed raw tags
    sed -i '' 's/{\% raw \%}/{% raw %}/g' "$file"
    sed -i '' 's/{\% endraw \%}/{% endraw %}/g' "$file"
    
    # Remove any malformed raw tag patterns
    sed -i '' 's/{{% raw %}/{% raw %}/g' "$file"
    sed -i '' 's/% endraw %}}/{% endraw %}/g' "$file"
    
    # Remove standalone malformed raw tags
    sed -i '' '/^{% raw %}$/d' "$file"
    sed -i '' '/^{% endraw %}$/d' "$file"
    
    # Remove empty raw blocks
    sed -i '' '/^{% raw %}$/{N;s/^{% raw %}\n{% endraw %}//;}' "$file"
done

echo "✅ Liquid syntax fixes applied!"
echo "🧪 Testing Jekyll build..."

# Test if bundle is available
if command -v bundle &> /dev/null; then
    if bundle exec jekyll build --dry-run 2>/dev/null; then
        echo "✅ Jekyll build test passed!"
    else
        echo "❌ Jekyll build test failed. Check the output above."
        exit 1
    fi
else
    echo "⚠️  Bundle not found. Skipping Jekyll build test."
fi

echo "🎉 Liquid syntax fix complete!"
