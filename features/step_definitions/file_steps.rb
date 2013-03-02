Then /^the (?:file|directory) named "(.*?)" should be a link of "(.*?)"$/ do |link, file|
  link = File.expand_path([current_dir, link].join('/'))
  file = File.expand_path([current_dir, file].join('/'))
  link_file = File.readlink(link) rescue nil
  link_file.should == file
end

Given /^a backuped file named "(.*?)"$/ do |file_name|
  in_current_dir do
    backuped_file_name = File.expand_path("dropbox/Apps/Dotbox/files/#{file_name}")
    write_file(backuped_file_name, "")
    _mkdir(File.dirname(file_name))
    FileUtils.ln_s backuped_file_name, file_name
  end
end

Then /^the file named "(.*?)" should not be a link$/ do |file|
  in_current_dir do
    link_file = File.readlink(file) rescue nil
    link_file.should be nil
  end
end

