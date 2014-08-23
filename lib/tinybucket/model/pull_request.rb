module Tinybucket
  module Model
    class PullRequest < Base
      attr_accessor \
        :state, :description, :links, :title, :close_source_branch,
        :destination, :reason, :id, :source, :created_on, :author, :updated_on,
        :merge_commit, :closed_by, :reviewers, :participants

      attr_accessor :repository

      def approve(options = {})
        pullreq_api(options).approve(id, options)
      end

      def unapprove(options = {})
        pullreq_api(options).unapprove(id, options)
      end

      def commits(options = {})
        pullreq_api(options).commits(id, options)
      end

      private

      def pullreq_api(options)
        fail ArgumentError,
             'This method call require repository.' if repository.nil?

        pull_requests_api(repository.repo_owner, repository.repo_slug, options)
      end
    end
  end
end
