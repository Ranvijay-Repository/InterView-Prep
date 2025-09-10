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
