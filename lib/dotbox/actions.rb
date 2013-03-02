module Dotbox
  module Actions

    def rm_empty_dir(path)
      return nil if !::File.directory?(path)
      if (Dir.entries(path) - %w{. ..}).empty?
        FileUtils.rm_r path
        rm_empty_dir ::File.dirname(path)
      end
    end

  end
end
