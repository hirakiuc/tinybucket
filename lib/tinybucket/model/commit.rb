module Tinybucket
  module Model
    # Commit Resource
    #
    # @see https://confluence.atlassian.com/bitbucket/commits-or-commit-resource-389775478.html
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
      # @return [Tinybucket::Enumerator] enumerator to enumerate comments
      #   as {Tinybucket::Model::Comment} instance.
      def comments(options = {})
        enumerator(
          comments_api,
          :list,
          options
        ) { |m| block_given? ? yield(m) : m }
      end

      # Get the specific commit comment which associate with this commit.
      #
      # @param comment_id [String] comment id
      # @param options [Hash]
      # @return [Tinybucket::Model::Comment]
      def comment(comment_id, options = {})
        comments_api.find(comment_id, options)
      end

      # Give approval on this commit.
      #
      # @param options [Hash]
      # @return [true, false]
      def approve(options = {})
        commit_api.approve(hash, options)
      end

      # Revoke approval on this commit.
      #
      # @param options [Hash]
      # @return [true, false]
      def unapprove(options = {})
        commit_api.unapprove(hash, options)
      end

      private

      def comments_api
        raise ArgumentError, MISSING_REPOSITORY_KEY unless repo_keys?

        api = create_api('Comments', repo_keys)
        api.commented_to = self
        api
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
