# frozen_string_literal: true

module Tinybucket
  class Config
    include ActiveSupport::Configurable
    config_accessor :logger, :oauth_token, :oauth_secret,
                    :access_token, :cache_store_options
  end
end
