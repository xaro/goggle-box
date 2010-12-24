# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "goggle-box/version"

Gem::Specification.new do |s|
  s.name        = "goggle-box"
  s.version     = GoggleBox::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Paul Ingham"]
  s.email       = ["paul.ingham@beefeatingmonkeys.com"]
  s.homepage    = "http://www.beefeatingmonkeys.com"
  s.summary     = %q{}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "goggle-box"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency(%q<httparty>)
  s.add_dependency(%q<rspec>)
end
