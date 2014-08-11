require 'rubygems'
require 'bundler/setup'

require 'rspec'
require 'webmock/rspec'

require 'pry'

require 'coveralls'
require 'simplecov'
Coveralls.wear!

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_filter '.bundle/'
  add_filter 'spec'
end

if ENV['CODECLIMATE_REPO_TOKEN']
  WebMock.disable_net_connect!(allow: 'codeclimate.com')
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
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
  config.order = 'random'
end
