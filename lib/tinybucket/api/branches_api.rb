module Tinybucket
  module Api
    # Commits Api client
    #
    # @!attribute [rw] repo_owner
    #   @return [String] repository owner name.
    # @!attribute [rw] repo_slug
    #   @return [String] repository slug. (about {https://confluence.atlassian.com/bitbucket/repositories-endpoint-423626330.html#repositoriesEndpoint-Overview
    #     repo_slug})
    class BranchesApi < BaseApi
      include Tinybucket::Api::Helper::BranchesHelper

      attr_accessor :repo_owner, :repo_slug

      # Send 'GET a branches list for a repository' request
      #
      # @see https://confluence.atlassian.com/bitbucket/branches-or-commit-resource-389775478.html#branchesorcommitResource-GETabrancheslistforarepositoryorcomparebranchesacrossbranches
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
      # @see https://confluence.atlassian.com/bitbucket/commits-or-commit-resource-389775478.html#commitsorcommitResource-GETanindividualcommit
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
