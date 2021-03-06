require 'dotbox/actions'

module Dotbox
  class File

    attr_reader :abs_path, :rel_path

    include Dotbox::Actions

    def initialize(path)
      @abs_path = ::File.expand_path(path)
      @rel_path = @abs_path.sub(/^#{Thor::Util.user_home}\//, '')
    end

    def directory?
      ::File.directory?(@abs_path)
    end

    def backup_path
      if @backup_path.nil?
        backup_path = "#{Config.new(Dotbox::CONFIG_FILE).value}/Apps/Dotbox"
        @backup_path = ::File.expand_path("#{backup_path}/#{@rel_path}")
      end
      @backup_path
    end

    def backup
      if ::File.exist?(backup_path)
        raise "#{@rel_path} has been backuped."
      end
      FileUtils.mkdir_p ::File.dirname(backup_path)
      FileUtils.mv @abs_path, backup_path, verbose: true
      FileUtils.ln_s backup_path, @abs_path, verbose: true
    end

    def remove
      # must get the backup path first
      backup_path
      FileUtils.rm @abs_path, verbose: true
      FileUtils.mv backup_path, @abs_path, verbose: true
      rm_empty_dir ::File.dirname(backup_path)
    end

    def restore
      if exist?
        if link? && link_of?(backup_path)
          # Dont need restore
          return
        else
          FileUtils.mv @abs_path, "#{@abs_path}.bak", verbose: true
        end
      end
      FileUtils.mkdir_p ::File.dirname(@abs_path), verbose: true
      FileUtils.ln_s backup_path, @abs_path, verbose: true
    end

    def backuped?
      link? && link_of?(backup_path)
    end

    def link?
      ::File.symlink? @abs_path
    end

    def link_of?(src)
      ::File.readlink(@abs_path) == src
    end

    def type
      @type = directory? ? 'directory' : 'file'
    end

    def exist?
      ::File.exist?(@abs_path)
    end

  end
end
