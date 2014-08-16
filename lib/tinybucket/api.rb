module Tinybucket
  module Api
    extend ActiveSupport::Autoload

    autoload :BaseApi
    autoload :BranchRestrictionsApi
    autoload :CommitsApi
    autoload :CommitCommentsApi
    autoload :PullRequestsApi
    autoload :ReposApi
    autoload :RepoApi
    autoload :TeamApi
    autoload :UserApi
  end
end
