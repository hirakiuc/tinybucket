# frozen_string_literal: true

module Tinybucket
  module Api
    extend ActiveSupport::Autoload

    [
      :BaseApi,
      :BranchesApi,
      :BranchRestrictionsApi,
      :BuildStatusApi,
      :CommitsApi,
      :CommentsApi,
      :DiffApi,
      :EmailsApi,
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
