# frozen_string_literal: true

module Tinybucket
  module Api
    extend ActiveSupport::Autoload

    [
      :BaseApi,
      :BranchesApi,
      :TagsApi,
      :BranchRestrictionsApi,
      :BuildStatusApi,
      :CommitsApi,
      :CommentsApi,
      :DiffApi,
      :ProjectsApi,
      :PullRequestsApi,
      :ReposApi,
      :RepoApi,
      :TeamApi,
      :UserApi
    ].each do |klass_name|
      autoload klass_name
    end
  end
end
