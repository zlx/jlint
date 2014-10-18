# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jlint/version'

Gem::Specification.new do |spec|
  spec.name          = "jlint"
  spec.version       = Jlint::VERSION
  spec.authors       = ["soffolk"]
  spec.email         = ["zlx.star@gmail.com"]
  spec.summary       = %q{Ruby Warp for CheckStyle: https://github.com/checkstyle/checkstyle}
  spec.description   = %q{Ruby Warp for CheckStyle: https://github.com/checkstyle/checkstyle}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
