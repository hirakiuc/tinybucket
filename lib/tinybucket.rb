require 'tinybucket/version'

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

require 'tinybucket/api'
require 'tinybucket/api_factory'
require 'tinybucket/api/helper'
require 'tinybucket/client'
require 'tinybucket/connection'
require 'tinybucket/constants'
require 'tinybucket/error'
require 'tinybucket/models'
require 'tinybucket/parser'
require 'tinybucket/request'
require 'tinybucket/response'

require 'active_support/notifications'
ActiveSupport::Notifications.subscribe('request.faraday') \
  do |_name, start_time, end_time, _, env|
    url = env[:url]
    http_method = env[:method].to_s.upcase
    duration = end_time - start_time
    Tinybucket.logger.debug \
      format(
        '[%s] %s %s (%.3f s)',
        url.host, http_method, url.request_uri, duration
      )
  end

module Tinybucket
  class << self
    include ActiveSupport::Configurable
    attr_accessor :logger, :api_client

    def new(options = {}, &block)
      @api_client = Tinybucket::Client.new(options, &block)
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
