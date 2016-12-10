# frozen_string_literal: true

module Tinybucket
  module Api
    class BaseApi
      include Tinybucket::Connection
      include Tinybucket::Request

      private

      def logger
        Tinybucket.logger
      end
    end
  end
end
