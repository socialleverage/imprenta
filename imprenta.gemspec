# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imprenta/version'

Gem::Specification.new do |spec|
  spec.name          = "imprenta"
  spec.version       = Imprenta::VERSION
  spec.authors       = ["Rafael Chacon"]
  spec.email         = ["rafaelchacon@gmail.com"]
  spec.description   = %q{Publish and serve static html pages with Rails}
  spec.summary       = %q{This gem helps the process of publishing and serving static pages within rails}
  spec.homepage      = "https://github.com/skyscrpr/imprenta"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 4.0.0"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
end
