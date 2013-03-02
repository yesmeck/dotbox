require 'yaml'
require 'dotbox/file'

module Dotbox
  class Record

    def initialize
      @record_file_path = "#{Config.new(Dotbox::CONFIG_FILE).value}/Apps/Dotbox/.dotbox"
      if !::File.exists?(@record_file_path)
        FileUtils.mkdir_p(::File.dirname(@record_file_path))
        FileUtils.touch(@record_file_path)
      end
      @records = YAML.load_file(@record_file_path) || {}
    end

    def add(file)
      @records[file.rel_path] = file.type
      save
    end

    def save
      @record_file ||= ::File.new(@record_file_path, 'r+')
      @record_file.puts(YAML.dump(@records))
    end

    def [](path)
      @records[path]
    end

  end
end
