require 'dotbox'
require 'dotbox/config'
require 'dotbox/file'

module Dotbox
  class CLI < Thor


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
          File.new(path).backup
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
