# frozen_string_literal: true

module Tinybucket
  module Api
    module Helper
      extend ActiveSupport::Autoload

      [
        :ApiHelper,
        :BranchesHelper,
        :BranchRestrictionsHelper,
        :BuildStatusHelper,
        :CommitsHelper,
        :CommentsHelper,
        :DiffHelper,
        :HooksHelper,
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
