source 'https://rubygems.org'

# Specify your gem's dependencies in bitbucket.gemspec
gemspec

gem 'simple-auth', '~> 0.3.1'
gem 'yard', '~> 0.8.7'
gem 'yardstick', '~> 0.9'

group :development, :test do
  gem 'pry'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'
  gem 'pry-rescue'

  gem 'guard-rspec'
  gem 'guard-spork'

  gem 'guard-rubocop'
  gem 'gem-release'

  gem 'rake', '~> 10.4'
  gem 'rspec', '~> 3.4'
  gem 'rspec-mocks', '~> 3.4'
  gem 'webmock', '~> 1.24'
  gem 'rubocop', '~> 0.41'

end

group :test do
  gem 'simplecov', '~> 0.11', require: false
  gem 'coveralls', '~> 0.8', require: false
  gem 'codeclimate-test-reporter', require: nil
end
