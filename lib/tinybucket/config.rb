module Tinybucket
  class Config
    include ActiveSupport::Configurable
    config_accessor :logger, :oauth_token, :oauth_secret, \
                    :cache_store_options, :access_token, \
                    :client_id, :client_secret, :user_agent
  end
end
