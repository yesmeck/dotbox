require 'aruba/cucumber'
require 'cucumber/rspec/doubles'
require File.expand_path('../../../lib/dotbox/config.rb', __FILE__)

ENV['PATH'] = "#{File.expand_path('../../bin/dotbox', __FILE__)}#{File::PATH_SEPARATOR}#{ENV['PATH']}"

Before do
  ENV['HOME'] = File.expand_path(@dirs.join('/'))
  ENV['DROPBOX_PATH'] = "#{ENV['HOME']}/dropbox"
end
