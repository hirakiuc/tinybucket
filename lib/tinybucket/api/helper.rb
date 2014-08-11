module Tinybucket
  module Api
    module Helper
      extend ActiveSupport::Autoload

      autoload :ApiHelper
      autoload :CommitsHelper
      autoload :ReposHelper
      autoload :RepoHelper
      autoload :PullRequestsHelper
      autoload :TeamHelper
      autoload :UserHelper
    end
  end
end
