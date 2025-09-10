#!/bin/bash

echo "🔧 Fixing raw tag mismatches in all markdown files..."

# Find all markdown files
find . -name "*.md" -not -path "./_site/*" -not -path "./.git/*" -not -path "./scripts/*" | while read file; do
    echo "Processing: $file"
    
    # Create backup
    cp "$file" "$file.backup"
    
    # Fix raw tag mismatches by ensuring proper pairing
    # Count raw and endraw tags and fix any mismatches
    
    raw_count=$(grep -c "{% raw %}" "$file" || echo "0")
    endraw_count=$(grep -c "{% endraw %}" "$file" || echo "0")
    
    echo "  Raw tags: $raw_count, Endraw tags: $endraw_count"
    
    if [ "$raw_count" -ne "$endraw_count" ]; then
        echo "  ⚠️  Mismatch detected! Fixing..."
        
        # Remove all existing raw/endraw tags
        sed -i '' 's/{% raw %}//g' "$file"
        sed -i '' 's/{% endraw %}//g' "$file"
        
        # Re-add them properly around code blocks
        awk '
        BEGIN { in_code_block = 0; }
        
        # Detect start of code block
        /^```/ && !in_code_block {
            in_code_block = 1
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
        
        echo "  ✅ Fixed raw tag mismatches"
    else
        echo "  ✅ Raw tags are properly paired"
    fi
done

echo "🎯 All raw tag mismatches should now be fixed!"
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
