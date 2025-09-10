#!/bin/bash

echo "🔧 Fixing ALL Liquid syntax errors in the repository..."

# Find all markdown files
find . -name "*.md" -not -path "./_site/*" -not -path "./.git/*" -not -path "./scripts/*" | while read file; do
    echo "Processing: $file"
    
    # Create backup
    cp "$file" "$file.backup"
    
    # Fix the file by wrapping all code blocks with raw tags
    # This is a more comprehensive approach that handles all code blocks
    
    # First, let's identify all code blocks and wrap them with raw tags
    # We'll use a more sophisticated approach with awk
    
    awk '
    BEGIN { in_code_block = 0; code_block_started = 0; }
    
    # Detect start of code block
    /^```/ && !in_code_block {
        in_code_block = 1
        code_block_started = 1
        print "{% raw %}"
        print $0
        next
    }
    
    # Detect end of code block
    /^```/ && in_code_block {
        in_code_block = 0
        print $0
        print "{% endraw %}"
        next
    }
    
    # Print all other lines
    { print $0 }
    ' "$file.backup" > "$file"
    
    echo "✅ Fixed: $file"
done

echo "🎯 All Liquid syntax errors should now be fixed!"
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

echo "📋 Summary:"
echo "- All code blocks are now wrapped with {% raw %} and {% endraw %} tags"
echo "- This prevents Liquid from processing JavaScript/TypeScript syntax"
echo "- Jekyll should now build successfully"
