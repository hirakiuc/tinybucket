require 'rubygems'
require 'bundler/setup'

require 'rspec'
require 'webmock/rspec'

require 'pry'

require 'simplecov'
SimpleCov.start do
  add_filter '.bundle/'
  add_filter 'spec'
  add_filter 'features'
end

require 'tinybucket'

path = Pathname.new(Dir.pwd)
Dir[path.join('spec/support/**/*.rb')].each { |f| require f }

# configure tinybucket logger.
Dir.mkdir('log') unless Dir.exist?('log')

logger = Logger.new('log/test.log')
logger.level = Logger::DEBUG
Tinybucket.logger = logger

RSpec.configure do |config|
  config.extend FixtureMacros
  config.include FixtureMacros
  config.order = 'random'
end
