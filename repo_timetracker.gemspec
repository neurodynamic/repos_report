# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'repos_report/version'

Gem::Specification.new do |spec|
  spec.name          = "repos_report"
  spec.version       = ReposReport::VERSION
  spec.authors       = ["neurodynamic"]
  spec.email         = ["developer@neurodynamic.io"]
  spec.summary       = %q{A gem that reports on the status of all repos under a given directory.}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/neurodynamic/repos_report"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "colorizer", '~> 0.0', '>= 0.0.2'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "colorizer", ">= 0.0.2"
end
