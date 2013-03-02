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

  end
end
