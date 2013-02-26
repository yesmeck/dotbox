require File.expand_path("../lib/backbox/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "backbox"
  s.description = "Using dropbox to backup your files easily"
  s.summary = s.description
  s.authors = ["Wei Zhu"]
  s.email = ["yesmeck@gmail.com"]
  s.files = `git ls-files`.split("\n")
  s.homepage = "https://github.com/yesmeck/backbox"
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.version = Backbox::VERSION::STRING
end
