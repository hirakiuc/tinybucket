module Tinybucket
  module Api
    # BranchRestrictions API client
    #
    # @see https://confluence.atlassian.com/bitbucket/branch-restrictions-resource-387449181.html
    #   branch-restrictions Resource
    #
    # @!attribute [rw] repo_owner
    #   @return [String] repository owner name.
    # @!attribute [rw] repo_slug
    #   @return [String] repository slug. (about {https://confluence.atlassian.com/bitbucket/repositories-endpoint-423626330.html#repositoriesEndpoint-Overview
    #     repo_slug})
    class BranchRestrictionsApi < BaseApi
      include Tinybucket::Api::Helper::BranchRestrictionsHelper

      attr_accessor :repo_owner, :repo_slug

      # Send 'GET the branch-restrictions' request.
      #
      # @see https://confluence.atlassian.com/bitbucket/branch-restrictions-resource-387449181.html#branch-restrictionsResource-GETthebranch-restrictions
      #   GET the branch-restrictions
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def list(options = {})
        get_path(
          path_to_list,
          options,
          Tinybucket::Parser::BranchRestrictionsParser
        )
      end

      # Send 'GET a specific restriction' request.
      #
      # @see https://confluence.atlassian.com/bitbucket/branch-restrictions-resource-387449181.html#branch-restrictionsResource-GETaspecificrestriction
      #   GET a specific restriction
      #
      # @param restriction_id [String] The restriction's identifier
      # @param options [Hash]
      # @return [Tinybucket::Model::BranchRestriction]
      def find(restriction_id, options = {})
        get_path(
          path_to_find(restriction_id),
          options,
          Tinybucket::Parser::BranchRestrictionParser
        )
      end
    end
  end
end
