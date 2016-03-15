module Tinybucket
  module Model
    class PullRequest < Base
      include Tinybucket::Model::Concerns::RepositoryKeys
      include Tinybucket::Model::Concerns::Reloadable
      include Tinybucket::Constants

      acceptable_attributes \
        :state, :description, :links, :title, :close_source_branch,
        :destination, :reason, :id, :source, :created_on, :author, :updated_on,
        :merge_commit, :closed_by, :reviewers, :participants, :uuid

      def create(_params)
        raise NotImplementedError
      end

      def update(_params)
        raise NotImplementedError
      end

      def decline(options = {})
        pull_request_api.decline(id, options)
      end

      def approve(options = {})
        pull_request_api.approve(id, options)
      end

      def unapprove(options = {})
        pull_request_api.unapprove(id, options)
      end

      def commits(options = {})
        pull_request_api.commits(id, options)
      end

      def comments(options = {})
        comment_api.list(options)
      end

      def comment(comment_id, options = {})
        comment_api.find(comment_id, options)
      end

      def diff(options = {})
        pull_request_api.diff(id, options)
      end

      def merge(options = {})
        pull_request_api.merge(id, options)
      end

      private

      def comment_api
        api = create_api('Comments', repo_keys)
        api.commented_to = self
        api
      end

      def pull_request_api
        raise ArgumentError, MISSING_REPOSITORY_KEY unless repo_keys?

        create_api('PullRequests', repo_keys)
      end

      def load_model
        pull_request_api.find(id)
      end
    end
  end
end
