# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tinybucket/version'

Gem::Specification.new do |spec|
  spec.name          = 'tinybucket'
  spec.version       = Tinybucket::VERSION
  spec.authors       = ['hirakiuc']
  spec.email         = ['hirakiuc@gmail.com']
  spec.summary       = 'ruby wrapper for the Bitbucket REST API (v2) with oauth'
  spec.description   = 'ruby wrapper for the Bitbucket REST API (v2) with oauth inspired by vongrippen/bitbucket.'
  spec.homepage      = 'http://hirakiuc.github.io/tinybucket/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport',      ['= 4.1.6']
  spec.add_runtime_dependency 'faraday',            ['= 0.9.0']
  spec.add_runtime_dependency 'faraday_middleware', ['= 0.9.1']
  spec.add_runtime_dependency 'simple_oauth',       ['= 0.2.0']
  spec.add_runtime_dependency 'activemodel',        ['= 4.1.6']

  spec.add_development_dependency 'bundler',     ['~> 1.6', '>= 1.6.2']
  spec.add_development_dependency 'rake',        ['= 10.3.2']
  spec.add_development_dependency 'rspec',       ['= 3.1.0']
  spec.add_development_dependency 'rspec-mocks', ['= 3.1.0']
  spec.add_development_dependency 'webmock',     ['= 1.18.0']
  spec.add_development_dependency 'rubocop',     ['= 0.26.0']
  spec.add_development_dependency 'simplecov',   ['= 0.9.0']
  spec.add_development_dependency 'yard',        ['= 0.8.7.4']
  spec.add_development_dependency 'yardstick',   ['= 0.9.9']
end
