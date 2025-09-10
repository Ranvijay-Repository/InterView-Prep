#!/bin/bash

echo "🔧 Fixing Liquid syntax errors with HTML entities (simple approach)..."

# Find all markdown files
find . -name "*.md" -not -path "./_site/*" -not -path "./.git/*" -not -path "./scripts/*" | while read file; do
    echo "Processing: $file"
    
    # Create backup
    cp "$file" "$file.backup"
    
    # Replace problematic patterns with HTML entities
    # This is a much simpler approach than raw tags
    
    # Replace {{ with &#123;&#123; and }} with &#125;&#125;
    sed -i '' 's/{{/&#123;&#123;/g' "$file"
    sed -i '' 's/}}/&#125;&#125;/g' "$file"
    
    echo "✅ Fixed: $file"
done

echo "🎯 All Liquid syntax errors should now be fixed with HTML entities!"
echo "🧪 Testing Jekyll build..."

# Test the build
if bundle exec jekyll build; then
    echo "✅ SUCCESS! Jekyll build completed without errors!"
    echo "🎉 All Liquid syntax errors have been resolved!"
else
    echo "❌ Build still has errors. Let me check what's left..."
    echo "🔍 Running build again to see remaining errors..."
    bundle exec jekyll build 2>&1 | grep -E "(Liquid|Error)" | head -10
fi
