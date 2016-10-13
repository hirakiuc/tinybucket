module Tinybucket
  module Api
    # Commits Api client
    #
    # @!attribute [rw] repo_owner
    #   @return [String] repository owner name.
    # @!attribute [rw] repo_slug
    #   @return [String] repository slug. (about {https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D
    class BranchesApi < BaseApi
      include Tinybucket::Api::Helper::BranchesHelper

      attr_accessor :repo_owner, :repo_slug

      # Send 'GET a branches list for a repository' request
      #
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/refs/branches#get
      #   GET a branches list for a repository
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def list(options = {})
        get_path(
          path_to_list,
          options,
          Tinybucket::Parser::BranchesParser
        )
      end

      # Send 'GET an individual commit' request
      #
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/refs/branches/%7Bname%7D#get
      #   GET an individual commit
      #
      # @param revision [String] A SHA1 value for the commit.
      # @param options [Hash]
      # @return [Tinybucket::Model::Commit]
      def find(revision, options = {})
        get_path(
          path_to_find(revision),
          options,
          Tinybucket::Parser::BranchParser
        )
      end
    end
  end
end
