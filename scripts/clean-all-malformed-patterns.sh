#!/bin/bash

echo "🧹 CLEANING ALL MALFORMED PATTERNS..."

# Find all markdown files with malformed patterns
find . -name "*.md" -not -path "./_site/*" -not -path "./.git/*" -not -path "./scripts/*" | while read file; do
    echo "Cleaning: $file"
    
    # Create backup
    cp "$file" "$file.backup"
    
    # Clean up all malformed patterns
    sed -i '' 's/{{#123;[^}]*/{{/g' "$file"
    sed -i '' 's/[^{]*}}#125;/}}/g' "$file"
    
    # Clean up any remaining nested patterns
    sed -i '' 's/{{#123;{{#123;/{{/g' "$file"
    sed -i '' 's/}}#125;}}#125;/}}/g' "$file"
    
    # Clean up any remaining #123; patterns
    sed -i '' 's/#123;//g' "$file"
    sed -i '' 's/#125;//g' "$file"
    
    echo "✅ Cleaned: $file"
done

echo "🎯 All malformed patterns cleaned!"
echo "🧪 Testing Jekyll build..."
bundle exec jekyll build

if [ $? -eq 0 ]; then
    echo "✅ Jekyll build successful!"
    echo "🎉 ALL MALFORMED PATTERNS CLEANED!"
else
    echo "❌ Build still has errors. Let me check what's left..."
    bundle exec jekyll build
fi
