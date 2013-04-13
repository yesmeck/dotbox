require 'dotbox'
require 'dotbox/config'
require 'dotbox/file'
require 'dotbox/record'

module Dotbox
  class CLI < Thor

    desc :setup, 'Setup bakbox'
    def setup
      dropbox_path = ask('Enter dropbox folder location:').strip
      Dotbox::Config.new(Dotbox::CONFIG_FILE, dropbox_path)
    end

    desc :add, 'Backup the file'
    def add(*pathes)
      check_setup
      @record = Record.new
      pathes.each do |path|
        if Dir[path].empty?
          die "#{path} not exists."
        end
        Dir[path].each do |p|
          begin
            p = ::File.expand_path(p)
            file = File.new(p)
            file.backup
            @record.add file
          rescue => ex
            die ex.message
          end
        end
      end
    end

    desc :remove, 'Remove the backuped file'
    def remove(*pathes)
      check_setup
      @record = Record.new
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
      check_setup
      @record = Record.new
      @record.each do |path|
        file = File.new(path)
        file.restore
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
