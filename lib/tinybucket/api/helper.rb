module Tinybucket
  module Api
    module Helper
      extend ActiveSupport::Autoload

      autoload :ApiHelper
      autoload :BranchRestrictionsHelper
      autoload :CommitsHelper
      autoload :CommitCommentsHelper
      autoload :DiffHelper
      autoload :ReposHelper
      autoload :RepoHelper
      autoload :PullRequestsHelper
      autoload :TeamHelper
      autoload :UserHelper
    end
  end
end
