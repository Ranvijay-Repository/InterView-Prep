#!/bin/bash

echo "🔧 FINAL COMPREHENSIVE FIX for ALL Liquid syntax errors..."

# Find all markdown files
find . -name "*.md" -not -path "./_site/*" -not -path "./.git/*" -not -path "./scripts/*" | while read file; do
    echo "Processing: $file"
    
    # Create backup
    cp "$file" "$file.backup"
    
    # Create temporary file
    temp_file=$(mktemp)
    in_code_block=false
    in_raw_block=false
    
    while IFS= read -r line; do
        # Check if we're entering a code block
        if [[ "$line" =~ ^\`\`\` ]]; then
            if [ "$in_code_block" = false ]; then
                # Starting a code block - wrap with raw tags
                echo "{% raw %}" >> "$temp_file"
                echo "$line" >> "$temp_file"
                in_code_block=true
                in_raw_block=true
            else
                # Ending a code block - close raw tags
                echo "$line" >> "$temp_file"
                echo "{% endraw %}" >> "$temp_file"
                in_code_block=false
                in_raw_block=false
            fi
        else
            # Regular line - just copy it
            echo "$line" >> "$temp_file"
        fi
    done < "$file"
    
    # Replace original file with fixed version
    mv "$temp_file" "$file"
    echo "✅ Fixed: $file"
done

echo "🎯 All Liquid syntax errors should now be fixed!"
echo "🧪 Testing Jekyll build..."
bundle exec jekyll build

if [ $? -eq 0 ]; then
    echo "✅ Jekyll build successful!"
    echo "🎉 ALL LIQUID SYNTAX ERRORS FIXED!"
else
    echo "❌ Build still has errors. Let me check what's left..."
    echo "🔍 Running build again to see remaining errors..."
    bundle exec jekyll build
fi

echo "📋 Summary:"
echo "- All code blocks are now wrapped with {% raw %} and {% endraw %} tags"
echo "- This prevents Liquid from processing JavaScript/TypeScript syntax"
echo "- Jekyll should now build successfully"
