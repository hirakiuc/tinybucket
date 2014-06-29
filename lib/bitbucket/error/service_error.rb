require 'bitbucket/error/base_error'

module Bitbucket
  module Error
    class ServiceError < BaseError
      attr_accessor :http_headers

      def initialize(env)
        super generate_message(env)
        @http_headers = env[:response_headers]
      end

      def generate_message(env)
        http_method = env[:method].to_s.upcase
        url = env[:url].to_s
        status = env[:status]

        "#{http_method} #{url} #{status} #{env[:body]}"
      end
    end
  end
end
