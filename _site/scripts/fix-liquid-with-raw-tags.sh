#!/bin/bash

echo "🔧 Fixing Liquid syntax errors using {% raw %} tags..."

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
                # Ending a code block
                echo "$line" >> "$temp_file"
                echo "{% endraw %}" >> "$temp_file"
                in_code_block=false
                in_raw_block=false
            fi
        else
            # Regular line
            if [ "$in_raw_block" = true ]; then
                # Inside raw block, just copy the line
                echo "$line" >> "$temp_file"
            else
                # Outside raw block, escape any {{ and }} that might be problematic
                # Only escape if they look like JavaScript/React syntax
                if [[ "$line" =~ \{\{.*\}\} ]]; then
                    # Check if it looks like React/JSX syntax
                    if [[ "$line" =~ (style=|source=|onPress=|onClick=) ]]; then
                        # This looks like React syntax, escape it
                        line=$(echo "$line" | sed 's/{{/&#123;&#123;/g')
                        line=$(echo "$line" | sed 's/}}/&#125;&#125;/g')
                    fi
                fi
                echo "$line" >> "$temp_file"
            fi
        fi
    done < "$file"
    
    # Replace original file
    mv "$temp_file" "$file"
    echo "✅ Fixed: $file"
done

echo "🎯 All Liquid syntax errors should now be fixed with raw tags!"
echo "🧪 Testing Jekyll build..."

# Test the build
if bundle exec jekyll build; then
    echo "✅ SUCCESS! Jekyll build completed without errors!"
    echo "🎉 ALL Liquid syntax errors have been resolved!"
    echo "📋 Summary:"
    echo "- All code blocks are now wrapped with {% raw %} and {% endraw %} tags"
    echo "- This prevents Liquid from processing JavaScript/TypeScript syntax"
    echo "- Jekyll build now succeeds"
else
    echo "❌ Build still has errors. Let me check what's left..."
    echo "🔍 Running build again to see remaining errors..."
    bundle exec jekyll build 2>&1 | grep -E "(Liquid|Error)" | head -10
fi
