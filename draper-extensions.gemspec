# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'draper/extensions/version'

Gem::Specification.new do |spec|
  spec.name          = "draper-extensions"
  spec.version       = Draper::Extensions::VERSION
  spec.authors       = ["Chamnap Chhorn"]
  spec.email         = ["chamnapchhorn@gmail.com"]
  spec.summary       = %q{Extends Draper by adding pagination and scoping methods}
  spec.description   = %q{Extends Draper by adding pagination and scoping methods}
  spec.homepage      = "https://github.com/chamnap/draper-extensions"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "draper", ">= 1.3.0"
end
