module Tinybucket
  module Model
    class PullRequest < Base
      include Tinybucket::Model::Concerns::RepositoryKeys
      include Tinybucket::Model::Concerns::Reloadable

      attr_accessor \
        :state, :description, :links, :title, :close_source_branch,
        :destination, :reason, :id, :source, :created_on, :author, :updated_on,
        :merge_commit, :closed_by, :reviewers, :participants

      def create(_params)
        fail NotImplementedError
      end

      def update(_params)
        fail NotImplementedError
      end

      def approve(options = {})
        pull_request_api(options).approve(id, options)
      end

      def unapprove(options = {})
        pull_request_api(options).unapprove(id, options)
      end

      def commits(options = {})
        pull_request_api(options).commits(id, options)
      end

      private

      def pull_request_api(options)
        fail ArgumentError,
             'This method call require repository keys.' unless repo_keys?

        create_api('PullRequests', repo_keys, options)
      end

      def load_model
        pull_request_api({}).find(id)
      end
    end
  end
end
