# frozen_string_literal: true

module Tinybucket
  module Api
    module Helper
      extend ActiveSupport::Autoload

      [
        :ApiHelper,
        :BranchesHelper,
        :BranchRestrictionsHelper,
        :TagsHelper,
        :BuildStatusHelper,
        :CommitsHelper,
        :CommentsHelper,
        :DiffHelper,
        :HooksHelper,
        :ReposHelper,
        :RepoHelper,
        :PullRequestsHelper,
        :ProjectsHelper,
        :TeamHelper,
        :UserHelper
      ].each do |klass_name|
        autoload klass_name
      end
    end
  end
end
