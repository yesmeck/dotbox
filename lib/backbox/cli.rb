require 'backbox'
require 'backbox/config'
require 'backbox/file'

module Backbox
  class CLI < Thor


    desc :setup, 'Setup bakbox'
    def setup
      dropbox_path = ask('Enter dropbox folder location:').strip
      Backbox::Config.new(Backbox::CONFIG_FILE, dropbox_path)
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
        if ::File.exists?(path)
          backpath = "#{backup_path}/#{path.sub(/^#{Thor::Util.user_home}/, '')}"
          remove_file path
          copy_file backpath, path
          remove_file backpath
        else
          say "#{path} not exists."
        end
      end
    end

    def self.source_root
      ::File.dirname(::File.expand_path('../../../bin/backbox', __FILE__))
    end

    private
    def check_setup
      if !Config.new(Backbox::CONFIG_FILE).setted?
        die 'Use `bakbox setup` to setup backbox first.'
      end
    end

    def die(msg)
      say msg
      exit;
    end

  end
end
