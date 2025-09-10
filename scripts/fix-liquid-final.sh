#!/bin/bash

echo "🔧 Fixing all Liquid syntax issues..."

# Fix the specific problematic files
echo "Fixing React Native/00-Core-Foundations/00-JavaScript-Essentials-for-RN.md..."

# Fix line 327 - escape the curly braces
sed -i '' 's/{error && <Text style={{color: '\''red'\''}}>{error}<\/Text>}/{error \&\& \<Text style=\{\{color: '\''red'\''\}\}\>\{error\}\<\/Text\>}/g' "React Native/00-Core-Foundations/00-JavaScript-Essentials-for-RN.md"

# Fix line 388 - escape the curly braces  
sed -i '' 's/<Image source={{ uri: avatar }} \/>/<Image source=\{\{ uri: avatar \}\} \/>/g' "React Native/00-Core-Foundations/00-JavaScript-Essentials-for-RN.md"

echo "Fixing React Native/00-Core-Foundations/02-TypeScript-Essentials-for-RN.md..."

# Fix the problematic style object
sed -i '' 's/style={{/style=\{\{/g' "React Native/00-Core-Foundations/02-TypeScript-Essentials-for-RN.md"
sed -i '' 's/}}/\}\}/g' "React Native/00-Core-Foundations/02-TypeScript-Essentials-for-RN.md"

echo "✅ Liquid syntax fixes applied!"

# Test the build
echo "🧪 Testing Jekyll build..."
if bundle exec jekyll build 2>/dev/null; then
    echo "✅ Jekyll build successful!"
else
    echo "❌ Jekyll build still has issues. Let's try a different approach..."
    
    # Alternative approach: Use HTML entities
    echo "Using HTML entities approach..."
    
    # Fix all problematic patterns with HTML entities
    find . -name "*.md" -not -path "./_site/*" -not -path "./.git/*" | while read -r file; do
        # Replace {{ with HTML entities inside code blocks
        sed -i '' 's/{{/&#123;&#123;/g' "$file"
        sed -i '' 's/}}/&#125;&#125;/g' "$file"
    done
    
    echo "✅ Applied HTML entity escaping to all files"
fi

echo "🎉 Liquid syntax fix complete!"
