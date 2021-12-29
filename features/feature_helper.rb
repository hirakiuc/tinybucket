require 'rubygems'
require 'bundler/setup'

require 'rspec'
require 'pry'
require 'simplecov'
SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
SimpleCov.start do
  add_filter '.bundle/'
  add_filter './features'
  add_filter 'spec'
end

require 'tinybucket'

path = Pathname.new(Dir.pwd)
Dir[path.join('features/support/**/*.rb')].each { |f| require f }

# configure tinybucket logger.
logger = Logger.new($stdout)
logger.level = Logger::INFO

Tinybucket.configure do |config|
  config.logger = logger

  config.oauth_token = ENV['FEATURE_TEST_OAUTH_TOKEN']
  config.oauth_secret = ENV['FEATURE_TEST_OAUTH_SECRET']
end

RSpec.configure do |config|
  config.order = 'random'

  config.before(:each) do
    sleep 0.5
  end
end
