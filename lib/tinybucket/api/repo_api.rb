# frozen_string_literal: true

module Tinybucket
  module Api
    # Repo Api client
    #
    # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories
    #   repository Resource
    #
    # @!attribute [rw] repo_owner
    #   @return [String] repository owner name.
    # @!attribute [rw] repo_slug
    #   @return [String] {https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D repository slug}.
    class RepoApi < BaseApi
      include Tinybucket::Api::Helper::RepoHelper

      attr_accessor :repo_owner, :repo_slug

      # Send 'GET a repository' request
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Repository]
      def find(options = {})
        get_path(
          path_to_find,
          options,
          get_parser(:object, Tinybucket::Model::Repository)
        )
      end

      # Send 'PUT (update) an existing repository' request
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Repository]
      def put(options = {})
        put_path(
          path_to_put,
          options,
          get_parser(:object, Tinybucket::Model::Repository)
        )
      end

      # Send 'DELETE an existing repository' request
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Repository]
      def delete(options = {})
        delete_path(
          path_to_delete,
          options,
          get_parser(:object, Tinybucket::Model::Repository)
        )
      end

      # Send 'GET a list of watchers' request
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def watchers(options = {})
        get_path(
          path_to_watchers,
          options,
          get_parser(:collection, Tinybucket::Model::Profile)
        )
      end

      # Send 'GET a list of forks' request
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def forks(options = {})
        get_path(
          path_to_forks,
          options,
          get_parser(:collection, Tinybucket::Model::Repository)
        )
      end
    end
  end
end
