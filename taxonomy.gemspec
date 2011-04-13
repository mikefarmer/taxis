# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "taxis/version"

Gem::Specification.new do |s|
  s.name        = "taxis"
  s.version     = Taxis::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michael Farmer"]
  s.email       = ["mfarmer@endpoint.com"]
  s.homepage    = "www.endpoint.com"
  s.summary     = %q{Rails engine that adds a simple taxonomy structure to your application}
  s.description = %q{Rails engine that adds a simple taxonomy structure to your application}

  s.rubyforge_project = "taxonomy"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('nested_set', '~> 1.6.4')
  s.add_dependency('stringex', '~> 1.2.1')

end
