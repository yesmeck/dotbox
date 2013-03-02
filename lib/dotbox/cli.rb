require 'dotbox'
require 'dotbox/config'
require 'dotbox/file'
require 'dotbox/record'

module Dotbox
  class CLI < Thor

    def initialize(*args)
      super
      @record = Record.new
    end

    desc :setup, 'Setup bakbox'
    def setup
      dropbox_path = ask('Enter dropbox folder location:').strip
      Dotbox::Config.new(Backbox::CONFIG_FILE, dropbox_path)
      if !::File.exists?(backup_path)
        FileUtils.mkdir_p backup_path
      end
    end

    desc :add, 'Backup the file'
    def add(*pathes)
      check_setup
      pathes.each do |path|
        path = ::File.expand_path(path)
        if ::File.exists?(path)
          file = File.new(path)
          file.backup
          @record.add file
        else
          say "#{path} not exists."
        end
      end
    end

    desc :remove, 'Remove the backuped file'
    def remove(*pathes)
      check_setup
      pathes.each do |path|
        path = ::File.expand_path(path)
        file = File.new(path)
        if !::File.exists?(path)
          die "#{path} not exists."
        elsif !file.backuped?
          die "#{path} is not backuped."
        end
        file.remove
        @record.remove file
      end
    end

    desc :restore, 'Restore all backuped files'
    def restore
      backup_path = "#{Config.new(Dotbox::CONFIG_FILE).value}/Apps/Dotbox/files"
      Dir.glob("#{backup_path}/**/*").each do |path|
        if ::File.file?(path)
          file = File.new(path.sub(/^#{backup_path}\//, ''))
          file.restore
        end
      end
    end

    def self.source_root
      ::File.dirname(::File.expand_path('../../../bin/dotbox', __FILE__))
    end

    private
    def check_setup
      if !Config.new(Dotbox::CONFIG_FILE).setted?
        die 'Use `bakbox setup` to setup dotbox first.'
      end
    end

    def die(msg)
      say msg
      exit;
    end

  end
end
