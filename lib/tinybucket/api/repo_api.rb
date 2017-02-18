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
          Tinybucket::Parser::RepoParser
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
          Tinybucket::Parser::ProfilesParser
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
          Tinybucket::Parser::ReposParser
        )
      end
    end
  end
end
