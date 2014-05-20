# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "tumble_4_ya"
  spec.version       = "0.1.0"
  spec.authors       = ["Michael Tomko"]
  spec.email         = ["mike@tomkobombco.com"]
  spec.description   = %q{Tumble 4 Ya is a Ruby Gem that adds simple roulette wheel style sorting to any Array object.}
  spec.summary       = %q{Tumble 4 Ya is a Ruby Gem that adds simple roulette wheel style sorting to any Array object.}
  spec.homepage      = "https://github.com/michaeltomko/tumble_4_ya"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end
