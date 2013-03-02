module Dotbox
  class File

    include Thor::Actions

    def initialize(path)
      @path = path
    end

    def directory?
      ::File.directory?(@path)
    end

    def backup_path
      if @backup_path.nil?
        backup_path = "#{Config.new(Dotbox::CONFIG_FILE).value}/Apps/Backbox"
        if directory?
          backup_path << '/directories'
        else
          backup_path << '/files'
        end
        @backup_path = ::File.expand_path("#{backup_path}#{@path.sub(/^#{Thor::Util.user_home}/, '')}")
      end
      @backup_path
    end

    def backup
      FileUtils.mkdir_p ::File.dirname(backup_path)
      FileUtils.mv @path, backup_path
      FileUtils.ln_s backup_path, @path
    end

  end
end
