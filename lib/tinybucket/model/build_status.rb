module Tinybucket
  module Model
    # Build Status
    #
    # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/commit/%7Bnode%7D/statuses/build
    #   statuses/build Resource
    #
    # @!attribute [rw] state
    #   @return [String]
    # @!attribute [rw] type
    #   @return [String]
    # @!attribute [rw] key
    #   @return [String]
    # @!attribute [rw] name
    #   @return [String]
    # @!attribute [rw] url
    #   @return [String]
    # @!attribute [rw] description
    #   @return [String]
    # @!attribute [rw] links
    #   @return [Hash]
    class BuildStatus < Base
      include Tinybucket::Model::Concerns::RepositoryKeys
      include Tinybucket::Model::Concerns::Reloadable

      acceptable_attributes \
        :state, :type, :key, :name, :url, :description, :links, \
        :created_on, :updated_on

      attr_accessor :revision

      # Update build status
      #
      # @param options [Hash]
      # @option options [String] :state
      # @return [Tinybucket::Model::BuildStatus]
      def update(options)
        build_status_api.put(revision, key, options).tap do |m|
          m.repo_keys = repo_keys
          m.revision = revision
        end
      end

      private

      def build_status_api
        create_api('BuildStatus', repo_keys)
      end

      def load_model
        build_status_api.find(revision, key)
      end
    end
  end
end
