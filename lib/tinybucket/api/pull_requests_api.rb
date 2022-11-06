# frozen_string_literal: true

module Tinybucket
  module Api
    # PullRequests Api client
    #
    # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/pullrequests
    #   pullrequests Resource
    #
    # @!attribute [rw] repo_owner
    #   @return [String] repository owner name.
    # @!attribute [rw] repo_slug
    #   @return [String] {https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D repository slug}.
    class PullRequestsApi < BaseApi
      include Tinybucket::Api::Helper::PullRequestsHelper

      attr_accessor :repo_owner, :repo_slug

      # Send 'GET a list of open pull requests' request
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def list(options = {})
        get_path(
          path_to_list,
          options,
          get_parser(:collection, Tinybucket::Model::PullRequest)
        )
      end

      # Send 'GET a specific pull request' request
      #
      # @param pr_id [String] The pull request identifier
      # @param options [Hash]
      # @return [Tinybucket::Model::PullRequest]
      def find(pr_id, options = {})
        get_path(
          path_to_find(pr_id),
          options,
          get_parser(:object, Tinybucket::Model::PullRequest)
        )
      end

      # Send 'GET the commits for a pull request' request
      #
      # @param pr_id [String] The pull request identifier
      # @param options [Hash]
      # @return [Tinybucket::Model::PullRequest]
      def commits(pr_id, options = {})
        get_path(
          path_to_commits(pr_id),
          options,
          get_parser(:collection, Tinybucket::Model::Commit)
        )
      end

      # Send 'POST a pull request approval' request
      #
      # @note This method return true if this pull request already approved.
      #
      # @param pr_id [String] The pull request identifier
      # @param options [Hash]
      # @return [true, false]
      def approve(pr_id, options = {})
        result = post_path(path_to_approve(pr_id), options)
        (result['approved'] == true)
      rescue Tinybucket::Error::Conflict => e
        logger.debug "Already approved: #{e.inspect}"
        true
      end

      # Send 'DELETE a pull request approval' request
      #
      # @note This method return true if this pull request is not approved yet.
      #
      # @param pr_id [String] The pull request identifier
      # @param options [Hash]
      # @return [true]
      def unapprove(pr_id, options = {})
        delete_path(path_to_approve(pr_id), options)
        true
      rescue Tinybucket::Error::NotFound => e
        logger.debug "Already unapproved: #{e.inspect}"
        true
      end

      # Send 'Decline or reject a pull request' request
      #
      # @param pr_id [String] The pull request identifier
      # @param options [Hash]
      # @return [true, false]
      def decline(pr_id, options = {})
        result = post_path(path_to_decline(pr_id), options)
        (result['state'] == 'DECLINED')
      end

      # Send 'Accept and merge a pull request' request
      #
      # @param pr_id [String] The pull request identifier
      # @param options [Hash]
      # @return [true, false]
      def merge(pr_id, options = {})
        result = post_path(path_to_merge(pr_id), options)
        (result['state'] == 'MERGED')
      end

      # Send 'GET the diff for a pull request' request
      #
      # @param pr_id [String] The pull request identifier
      # @param options [Hash]
      # @return [String] diff as raw text.
      def diff(pr_id, options = {})
        get_path(path_to_diff(pr_id), options)
      end
    end
  end
end
