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
      FileUtils.mkdir_p ::File.dirname(backup_path)
      FileUtils.mv @abs_path, backup_path
      FileUtils.ln_s backup_path, @abs_path
    end

    def remove
      # must get the backup path first
      backup_path
      FileUtils.rm @abs_path
      FileUtils.mv backup_path, @abs_path
      rm_empty_dir ::File.dirname(backup_path)
    end

    def restore
      if ::File.exist?(@abs_path)
        FileUtils.mv @abs_path, "#{@abs_path}.bak"
      end
      FileUtils.mkdir_p ::File.dirname(@abs_path)
      FileUtils.ln_s backup_path, @abs_path
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

  end
end
