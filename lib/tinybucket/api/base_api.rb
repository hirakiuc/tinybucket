module Tinybucket
  module Api
    class BaseApi
      include Tinybucket::Connection
      include Tinybucket::Request

      def initialize(options = {})
        @options = options
      end

      protected

      def option(key)
        @options[key.intern]
      end
    end
  end
end
