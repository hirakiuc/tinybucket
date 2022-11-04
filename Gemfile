source 'https://rubygems.org'

# Specify your gem's dependencies in bitbucket.gemspec
gemspec

gem 'simple-auth', '~> 0.5.0'
gem 'yard', '~> 0.9.12'
gem 'yardstick', '~> 0.9.9'

group :development, :test do
  gem 'pry'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'
  gem 'pry-rescue'

  gem 'guard-rspec'
  gem 'guard-spork'

  gem 'guard-rubocop'
  gem 'gem-release'

  gem 'rake', '~> 13.0'
  gem 'rspec', '~> 3.4'
  gem 'rspec-mocks', '~> 3.4'
  gem 'webmock', '~> 3.12.1'
  gem 'rubocop', '~> 1.11.0'
end

group :test do
  gem 'simplecov', '~> 0.21.2', require: false
end
