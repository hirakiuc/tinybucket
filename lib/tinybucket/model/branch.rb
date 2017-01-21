# frozen_string_literal: true

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

      # Returns the commits available for the specific branch
      #
      # @param options [Hash]
      # @return [Tinybucket::Resource::Commits]
      def commits(options = {})
        commits_resource.branch(name, options)
      end

      private

      def commits_resource(options = {})
        Tinybucket::Resource::Commits.new(self, options)
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
