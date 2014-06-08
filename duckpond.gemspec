# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'duckpond/version'

Gem::Specification.new do |spec|
  spec.name          = "duckpond"
  spec.version       = Duckpond::VERSION
  spec.authors       = ["Mikey Hogarth"]
  spec.email         = ["mikehogarth20@hotmail.com"]
  spec.description   = %q{Explicit duck-typing for ruby}
  spec.summary       = %q{See README file for details}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
