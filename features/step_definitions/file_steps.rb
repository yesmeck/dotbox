require 'dotbox'
require 'dotbox/config'
require 'dotbox/record'
require 'dotbox/file'

World(Aruba::Api)

Given /^a backuped file named "(.*?)"$/ do |path|
  write_file(path, "")
  in_current_dir do
    file = Dotbox::File.new(path)
    file.backup
  end
end

Given /^a backuped directory named "(.*?)"$/ do |path|
  in_current_dir do
    _mkdir(path)
    file = Dotbox::File.new(path)
    file.backup
  end
end


Then /^the link named "(.*?)" should be a link of "(.*?)"$/ do |link, file|
  in_current_dir do
    link_file = File.readlink(link) rescue nil
    link_file.should == File.expand_path(file)
  end
end

Then /^the (?:file|directory) named "(.*?)" should not be a link$/ do |path|
  in_current_dir do
    File.should_not be_symlink(path)
  end
end

Then /^a link named "(.*?)" should exist$/ do |link|
  in_current_dir do
    File.should be_symlink(link)
  end
end

Then /^the record file show contain "(.*?)" => "(.*?)"$/ do |path, type|
  record  = Dotbox::Record.new
  record[path].should == type
end

