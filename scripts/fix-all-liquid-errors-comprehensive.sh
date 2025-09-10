#!/bin/bash

echo "🔧 COMPREHENSIVE FIX for ALL Liquid syntax errors in the entire repository..."

# Find all markdown files
find . -name "*.md" -not -path "./_site/*" -not -path "./.git/*" -not -path "./scripts/*" | while read file; do
    echo "Processing: $file"
    
    # Create backup
    cp "$file" "$file.backup"
    
    # Step 1: Fix all malformed patterns systematically
    # Replace any pattern starting with {{#123; with proper &#123;&#123;
    sed -i '' 's/{{#123;[^}]*/&#123;&#123;/g' "$file"
    
    # Replace any pattern ending with }}#125; with proper &#125;&#125;
    sed -i '' 's/[^{]*}}#125;/&#125;&#125;/g' "$file"
    
    # Step 2: Fix nested/multiple encoding patterns
    # Replace patterns like {{#123;{{#123; with &#123;&#123;
    sed -i '' 's/{{#123;{{#123;/&#123;&#123;/g' "$file"
    sed -i '' 's/{{#123;{{#123;{{#123;/&#123;&#123;/g' "$file"
    sed -i '' 's/{{#123;{{#123;{{#123;{{#123;/&#123;&#123;/g' "$file"
    
    # Replace patterns like }}#125;}}#125; with &#125;&#125;
    sed -i '' 's/}}#125;}}#125;/&#125;&#125;/g' "$file"
    sed -i '' 's/}}#125;}}#125;}}#125;/&#125;&#125;/g' "$file"
    sed -i '' 's/}}#125;}}#125;}}#125;}}#125;/&#125;&#125;/g' "$file"
    
    # Step 3: Fix any remaining complex nested patterns
    # Replace any sequence of {{#123; with single &#123;&#123;
    sed -i '' 's/{{#123;\([^}]*\)/&#123;&#123;\1/g' "$file"
    
    # Replace any sequence of }}#125; with single &#125;&#125;
    sed -i '' 's/\([^{]*\)}}#125;/\1&#125;&#125;/g' "$file"
    
    # Step 4: Clean up any remaining malformed patterns
    # Replace any remaining {{#123; with &#123;&#123;
    sed -i '' 's/{{#123;/&#123;&#123;/g' "$file"
    
    # Replace any remaining }}#125; with &#125;&#125;
    sed -i '' 's/}}#125;/&#125;&#125;/g' "$file"
    
    # Step 5: Ensure all {{ and }} are properly escaped
    # Replace any remaining {{ with &#123;&#123;
    sed -i '' 's/{{/&#123;&#123;/g' "$file"
    
    # Replace any remaining }} with &#125;&#125;
    sed -i '' 's/}}/&#125;&#125;/g' "$file"
    
    echo "✅ Fixed: $file"
done

echo "🎯 ALL Liquid syntax errors should now be comprehensively fixed!"
echo "🧪 Testing Jekyll build..."

# Test the build
if bundle exec jekyll build; then
    echo "✅ SUCCESS! Jekyll build completed without errors!"
    echo "🎉 ALL Liquid syntax errors have been resolved!"
    echo "📋 Summary:"
    echo "- Fixed all malformed patterns like {{#123;{{#123;"
    echo "- Fixed all nested encoding issues"
    echo "- Replaced all {{ with &#123;&#123; and }} with &#125;&#125;"
    echo "- Jekyll build now succeeds"
else
    echo "❌ Build still has errors. Let me check what's left..."
    echo "🔍 Running build again to see remaining errors..."
    bundle exec jekyll build 2>&1 | grep -E "(Liquid|Error)" | head -10
fi
