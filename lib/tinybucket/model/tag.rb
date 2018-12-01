# frozen_string_literal: true

module Tinybucket
  module Model
    # Tag
    #
    # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/refs/tags
    #   Tag Resource
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
    class Tag < Base
      include Tinybucket::Model::Concerns::RepositoryKeys

      acceptable_attributes :links, :type, :name, :repository, :target, :tagger, :date, :message

      # Returns the commits available for the specific tag
      #
      # @param options [Hash]
      # @return [Tinybucket::Resource::Commits]
      def commits(options = {})
        commits_resource.tag(name, options)
      end

      private

      def commits_resource(options = {})
        Tinybucket::Resource::Commits.new(self, options)
      end

      def tags_api
        create_api('Tags', repo_keys)
      end

      def load_model
        tags_api.find(name, {})
      end
    end
  end
end
