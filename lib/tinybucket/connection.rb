module Tinybucket
  module Connection
    def clear_cache
      @connection = nil
    end

    def caching?
      !@connection.nil?
    end

    def connection(options = {}, parser = nil)
      conn_options = default_options(options)
      clear_cache

      # TODO: cache connection for each (options, parser) pairs.
      Faraday.new(
        conn_options.merge(builder: stack(parser, options)))
    end

    private

    def default_options(_options)
      {
        headers: {
          USER_AGENT: 'test client' # TODO: fix this !
        },
        ssl: { verify: false },
        url: 'https://api.bitbucket.org/2.0'.freeze
      }
    end

    def default_middleware(_options)
      proc do |conn|
        oauth_secrets = {
          consumer_key:    Tinybucket.config.oauth_token,
          consumer_secret: Tinybucket.config.oauth_secret
        }

        conn.request :multipart
        conn.request :url_encoded
        conn.request :oauth, oauth_secrets

        conn.response :follow_oauth_redirects, oauth_secrets
        conn.response :json, content_type: /\bjson$/
        conn.use Tinybucket::Response::Handler
        conn.use :instrumentation

        conn.adapter Faraday.default_adapter
      end
    end

    def stack(parser, options = {}, &block)
      Faraday::RackBuilder.new(&block) and return if block_given?

      # TODO: cache stack for each (options, parser) pairs
      Faraday::RackBuilder.new do |conn|
        conn.use parser if parser.present?
        default_middleware(options).call(conn)
      end
    end
  end
end
