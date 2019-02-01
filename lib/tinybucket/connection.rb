# frozen_string_literal: true

module Tinybucket
  module Connection
    DEFAULT_USER_AGENT = 'Tinybucket Ruby Bitbucket REST client'.freeze

    def clear_cache
      @connection = nil
    end

    def caching?
      !@connection.nil?
    end

    def connection(parser = nil, options = {})
      conn_options = default_options(options)
      clear_cache

      # TODO: cache connection for each (options, parser) pairs.
      Faraday.new(
        conn_options.merge(builder: stack(parser, options))
      )
    end

    private

    def default_options(_options)
      {
        headers: {
          USER_AGENT: Tinybucket.config.user_agent || DEFAULT_USER_AGENT
        },
        ssl: { verify: false },
        url: 'https://api.bitbucket.org/2.0'.freeze,
        request: {
          params_encoder: Tinybucket::Encoder::ApiParamsEncoder
        }
      }
    end

    def default_middleware(_options)
      proc do |conn|
        configure_response_cache(conn)

        conn.request :multipart
        conn.request :url_encoded

        configure_auth(conn)

        conn.response :json, content_type: /\bjson$/
        conn.use Tinybucket::Response::Handler
        conn.use :instrumentation

        conn.adapter Faraday.default_adapter
      end
    end

    def configure_auth(conn)
      if Tinybucket.config.access_token
        conn.request :oauth2, Tinybucket.config.access_token
      else
        oauth_secrets = {
          consumer_key:    Tinybucket.config.oauth_token,
          consumer_secret: Tinybucket.config.oauth_secret
        }

        conn.request :oauth, oauth_secrets
        conn.response :follow_oauth_redirects, oauth_secrets
      end
    end

    def configure_response_cache(conn)
      return unless Tinybucket.config.cache_store_options

      conn.use :http_cache, Tinybucket.config.cache_store_options
    end

    def stack(parser, options = {}, &block)
      Faraday::RackBuilder.new(&block) and return if block_given?

      # TODO: cache stack for each (options, parser) pairs
      Faraday::RackBuilder.new do |conn|
        conn.use parser.type,  parser_options: parser.options if parser.present?
        default_middleware(options).call(conn)
      end
    end
  end
end
