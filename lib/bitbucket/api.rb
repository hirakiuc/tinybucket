module Bitbucket
  module Api
    extend ActiveSupport::Autoload

    autoload :BaseApi
    autoload :PullRequestsApi
    autoload :PullRequestApi
    autoload :RepoApi
    autoload :ReposApi
    autoload :TeamsApi
    autoload :UsersApi
  end
end
