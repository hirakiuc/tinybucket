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

  spec.files         =  Dir['lib/**/*', 'LICENSE', 'Rakefile', 'Gemfile', 'tinybucket.gemspec', 'README.md', '.rubocop.yml']
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activemodel',        ['>= 4.1.6']
  spec.add_runtime_dependency 'activesupport',      ['>= 4.1.6']
  spec.add_runtime_dependency 'faraday',            ['~> 0.9']
  spec.add_runtime_dependency 'faraday_middleware', ['~> 0.10']
  spec.add_runtime_dependency 'faraday-http-cache', ['~> 1.2']
  spec.add_runtime_dependency 'simple_oauth',       ['~> 0.3']

  spec.add_development_dependency 'bundler', '~> 1.10'
end
