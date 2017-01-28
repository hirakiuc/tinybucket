# frozen_string_literal: true

module Tinybucket
  module Api
    # BranchRestrictions API client
    #
    # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/branch-restrictions
    #   branch-restrictions Resource
    #
    # @!attribute [rw] repo_owner
    #   @return [String] repository owner name.
    # @!attribute [rw] repo_slug
    #   @return [String] repository slug. (about {https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/
    #     %7Busername%7D/%7Brepo_slug%7D})
    class BranchRestrictionsApi < BaseApi
      include Tinybucket::Api::Helper::BranchRestrictionsHelper

      attr_accessor :repo_owner, :repo_slug

      # Send 'GET the branch-restrictions' request.
      #
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/branch-restrictions#get
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
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/branch-restrictions/%7Bid%7D#get
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
