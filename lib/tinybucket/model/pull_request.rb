# frozen_string_literal: true

module Tinybucket
  module Model
    # PullRequest
    #
    # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/pullrequests
    #   pullrequest Resource
    #
    # @!attribute [rw] state
    #   @return [String]
    # @!attribute [rw] description
    #   @return [String]
    # @!attribute [rw] links
    #   @return [Hash]
    # @!attribute [rw] title
    #   @return [String]
    # @!attribute [rw] task_count
    #   @return [Fixnum]
    # @!attribute [rw] comment_count
    #   @return [Fixnum]
    # @!attribute [rw] close_source_branch
    #   @return [true, false]
    # @!attribute [rw] destination
    #   @return [Hash]
    # @!attribute [rw] reason
    #   @return [String]
    # @!attribute [rw] id
    #   @return [Fixnum]
    # @!attribute [rw] source
    #   @return [Hash]
    # @!attribute [rw] created_on
    #   @return [String]
    # @!attribute [rw] author
    #   @return [Hash]
    # @!attribute [rw] updated_on
    #   @return [String]
    # @!attribute [rw] merge_commit
    #   @return [Hash]
    # @!attribute [rw] closed_by
    #   @return [Hash]
    # @!attribute [rw] reviewers
    #   @return [Array]
    # @!attribute [rw] participants
    #   @return [Array]
    # @!attribute [rw] uuid
    #   @return [NillClass]
    # @!attribute [rw] type
    #   @return [String]
    class PullRequest < Base
      include Tinybucket::Model::Concerns::RepositoryKeys
      include Tinybucket::Constants

      acceptable_attributes \
        :state, :description, :links, :title, :task_count, :comment_count,
        :close_source_branch, :destination, :reason, :id, :source,
        :created_on, :author, :updated_on, :merge_commit, :closed_by,
        :reviewers, :participants, :uuid, :type

      # Update this pull request.
      #
      # @todo to be implemented.
      # @raise [NotImplementedError] to be implemented.
      def update(_params)
        raise NotImplementedError
      end

      # Decline or reject this pull request.
      #
      # @param options [Hash]
      # @return [true,false]
      def decline(options = {})
        pull_request_api.decline(id, options)
      end

      # Give approval on this pull request.
      #
      # @param options [Hash]
      # @return [true, false]
      def approve(options = {})
        pull_request_api.approve(id, options)
      end

      # Revoke approval on this pull request.
      #
      # @param options [Hash]
      # @return [true, false]
      def unapprove(options = {})
        pull_request_api.unapprove(id, options)
      end

      # Get commits associated with this pull request.
      #
      # @param options [Hash]
      # @return [Tinybucket::Resource::PullRequest::Commits]
      def commits(options = {})
        commits_resource(options)
      end

      # Get comments on this pull request.
      #
      # @param options [Hash]
      # @return [Tinybucket::Resource::PullRequest::Comments]
      def comments(options = {})
        comments_resource(options)
      end

      # Get the specific comment on this pull request.
      #
      # @param comment_id [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::Comment]
      def comment(comment_id, options = {})
        comments_resource.find(comment_id, options)
      end

      # Get the diff for this pull request.
      #
      # @param options [Hash]
      # @return [String] diff as raw text.
      def diff(options = {})
        pull_request_api.diff(id, options)
      end

      # Accept and merge this pull request.
      #
      # @param options [Hash]
      # @return [true, false]
      def merge(options = {})
        pull_request_api.merge(id, options)
      end

      # Get activities on this pull requests.
      #
      def activities(_options = {})
        raise NotImplementedError
      end

      def approvals
        load_model.participants.find { |p| p['approved'] }
      end

      private

      def commits_resource(options = {})
        Tinybucket::Resource::PullRequest::Commits.new(self, options)
      end

      def comments_resource(options = {})
        Tinybucket::Resource::PullRequest::Comments.new(self, options)
      end

      def pull_request_api
        raise ArgumentError, MISSING_REPOSITORY_KEY unless repo_keys?

        create_api('PullRequests', repo_keys)
      end

      def load_model
        pull_request_api.find(id)
      end
    end
  end
end
