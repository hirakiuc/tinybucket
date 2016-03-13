module Tinybucket
  class Config
    include ActiveSupport::Configurable
    config_accessor :logger, :oauth_token, :oauth_secret
  end
end
