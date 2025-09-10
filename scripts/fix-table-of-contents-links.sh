#!/bin/bash

# Fix Table of Contents Links for Jekyll
# This script fixes relative links in markdown files to work properly with Jekyll's URL structure

echo "🔗 Fixing Table of Contents Links for Jekyll..."

# Function to fix links in a file
fix_links_in_file() {
    local file="$1"
    local dir_path=$(dirname "$file")
    
    echo "Processing: $file"
    
    # Fix relative links to use proper Jekyll paths
    # Convert relative paths to absolute paths from root
    
    # For files in subdirectories, we need to calculate the correct relative path
    if [[ "$dir_path" == "TypeScript" ]]; then
        # TypeScript files - links should be relative to TypeScript directory
        sed -i.bak 's|](00-TypeScript-Fundamentals/|](TypeScript/00-TypeScript-Fundamentals/|g' "$file"
        sed -i.bak 's|](01-Advanced-Type-System/|](TypeScript/01-Advanced-Type-System/|g' "$file"
        sed -i.bak 's|](02-TypeScript-Modern-JavaScript/|](TypeScript/02-TypeScript-Modern-JavaScript/|g' "$file"
        sed -i.bak 's|](03-TypeScript-Configuration-Tooling/|](TypeScript/03-TypeScript-Configuration-Tooling/|g' "$file"
        sed -i.bak 's|](04-Advanced-TypeScript-Patterns/|](TypeScript/04-Advanced-TypeScript-Patterns/|g' "$file"
        sed -i.bak 's|](05-TypeScript-Different-Environments/|](TypeScript/05-TypeScript-Different-Environments/|g' "$file"
        sed -i.bak 's|](06-TypeScript-Testing-Quality/|](TypeScript/06-TypeScript-Testing-Quality/|g' "$file"
        sed -i.bak 's|](07-TypeScript-Libraries-Ecosystem/|](TypeScript/07-TypeScript-Libraries-Ecosystem/|g' "$file"
        sed -i.bak 's|](08-Advanced-TypeScript-Concepts/|](TypeScript/08-Advanced-TypeScript-Concepts/|g' "$file"
        sed -i.bak 's|](09-TypeScript-Performance-Optimization/|](TypeScript/09-TypeScript-Performance-Optimization/|g' "$file"
        sed -i.bak 's|](10-TypeScript-Best-Practices/|](TypeScript/10-TypeScript-Best-Practices/|g' "$file"
    elif [[ "$dir_path" == "Javascript" ]]; then
        # JavaScript files - links should be relative to Javascript directory
        sed -i.bak 's|](01 JavaScript Core/|](Javascript/01%20JavaScript%20Core/|g' "$file"
        sed -i.bak 's|](02-Advanced-JavaScript-Concepts/|](Javascript/02-Advanced-JavaScript-Concepts/|g' "$file"
        sed -i.bak 's|](03-Browser-Runtime-Internals/|](Javascript/03-Browser-Runtime-Internals/|g' "$file"
        sed -i.bak 's|](04-Advanced-Patterns-Architecture/|](Javascript/04-Advanced-Patterns-Architecture/|g' "$file"
        sed -i.bak 's|](05-Performance-Optimization/|](Javascript/05-Performance-Optimization/|g' "$file"
        sed -i.bak 's|](06-Testing-Quality-Assurance/|](Javascript/06-Testing-Quality-Assurance/|g' "$file"
        sed -i.bak 's|](07-Security-Best-Practices/|](Javascript/07-Security-Best-Practices/|g' "$file"
        sed -i.bak 's|](08-Interview-Preparation/|](Javascript/08-Interview-Preparation/|g' "$file"
        sed -i.bak 's|](09-Real-World-Applications/|](Javascript/09-Real-World-Applications/|g' "$file"
    elif [[ "$dir_path" == "React Native" ]]; then
        # React Native files - links should be relative to React Native directory
        sed -i.bak 's|](00-Core-Foundations/|](React%20Native/00-Core-Foundations/|g' "$file"
        sed -i.bak 's|](01-React-Native-Fundamentals/|](React%20Native/01-React-Native-Fundamentals/|g' "$file"
        sed -i.bak 's|](02-Navigation-Deep-Linking/|](React%20Native/02-Navigation-Deep-Linking/|g' "$file"
        sed -i.bak 's|](03-Networking-Data-Management/|](React%20Native/03-Networking-Data-Management/|g' "$file"
        sed -i.bak 's|](04-State-Management/|](React%20Native/04-State-Management/|g' "$file"
        sed -i.bak 's|](05-Lists-Performance-Optimization/|](React%20Native/05-Lists-Performance-Optimization/|g' "$file"
        sed -i.bak 's|](06-Animations-Gestures/|](React%20Native/06-Animations-Gestures/|g' "$file"
        sed -i.bak 's|](07-Native-Interoperability/|](React%20Native/07-Native-Interoperability/|g' "$file"
        sed -i.bak 's|](08-Platform-Capabilities/|](React%20Native/08-Platform-Capabilities/|g' "$file"
        sed -i.bak 's|](09-Testing-Quality/|](React%20Native/09-Testing-Quality/|g' "$file"
        sed -i.bak 's|](10-Build-Release-CICD/|](React%20Native/10-Build-Release-CICD/|g' "$file"
        sed -i.bak 's|](11-Security-Privacy/|](React%20Native/11-Security-Privacy/|g' "$file"
        sed -i.bak 's|](12-Accessibility-Internationalization/|](React%20Native/12-Accessibility-Internationalization/|g' "$file"
        sed -i.bak 's|](13-Architecture-Scaling/|](React%20Native/13-Architecture-Scaling/|g' "$file"
        sed -i.bak 's|](14-Expo-vs-Bare-Workflow/|](React%20Native/14-Expo-vs-Bare-Workflow/|g' "$file"
        sed -i.bak 's|](15-Error-Handling-Recovery/|](React%20Native/15-Error-Handling-Recovery/|g' "$file"
        sed -i.bak 's|](16-Memory-Management/|](React%20Native/16-Memory-Management/|g' "$file"
        sed -i.bak 's|](17-Cross-Platform-Development/|](React%20Native/17-Cross-Platform-Development/|g' "$file"
        sed -i.bak 's|](18-React-Native-Ecosystem/|](React%20Native/18-React-Native-Ecosystem/|g' "$file"
        sed -i.bak 's|](19-Advanced-Debugging/|](React%20Native/19-Advanced-Debugging/|g' "$file"
        sed -i.bak 's|](20-Migration-Upgrades/|](React%20Native/20-Migration-Upgrades/|g' "$file"
    fi
    
    # Remove backup files
    rm -f "$file.bak"
}

# Find and process all markdown files with table of contents
echo "🔍 Finding markdown files with table of contents..."

# Process main index files
for file in "TypeScript/TypeScript.md" "Javascript/JavaScript.md" "React Native/React-Native.md"; do
    if [[ -f "$file" ]]; then
        fix_links_in_file "$file"
    fi
done

# Process individual markdown files that might have internal links
find . -name "*.md" -not -path "./_site/*" -not -path "./.git/*" -not -path "./scripts/*" | while read file; do
    # Check if file contains table of contents or internal links
    if grep -q "Table of Contents\|## 📚\|- \[.*\](.*\.md)" "$file"; then
        fix_links_in_file "$file"
    fi
done

echo "✅ Table of Contents links fixed!"
echo "📋 Summary:"
echo "   - Fixed relative paths to use proper Jekyll URL structure"
echo "   - Updated links in main index files"
echo "   - Processed individual markdown files with internal links"
echo "   - All links should now work properly in the generated site"
