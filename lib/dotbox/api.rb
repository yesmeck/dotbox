require 'dotbox'
require 'dotbox/config'
require 'dotbox/record'
require 'dotbox/file'

module Dotbox
  module Api

    def create_backup(path)
      file = Dotbox::File.new(path)
      file.backup
      Dotbox::Record.new.add file
    end

    def create_backup_file(path)
      FileUtils.mkdir ::File.dirname(path)
      FileUtils.touch path
      create_backup path
      FileUtils.rm path
    end

    def create_backup_directory(path)
      FileUtils.mkdir_p path
      create_backup path
      FileUtils.rm_r path
    end

  end
end
