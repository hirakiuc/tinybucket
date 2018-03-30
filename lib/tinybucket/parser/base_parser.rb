# frozen_string_literal: true

module Tinybucket
  module Parser
    class BaseParser < FaradayMiddleware::ResponseMiddleware
      def parse_response?(env)
        (env[:body]).is_a?(Hash)
      end
    end
  end
end
