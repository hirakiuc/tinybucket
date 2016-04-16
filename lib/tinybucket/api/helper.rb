module Tinybucket
  module Api
    module Helper
      extend ActiveSupport::Autoload

      [
        :ApiHelper,
        :BranchRestrictionsHelper,
        :BuildStatusHelper,
        :CommitsHelper,
        :CommentsHelper,
        :DiffHelper,
        :ReposHelper,
        :RepoHelper,
        :PullRequestsHelper,
        :TeamHelper,
        :UserHelper
      ].each do |klass_name|
        autoload klass_name
      end
    end
  end
end
