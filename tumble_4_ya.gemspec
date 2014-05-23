# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tumble_4_ya/version'

Gem::Specification.new do |spec|
  spec.name          = "tumble_4_ya"
  spec.version       = Tumble4Ya::VERSION
  spec.authors       = ["michaeltomko"]
  spec.email         = ["mike@tomkobombco.com"]
  spec.summary       = %q{A Ruby Gem that adds simple roulette wheel style sorting to any Array object.}
  spec.description   = %q{A Ruby Gem that adds simple roulette wheel style sorting to any Array object.}
  spec.homepage      = "https://github.com/michaeltomko/tumble_4_ya"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '>= 3.0'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-nc"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-remote"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "coveralls"
end
