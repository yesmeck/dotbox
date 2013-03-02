Given /^a backuped file named "(.*?)"$/ do |filename|
  in_current_dir do
    backuped_filename = File.expand_path("dropbox/Apps/Dotbox/files/#{filename}")
    write_file(backuped_filename, "")
    _mkdir(File.dirname(filename))
    FileUtils.ln_s backuped_filename, filename
  end
end

Given /^a backuped directory named "(.*?)"$/ do |dirname|
  in_current_dir do
    backuped_dirname = File.expand_path("dropbox/Apps/Dotbox/directories/#{dirname}")
    _mkdir(backuped_dirname)
    _mkdir(File.dirname(dirname))
    FileUtils.ln_s backuped_dirname, dirname
  end
end


Then /^the (?:file|directory) named "(.*?)" should be a link of "(.*?)"$/ do |link, file|
  link = File.expand_path([current_dir, link].join('/'))
  file = File.expand_path([current_dir, file].join('/'))
  link_file = File.readlink(link) rescue nil
  link_file.should == file
end

Then /^the (?:file|directory) named "(.*?)" should not be a link$/ do |file|
  in_current_dir do
    link_file = File.readlink(file) rescue nil
    link_file.should be nil
  end
end

