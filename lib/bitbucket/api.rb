module Bitbucket
  module Api
    extend ActiveSupport::Autoload

    autoload :BaseApi
    autoload :CommitsApi
    autoload :PullRequestsApi
    autoload :ReposApi
    autoload :RepoApi
    autoload :TeamsApi
    autoload :UserApi
  end
end
