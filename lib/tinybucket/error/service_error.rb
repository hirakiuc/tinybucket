# frozen_string_literal: true

module Tinybucket
  module Error
    class ServiceError < BaseError
      attr_accessor :http_headers
      attr_reader :http_method, :request_url, :status_code, :response_body

      def initialize(env)
        super generate_message(env)
        @http_headers = env[:response_headers]
      end

      private

      def generate_message(env)
        @http_method = env[:method].to_s.upcase
        @request_url = env[:url].to_s
        @status_code = env[:status]
        @response_body = env[:body]

        "#{@http_method} #{@request_url} #{@status_code} #{@response_body}"
      end
    end
  end
end
