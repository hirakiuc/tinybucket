# frozen_string_literal: true

module Tinybucket
  module Api
    # PullRequests Api client
    #
    # @see https://confluence.atlassian.com/bitbucket/pullrequests-resource-423626332.html
    #   pullrequests Resource
    #
    # @!attribute [rw] repo_owner
    #   @return [String] repository owner name.
    # @!attribute [rw] repo_slug
    #   @return [String] repository slug. (about {https://confluence.atlassian.com/bitbucket/repositories-endpoint-423626330.html#repositoriesEndpoint-Overview
    #     repo_slug})
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
          Tinybucket::Parser::PullRequestsParser
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
          Tinybucket::Parser::PullRequestParser
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
          Tinybucket::Parser::CommitsParser
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
        logger.debug 'Already approved: ' + e.inspect
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
        logger.debug 'Already unapproved: ' + e.inspect
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
