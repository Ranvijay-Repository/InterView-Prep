#!/bin/bash

echo "🔧 Final Liquid syntax fix - Complete solution..."

# First, let's find and fix all the problematic HTML entities
echo "Step 1: Reverting all HTML entities to normal curly braces..."

find . -name "*.md" -not -path "./_site/*" -not -path "./.git/*" | while read -r file; do
    echo "Processing: $file"
    
    # Fix the specific problematic patterns
    sed -i '' 's/{{#123;{{#123;/{{/g' "$file"
    sed -i '' 's/}}#125;}}#125;/}}/g' "$file"
    sed -i '' 's/{{#123;/{{/g' "$file"
    sed -i '' 's/}}#125;/}}/g' "$file"
    
    # Fix any remaining HTML entity patterns
    sed -i '' 's/&#123;&#123;/{{/g' "$file"
    sed -i '' 's/&#125;&#125;/}}/g' "$file"
    sed -i '' 's/&#123;/{{/g' "$file"
    sed -i '' 's/&#125;/}}/g' "$file"
done

echo "✅ HTML entities reverted"

# Step 2: Create a more robust Jekyll configuration
echo "Step 2: Creating robust Jekyll configuration..."

cat > _config.yml << 'EOF'
# Jekyll Configuration for Interview Prep Documentation

# Site settings
title: "Interview Prep Documentation"
description: "Comprehensive guides for JavaScript, TypeScript, and React Native interview preparation"
baseurl: ""
url: ""

# Build settings
markdown: kramdown
highlighter: rouge
theme: minima

# Exclude files from processing
exclude:
  - README.md
  - Gemfile
  - Gemfile.lock
  - node_modules
  - vendor/bundle/
  - vendor/cache/
  - vendor/gems/
  - vendor/ruby/
  - .sass-cache/
  - .jekyll-cache/
  - .jekyll-metadata
  - .git
  - .gitignore
  - .DS_Store
  - Thumbs.db

# Include files
include:
  - _redirects

# Collections
collections:
  javascript:
    output: true
    permalink: /:collection/:name/
  typescript:
    output: true
    permalink: /:collection/:name/
  react-native:
    output: true
    permalink: /:collection/:name/

# Default front matter
defaults:
  - scope:
      path: ""
      type: "pages"
    values:
      layout: "default"
  - scope:
      path: ""
      type: "javascript"
    values:
      layout: "default"
  - scope:
      path: ""
      type: "typescript"
    values:
      layout: "default"
  - scope:
      path: ""
      type: "react-native"
    values:
      layout: "default"

# Kramdown settings - disable Liquid processing in code blocks
kramdown:
  input: GFM
  hard_wrap: false
  syntax_highlighter: rouge
  syntax_highlighter_opts:
    css_class: 'highlight'
    span:
      line_numbers: false
    block:
      line_numbers: false
  # Disable Liquid processing in Markdown
  parse_block_html: true
  parse_span_html: true

# Plugins
plugins:
  - jekyll-feed
  - jekyll-sitemap
  - jekyll-seo-tag

# Liquid settings - be very permissive
liquid:
  error_mode: warn
  strict_filters: false
  strict_variables: false

# Safe mode to prevent arbitrary code execution
safe: true

# Source directory
source: .

# Destination directory
destination: ./_site

# Incremental build
incremental: false

# Show drafts
show_drafts: false

# Limit posts
limit_posts: 0

# Future posts
future: false

# Unpublished posts
unpublished: false

# Timezone
timezone: null

# Encoding
encoding: utf-8

# Markdown extensions
markdown_ext: "markdown,mkdown,mkdn,mkd,md"

# Textile extensions
textile_ext: "textile"

# Exclude from processing
exclude_from_processing:
  - node_modules
  - vendor
  - .git
  - .sass-cache
  - .jekyll-cache
  - .jekyll-metadata
EOF

echo "✅ Jekyll configuration updated"

# Step 3: Update the Jekyll plugin to be more aggressive
echo "Step 3: Updating Jekyll plugin for better Liquid handling..."

cat > _plugins/liquid_syntax_fix.rb << 'EOF'
# Jekyll Plugin to Fix Liquid Syntax Issues
# This plugin automatically handles common Liquid syntax conflicts

module Jekyll
  class LiquidSyntaxFixer < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      site.pages.each do |page|
        next unless page.extname == '.md'
        fix_liquid_syntax(page)
      end

      site.posts.docs.each do |post|
        next unless post.extname == '.md'
        fix_liquid_syntax(post)
      end
    end

    private

    def fix_liquid_syntax(page)
      return unless page.content

      # Remove any malformed raw tags
      page.content = page.content.gsub(/\{\{\% raw \%\}/, '')
      page.content = page.content.gsub(/\% endraw \%\}\}/, '')
      page.content = page.content.gsub(/^\{\% raw \%\}$/, '')
      page.content = page.content.gsub(/^\{\% endraw \%\}$/, '')
      
      # Fix any remaining HTML entity patterns
      page.content = page.content.gsub(/\{\{#123;\{\{#123;/g, '{{')
      page.content = page.content.gsub(/\}\}#125;\}\}#125;/g, '}}')
      page.content = page.content.gsub(/\{\{#123;/g, '{{')
      page.content = page.content.gsub(/\}\}#125;/g, '}}')
      page.content = page.content.gsub(/&#123;&#123;/g, '{{')
      page.content = page.content.gsub(/&#125;&#125;/g, '}}')
      
      # Escape problematic Liquid syntax in code blocks
      page.content = escape_liquid_in_code_blocks(page.content)
    end

    def escape_liquid_in_code_blocks(content)
      lines = content.split("\n")
      result = []
      in_code_block = false
      
      lines.each do |line|
        # Detect code block boundaries
        if line.match(/^```/)
          in_code_block = !in_code_block
          result << line
          next
        end
        
        # Inside code blocks, escape problematic Liquid syntax
        if in_code_block
          # Escape double curly braces that aren't already escaped
          if line.match(/\{\{[^%]/) && !line.match(/\{\% raw \%\}/)
            line = line.gsub(/\{\{/, '&#123;&#123;')
            line = line.gsub(/\}\}/, '&#125;&#125;')
          end
        end
        
        result << line
      end
      
      result.join("\n")
    end
  end
end
EOF

echo "✅ Jekyll plugin updated"

# Step 4: Test the build
echo "Step 4: Testing Jekyll build..."
if bundle exec jekyll build 2>/dev/null; then
    echo "✅ Jekyll build successful!"
    echo "🎉 All Liquid syntax issues resolved!"
else
    echo "❌ Jekyll build still has issues."
    echo "Let's try a different approach..."
    
    # Last resort: Use a different markdown processor
    echo "Trying with different markdown settings..."
    
    # Update config to use commonmark instead of kramdown
    sed -i '' 's/markdown: kramdown/markdown: commonmark/g' _config.yml
    sed -i '' '/kramdown:/,/^$/d' _config.yml
    
    if bundle exec jekyll build 2>/dev/null; then
        echo "✅ Jekyll build successful with commonmark!"
    else
        echo "❌ Still having issues. Let's check the specific error..."
        bundle exec jekyll build
    fi
fi

echo "🎯 Final Liquid syntax fix complete!"
