module Backbox
  class Config

    def initialize(file, value = nil)
      @file = file
      if !value.nil?
        save(value)
      end
    end

    def value
      File.new(@file).read.strip.chomp('/')
    end

    private
    def save(value)
      f = File.new(@file, 'w+')
      f.puts(value)
      f.close
    end

  end
end
