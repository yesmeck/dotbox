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
        backup_path = "#{Config.new(Dotbox::CONFIG_FILE).value}/Apps/Dotbox"
        if directory?
          backup_path << '/directories'
        else
          backup_path << '/files'
        end
        @backup_path = ::File.expand_path("#{backup_path}/#{@path.sub(/^#{Thor::Util.user_home}/, '')}")
      end
      @backup_path
    end

    def backup
      FileUtils.mkdir_p ::File.dirname(backup_path)
      FileUtils.mv @path, backup_path
      FileUtils.ln_s backup_path, @path
    end

    def remove
      # must get the backup path first
      backup_path
      FileUtils.rm @path
      FileUtils.mv backup_path, @path
    end

    def restore
      FileUtils.mkdir_p ::File.dirname(@path)
      FileUtils.ln_s backup_path, @path
    end

    def backuped?
      link? && link_of?(backup_path)
    end

    def link?
      ::File.symlink? @path
    end

    def link_of?(src)
      ::File.readlink(@path) == src
    end

  end
end
