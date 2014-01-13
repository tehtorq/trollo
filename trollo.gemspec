# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "trollo/version"

Gem::Specification.new do |s|
  s.name        = "trollo"
  s.version     = Trollo::VERSION
  s.authors     = ["Douglas Anderson"]
  s.email       = ["i.am.douglas.anderson@gmail.com"]
  s.homepage    = 'https://github.com/teachme2/trollo'
  s.summary     = %q{ A trollo gem. }
  s.description = %q{ Trolololo. }

  s.rubyforge_project = "trollo"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activesupport"
  s.add_dependency "activerecord", "~> 3.0"
  s.add_dependency "i18n"
  s.add_dependency "workflow", '= 0.8.7'
  s.add_dependency "acts_as_commentable", '= 3.0.1'
  
  s.add_development_dependency 'combustion', '~> 0.3.1'
  s.add_development_dependency 'database_cleaner', '~> 1.2.0'
end
