# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hpg/version'

Gem::Specification.new do |spec|
  spec.name = 'hpg'
  spec.version = HPGVersion::VERSION
  spec.authors = ['Neal Patel']
  spec.email = 'nealp9084@gmail.com'
  spec.summary = 'Heroku Postgres Helper'
  spec.description = 'Automatically determines the Heroku PostgreSQL configuration'
  spec.homepage = 'https://rubygemspec.org/gems/hpg'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_dependency 'logging'
end
