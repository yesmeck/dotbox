require File.expand_path("../lib/dotbox/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "dotbox"
  s.description = "Backup your dotfiles to dropbox and restore them easily."
  s.summary = s.description
  s.authors = ["Wei Zhu"]
  s.email = ["yesmeck@gmail.com"]
  s.files = `git ls-files`.split("\n")
  s.homepage = "https://github.com/yesmeck/dotbox"
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.version = Dotbox::VERSION::STRING

  s.add_dependency 'thor'
  s.add_development_dependency 'aruba'
  s.add_development_dependency 'rspec'
end
