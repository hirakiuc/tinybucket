require 'rubygems'
require 'bundler/setup'

require 'bitbucket'
require 'rspec'
require 'webmock/rspec'

require 'pry'

require 'simplecov'
SimpleCov.start do
  add_filter '.bundle/'
  add_filter 'spec'
end

path = Pathname.new(Dir.pwd)
Dir[path.join('spec/support/**/*.rb')].each {|f| require f }

# configure bitbucket logger.
logger = Logger.new('log/test.log')
logger.level = Logger::DEBUG
Bitbucket.logger = logger


RSpec.configure do |config|

  config.order = 'random'
end
