# frozen_string_literal: true

module Tinybucket
  module Model
    # Commit Resource
    #
    # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/commit
    #      https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/commits
    #   Commit Resource - Bitbucket Cloud REST API document
    #
    # @!attribute [rw] hash
    #   @return [String]
    # @!attribute [rw] links
    #   @return [Hash]
    # @!attribute [rw] repository
    #   @return [Hash]
    # @!attribute [rw] author
    #   @return [Hash]
    # @!attribute [rw] parents
    #   @return [Array]
    # @!attribute [rw] date
    #   @return [String]
    # @!attribute [rw] message
    #   @return [String]
    # @!attribute [rw] participants
    #   @return [Array]
    # @!attribute [rw] uuid
    #   @return [NillClass]
    # @!attribute [rw] type
    #   @return [String]
    class Commit < Base
      include Tinybucket::Model::Concerns::RepositoryKeys
      include Tinybucket::Constants

      acceptable_attributes \
        :hash, :links, :repository, :author, :parents, :date,
        :message, :participants, :uuid, :type

      # Get comments which associate with this commit.
      #
      # @param options [Hash]
      # @return [Tinybucket::Resource::Commit::Comments]
      def comments(options = {})
        comments_resource(options)
      end

      # Get the specific commit comment which associate with this commit.
      #
      # @param comment_id [String] comment id
      # @param options [Hash]
      # @return [Tinybucket::Model::Comment]
      def comment(comment_id, options = {})
        comments_resource.find(comment_id, options)
      end

      # Give approval on this commit.
      #
      # @param options [Hash]
      # @return [true]
      # @return [false]
      def approve(options = {})
        commit_api.approve(hash, options)
      end

      # Revoke approval on this commit.
      #
      # @param options [Hash]
      # @return [true]
      # @return [false]
      def unapprove(options = {})
        commit_api.unapprove(hash, options)
      end

      # Get build status resource
      #
      # @param options [Hash]
      # @return [Tinybucket::Resource::Commit::BuildStatuses]
      def build_statuses(options = {})
        build_statuses_resource(options)
      end

      # Get the specific build status which associate with key.
      #
      # @param key [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::BuildStatus]
      # @return [nil] when build_status does not found.
      def build_status(key, options = {})
        build_statuses_resource.find(key, options)
      rescue Tinybucket::Error::NotFound
        nil
      end

      private

      def comments_resource(options = {})
        Tinybucket::Resource::Commit::Comments.new(self, options)
      end

      def build_statuses_resource(options = {})
        Tinybucket::Resource::Commit::BuildStatuses.new(self, options)
      end

      def commit_api
        create_api('Commits', repo_keys)
      end

      def load_model
        commit_api.find(hash)
      end
    end
  end
end
