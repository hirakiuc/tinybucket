module Tinybucket
  module Api
    # Commits Api client
    #
    # @!attribute [rw] repo_owner
    #   @return [String] repository owner name.
    # @!attribute [rw] repo_slug
    #   @return [String] repository slug. (about {https://confluence.atlassian.com/bitbucket/repositories-endpoint-423626330.html#repositoriesEndpoint-Overview
    #     repo_slug})
    class CommitsApi < BaseApi
      include Tinybucket::Api::Helper::CommitsHelper

      attr_accessor :repo_owner, :repo_slug

      # Send 'GET a commits list for a repository' request
      #
      # @see https://confluence.atlassian.com/bitbucket/commits-or-commit-resource-389775478.html#commitsorcommitResource-GETacommitslistforarepositoryorcomparecommitsacrossbranches
      #   GET a commits list for a repository
      #
      # @note This method does not support 'compare commits across branches'
      #   API call, yet.
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def list(options = {})
        get_path(
          path_to_list,
          options,
          Tinybucket::Parser::CommitsParser
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
          Tinybucket::Parser::CommitParser
        )
      end
    end
  end
end
