module Tinybucket
  module Model
    class PullRequest < Base
      attr_accessor \
        :state, :description, :links, :title, :close_source_branch,
        :destination, :reason, :id, :source, :created_on, :author, :updated_on,
        :merge_commit, :closed_by, :reviewers, :participants

      attr_accessor :repository

      def commits(options = {})
        fail ArgumentError, 'This method call require repository.' \
          if repository.nil?

        api = pull_requests_api(repository.repo_owner,
                                repository.repo_slug,
                                options)
        api.commits(id, options)
      end
    end
  end
end
