module Tinybucket
  module Resource
    class PullRequests < Base
      def initialize(repo, options)
        @repo = repo
        @args = [options]
      end

      # Create a new pull request.
      #
      # @todo to be implemented.
      # @raise [NotImplementedError] to be implemented.
      def create(_options)
        raise NotImplementedError
      end

      # Get the specific pull request on the repository.
      #
      # @param pullrequest_id [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::PullRequest]
      def find(pullrequest_id, options = {})
        pull_requests_api.find(pullrequest_id, options).tap do |m|
          inject_repo_keys(m, @repo.repo_keys)
        end
      end

      # Get activities on the po
      #
      # TODO: To be implemented.
      def activities(_options)
        raise NotImplementedError
      end

      private

      def pull_requests_api
        create_api('PullRequests', @repo.repo_keys)
      end

      def enumerator
        create_enumerator(pull_requests_api, :list, *@args) do |m|
          inject_repo_keys(m, @repo.repo_keys)
        end
      end
    end
  end
end
