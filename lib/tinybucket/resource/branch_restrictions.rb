module Tinybucket
  module Resource
    class BranchRestrictions < Base
      # Constructor
      #
      # @param repo [Tinybucket::Model::Repository]
      # @param options [Hash]
      def initialize(repo, options)
        @repo = repo
        @args = [options]
      end

      # Create new BranchRestriction on the repository.
      #
      # @param _options [Hash]
      # @return [Tinybucket::Model::BranchRestriction]
      def create(_options)
        raise NotImplementedError
      end

      # Find the BranchRestriction on the repository.
      #
      # @param _options [Hash]
      # @return [Tinybucket::Model::BranchRestriction]
      def find(restriction_id, options = {})
        restrictions_api.find(restriction_id, options).tap do |m|
          inject_repo_keys(m, @repo.repo_keys)
        end
      end

      private

      def restrictions_api
        create_api('BranchRestrictions', @repo.repo_keys)
      end

      def enumerator
        create_enumerator(restrictions_api, :list, *@args) do |m|
          inject_repo_keys(m, @repo.repo_keys)
        end
      end
    end
  end
end
