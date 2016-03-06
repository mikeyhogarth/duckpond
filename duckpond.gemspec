# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'duckpond/version'

Gem::Specification.new do |spec|
  spec.name          = "duckpond"
  spec.version       = DuckPond::VERSION
  spec.authors       = ["Mikey Hogarth"]
  spec.email         = ["mikehogarth20@hotmail.com"]
  spec.description   = %q{Explicit duck-typing for ruby}
  spec.summary       = %q{Explicit duck-typing for ruby}
  spec.homepage      = "https://github.com/mikeyhogarth/duckpond"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 0"
end
