require 'faraday_middleware/response_middleware'
require 'bitbucket/models/page'

module Bitbucket
  module Parser
    class BaseParser < FaradayMiddleware::ResponseMiddleware
      def process_response(env)
        env[:body] = convert(env[:body])
      end

      def parse_response?(env)
        (env[:body]).is_a?(Hash)
      end

      # override on subclass
      def convert(_json)
      end
    end
  end
end
