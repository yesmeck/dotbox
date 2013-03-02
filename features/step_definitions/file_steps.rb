Then /^the (?:file|directory) named "(.*?)" should be a link of "(.*?)"$/ do |link, file|
  link = File.expand_path([current_dir, link].join('/'))
  file = File.expand_path([current_dir, file].join('/'))
  link_file = File.readlink(link) rescue nil
  link_file.should == file
end

