module Backbox
  class Config

    def initialize(file, value = nil)
      @file = file
      if !value.nil?
        save(value)
      end
    end

    def value
      if ENV['DROPBOX_PATH'].nil?
        File.new(@file).read.strip.chomp('/')
      else
        ENV['DROPBOX_PATH']
      end
    end

    def setted?
      ::File.exists?(@file) || !ENV['DROPBOX_PATH'].nil?
    end

    private
    def save(value)
      f = ::File.new(@file, 'w+')
      f.puts(value)
      f.close
    end

  end
end
