require 'bitbucket/version'

require 'active_support/dependencies/autoload'

require 'active_support/core_ext/hash'
require 'active_support/configurable'
require 'active_support/inflector'

require 'faraday'
require 'faraday_middleware'
require 'faraday_middleware/response_middleware'
require 'faraday_middleware/follow_oauth_redirects'

require 'active_model'

require 'logger'

require 'bitbucket/api'
require 'bitbucket/api_factory'
require 'bitbucket/client'
require 'bitbucket/connection'
require 'bitbucket/constants'
require 'bitbucket/error'
require 'bitbucket/models'
require 'bitbucket/parser'
require 'bitbucket/request'
require 'bitbucket/response'

require 'active_support/notifications'
ActiveSupport::Notifications.subscribe('request.faraday') \
  do |_name, start_time, end_time, _, env|
    url = env[:url]
    http_method = env[:method].to_s.upcase
    duration = end_time - start_time
    Bitbucket.logger.debug \
      format(
        '[%s] %s %s (%.3f s)',
        url.host, http_method, url.request_uri, duration
      )
  end

module Bitbucket
  class << self
    include ActiveSupport::Configurable
    attr_accessor :logger, :api_client

    def new(options = {}, &block)
      @api_client = Bitbucket::Client.new(options, &block)
    end

    def logger
      @logger ||= begin
                    logger = Logger.new($stdout)
                    logger.level = Logger::DEBUG
                    logger
                  end
    end
  end
end
