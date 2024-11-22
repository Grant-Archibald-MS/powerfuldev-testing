Jekyll::Hooks.register :site, :post_write do |site|
    config = site.config['rename_files'] || []
    config.each do |rename|
      from_path = rename['from']
      to_path = rename['to']
      
      if File.exist?(from_path)
        FileUtils.mkdir_p(File.dirname(to_path))
        FileUtils.mv(from_path, to_path)
        # Update the site pages if necessary
        site.pages.each do |page|
          if page.path == from_path.sub('_site/', '')
            page.instance_variable_set(:@path, to_path.sub('_site/', ''))
          end
        end
      else
        Jekyll.logger.warn "CopyFiles:", "File #{from_path} does not exist."
      end
    end
  end