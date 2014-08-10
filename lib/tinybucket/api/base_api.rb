module Bitbucket
  module Api
    class BaseApi
      include Bitbucket::Connection
      include Bitbucket::Request

      def initialize(config, options = {})
        @config = filter_config(config)
        @options = options
        yield if block_given?
      end

      protected

      def option(key)
        @options[key.intern]
      end

      def config(key)
        @config[key.intern]
      end

      private

      def filter_config(config)
        keys = %i(oauth_token oauth_secret)
        config.select { |key, _| keys.include?(key) }
      end
    end
  end
end
