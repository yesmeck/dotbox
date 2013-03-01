require 'aruba/cucumber'
require 'cucumber/rspec/doubles'
require File.expand_path('../../../lib/backbox/config.rb', __FILE__)

ENV['PATH'] = "#{File.expand_path('../../bin/backbox', __FILE__)}#{File::PATH_SEPARATOR}#{ENV['PATH']}"

Before do
  ENV['DROPBOX_PATH'] = "dropbox"
  ENV['HOME'] = File.expand_path(@dirs.join('/'))
end
