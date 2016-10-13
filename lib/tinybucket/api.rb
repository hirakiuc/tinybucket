module Tinybucket
  module Api
    extend ActiveSupport::Autoload

    [
      :BaseApi,
      :BranchRestrictionsApi,
      :BranchesApi,
      :BuildStatusApi,
      :CommitsApi,
      :CommentsApi,
      :DiffApi,
      :EmailsApi,
      :HooksApi,
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
