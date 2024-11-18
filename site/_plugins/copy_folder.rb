module Jekyll
  class CopyFolderGenerator < Generator
    safe true

    # The generate method is called by Jekyll to start the copying process.
    def generate(site)
      copy_folders = site.config['copy_folders']
      copy_folders.each do |folder|
        source_dir = File.expand_path(folder['source'], site.source)
        dest_dir = File.expand_path(folder['destination'], site.source)
        copy_files_with_stack(source_dir, dest_dir, site.source)
      end
    end

    # This method copies files and directories from the source to the destination.
    def copy_files_with_stack(source, destination, site_source)
      stack = [[source, destination]]
      until stack.empty?
        current_source, current_dest = stack.pop
        Dir.foreach(current_source) do |entry|
          next if entry == '.' || entry == '..'
          source_path = File.join(current_source, entry)
          dest_path = File.join(current_dest, entry)
          if File.directory?(source_path)
            FileUtils.mkdir_p(dest_path) unless Dir.exist?(dest_path)
            stack.push([source_path, dest_path])
          else
            FileUtils.mkdir_p(File.dirname(dest_path)) unless Dir.exist?(File.dirname(dest_path))
            FileUtils.cp(source_path, dest_path)
            # Only update links and prepend front matter for .md files
            if File.extname(dest_path) == '.md'
              update_links(dest_path, site_source)
              prepend_front_matter(dest_path, site_source)
            end
            if File.basename(dest_path).downcase == 'readme.md'
              new_dest_path = File.join(File.dirname(dest_path), 'index.md')
              FileUtils.mv(dest_path, new_dest_path)
            end
          end
        end
      end
    end

    # This method updates links in the file content.
    def update_links(file_path, site_source)
      content = File.read(file_path)
      updated_content = content.gsub(/https:\/\/github\.com\/Grant-Archibald-MS\/powerfuldev-testing\/blob\/main\/(.*)\.md/) do |match|
        "/powerfuldev-testing/#{$1}"
      end
      if file_path.include?("roles-and-responsibilities")
        updated_content = updated_content.gsub(/\(\.\/(.*)\.md\)/) do |match|
          "(/powerfuldev-testing/roles-and-responsibilities/#{$1}.md)"
        end
      end
      if file_path.include?("context")
        updated_content = updated_content.gsub(/\(\.\/(.*)\.md\)/) do |match|
          "(/powerfuldev-testing/context/#{$1}.md)"
        end
      end
      if file_path.include?("examples")
        updated_content = updated_content.gsub(/\(\.\/(.*)\.md\)/) do |match|
          "(/powerfuldev-testing/examples/#{$1}.md)"
        end
      end
      if file_path.include?("discussion")
        updated_content = updated_content.gsub(/\(\.\/(.*)\.md\)/) do |match|
          "(/powerfuldev-testing/discussion/#{$1}.md)"
        end
      end
      updated_content = updated_content.gsub(/\(\.\.\/examples\/(.*)\.md\)/) do |match|
        "(/powerfuldev-testing/examples/#{$1}.md)"
      end
      updated_content = updated_content.gsub(/\.md\)/) do |match|
        ")"
      end
      File.open(file_path, 'w') { |file| file.puts updated_content }
    end

    # This method prepends front matter to the file if it doesn't already have it.
    # It also uses the level 1 Markdown header as the title and removes it from the content.
    def prepend_front_matter(file_path, site_source)
      content = File.read(file_path)
      unless content =~ /\A---\s*\n.*?\n---\s*\n/m
        # Extract the level 1 header as the title
        title = content[/^# (.+)$/, 1] || File.basename(file_path, '.md').split('_').map(&:capitalize).join(' ')
        # Convert colons to dashes in the title
        title.gsub!(':', '-')
        # Remove the level 1 header from the content
        content.sub!(/^# .+\n/, '')
        # Handle permalink for readme.md files
        if File.basename(file_path).downcase == 'readme.md'
          permalink = File.dirname(file_path).sub(site_source, '')
        else
          permalink = file_path.sub(site_source, '').sub(/\.md$/, '')
        end
        extra = ""
        if content.include? "mermaid"
          extra = "mermaid: true"
        end
        front_matter = <<~FRONT_MATTER
          ---
          layout: single
          title: #{title}
          permalink: #{permalink.downcase.gsub(' ', '-')}
          toc: true
          sidebar:
            nav: "docs"
          read_time: true
          #{extra}
          ---
        FRONT_MATTER
        File.open(file_path, 'w') do |file|
          file.puts front_matter + content
        end
      end
    end
  end
end