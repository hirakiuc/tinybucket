# frozen_string_literal: true

module Tinybucket
  module Error
    class BaseError < StandardError
      attr_reader :response_message, :response_headers

      def initialize(message)
        super message
        @response_message = message
      end
    end
  end
end
