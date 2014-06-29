require 'faraday_middleware/response_middleware'
require 'bitbucket/models/page'

module Bitbucket
  module Parser
    class BaseParser < FaradayMiddleware::ResponseMiddleware
      def process_response(env)
        env[:body] = convert(env[:body])
      end

      def parse_response?(env)
        (env[:body]).kind_of?(Hash)
      end

      # override on subclass
      def convert(json)
      end
    end
  end
end
