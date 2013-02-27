require 'thor'
require 'backbox/config'

module Backbox
  class CLI < Thor

    include Thor::Actions

    CONFIG_FILE = "#{Thor::Util.user_home}/.backbox"

    desc :setup, 'Setup bakbox'
    def setup
      dropbox_path = ask('Enter dropbox folder location:').strip
      Backbox::Config.new(CONFIG_FILE, dropbox_path)
      if !File.exists?(backup_path)
        FileUtils.mkdir_p backup_path
      end
    end

    desc :add, 'Backup the file'
    def add(*pathes)
      check_setup
      pathes.each do |path|
        if File.exists?(path)
          backpath = "#{backup_path}/#{path.sub(/^#{Thor::Util.user_home}/, '')}"
          copy_file path, backpath
          remove_file path
          create_link path, backpath
        else
          say "#{path} not exists."
        end
      end
    end

    desc :remove, 'Remove the backuped file'
    def remove(*pathes)
      check_setup
      pathes.each do |path|
        if File.exists?(path)
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
      File.dirname(File.expand_path('../../bin/backbox', __FILE__))
    end

    private
    def check_setup
      if !File.exists?(CONFIG_FILE)
        die 'Use `bakbox setup` to setup backbox first.'
      else
        if !File.exists?(dropbox_path)
          die "#{dropbox_path} not exists."
        end
      end
    end

    def die(msg)
      say msg
      exit;
    end

    def dropbox_path
      Backbox::Config.new(CONFIG_FILE).value
    end

    def backup_path
      "#{dropbox_path}/Apps/Backbox"
    end

  end
end
