require 'faraday'
require 'faraday_middleware'
require 'bitbucket/response/error_handler'

module Bitbucket
  module Connection
    def clear_cache
      @connection = nil
    end

    def caching?
      !@connection.nil?
    end

    def connection(options = {}, parser = nil)
      conn_options = default_options(options)
      clear_cache unless options.empty?

      @connection ||= Faraday.new(
        conn_options.merge(builder: stack(options, parser)))
    end

    private

    def default_options(_options)
      {
        headers: {
          USER_AGENT: 'test client' # TODO: fix this !
        },
        ssl: { verify: false },
        url: 'https://bitbucket.org/api/2.0'.freeze
      }
    end

    def default_middleware(options)
      proc do |conn|
        conn.request :multipart
        conn.request :url_encoded
        conn.request \
          :oauth,
          consumer_key: config(:oauth_token),
          consumer_secret: config(:oauth_secret)

        conn.response :json, content_type: /\bjson$/
        conn.use Bitbucket::Response::ErrorHandler
        conn.use :instrumentation

        conn.adapter Faraday.default_adapter
      end
    end

    def stack(options = {}, parser, &block)
      @stack ||=
        begin
          if block_given?
            Faraday::Builder.new(&block)
          else
            Faraday::Builder.new do |conn|
              conn.use parser if parser.present?
              default_middleware(options).call(conn)
            end
          end
        end
    end
  end
end
