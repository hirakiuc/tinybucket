module Tinybucket
  module Model
    # Branch
    #
    # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/refs/branches
    #   Branch resource - Bitbucket Cloud REST API document
    #
    # @!attribute [rw] links
    #   @return [Hash]
    # @!attribute [rw] type
    #   @return [String]
    # @!attribute [rw] name
    #   @return [String]
    # @!attribute [rw] repository
    #   @return [Hash]
    # @!attribute [rw] target
    #   @return [Hash]
    class Branch < Base
      include Tinybucket::Model::Concerns::RepositoryKeys

      acceptable_attributes :links, :type, :name, :repository, :target

      def commits
        commits_api.branch(name)
      end

      private

      def commits_api
        create_api('Commits', repo_keys)
      end

      def branches_api
        create_api('Branches', repo_keys)
      end

      def load_model
        branches_api.find(name, {})
      end
    end
  end
end
