module Bitbucket
  module Api
    extend ActiveSupport::Autoload

    autoload :BaseApi
    autoload :PullRequestsApi
    autoload :RepoApi
    autoload :ReposApi
    autoload :TeamsApi
    autoload :UsersApi
  end
end
