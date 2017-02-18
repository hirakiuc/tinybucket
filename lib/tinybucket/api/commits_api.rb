# frozen_string_literal: true

module Tinybucket
  module Api
    # Commits Api client
    #
    # @!attribute [rw] repo_owner
    #   @return [String] repository owner name.
    # @!attribute [rw] repo_slug
    #   @return [String] {https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D repository slug}.
    class CommitsApi < BaseApi
      include Tinybucket::Api::Helper::CommitsHelper

      attr_accessor :repo_owner, :repo_slug

      # Send 'GET a commits list for a repository' request
      #
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/commits#get
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
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/commits/%7Brevision%7D#get
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

      # Send 'POST a commit approval' request
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/commit/%7Bnode%7D/approve#post
      #   POST a commit approval request
      #
      # @param revision [String]
      # @param options [Hash]
      # @return [true, false]
      def approve(revision, options = {})
        result = post_path(path_to_approve(revision), options)
        (result['approved'] == true)
      rescue Tinybucket::Error::Conflict => e
        logger.debug 'Already approved: ' + e.inspect
        true
      end

      # Send 'DELETE a commit approval' request
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/commit/%7Bnode%7D/approve#delete
      #   DELETE a commit approval (unapprove the commit)
      #
      # @param revision [String]
      # @param options [Hash]
      # @return [true, false]
      def unapprove(revision, options = {})
        delete_path(path_to_approve(revision), options)
        true
      rescue Tinybucket::Error::NotFound => e
        logger.debug 'Already unapproved: ' + e.inspect
        true
      end

      # Send 'GET commits for a branch' request
      #
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/commits
      #   GET an individual commit
      #
      # @param name [String] The branch name or a SHA1 value for the commit.
      # @param options [Hash]
      # @return [Tinybucket::Model::Commit]
      def branch(name, options = {})
        get_path(
          path_to_branch(name),
          options,
          Tinybucket::Parser::CommitsParser
        )
      end
    end
  end
end
