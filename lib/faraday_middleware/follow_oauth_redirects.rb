# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'

module FaradayMiddleware
  class FollowOAuthRedirects < FollowRedirects
    dependency 'simple_oauth'

    AUTH_HEADER = OAuth::AUTH_HEADER
    CONTENT_TYPE = OAuth::CONTENT_TYPE
    TYPE_URLENCODED = OAuth::TYPE_URLENCODED

    def update_env(env, request_body, response)
      env = super(env, request_body, response)

      # update Authentication Header
      if oauth_signed_request?(env)
        env[:request_headers][OAuth::AUTH_HEADER] = oauth_header(env).to_s
      end

      env
    end

    def oauth_header(env)
      SimpleOAuth::Header.new env[:method],
                              env[:url].to_s,
                              signature_params(body_params(env)),
                              oauth_options(env)
    end

    def oauth_signed_request?(env)
      env[:request].oauth
    end

    def oauth_options(env)
      extra = env[:request][:oauth]
      if extra.present? and extra.is_a? Hash and !extra.empty?
        @options.merge extra
      else
        @options
      end
    end

    def body_params(env)
      if include_body_params?(env)
        if env[:body].respond_to?(:to_str)
          ::Faraday::Utils.parse_nested_query env[:body]
        else
          env[:body]
        end
      end || {}
    end

    def include_body_params?(env)
      # see RFC 5849, section 3.4.1.3.1 for details
      !(type = env[:request_headers][OAuth::CONTENT_TYPE]) ||
        type == OAuth::TYPE_URLENCODED
    end

    def signature_params(params)
      return params if params.empty?
      params.reject { |_k, v| v.respond_to?(:content_type) }
    end
  end

  if Faraday::Middleware.respond_to? :register_middleware
    Faraday::Response.register_middleware \
      follow_oauth_redirects: -> { FollowOAuthRedirects }
  end
end
