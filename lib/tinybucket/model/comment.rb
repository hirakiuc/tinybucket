# frozen_string_literal: true

module Tinybucket
  module Model
    # Comment
    #
    # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/commit/%7Bsha%7D/comments
    #   Comment Resource
    #
    # @!attribute [rw] links
    #   @return [Hash]
    # @!attribute [rw] id
    #   @return [Fixnum]
    # @!attribute [rw] parent
    #   @return [Hash]
    # @!attribute [rw] filename
    #   @return [String]
    # @!attribute [rw] content
    #   @return [Hash]
    # @!attribute [rw] user
    #   @return [Hash]
    # @!attribute [rw] inline
    #   @return [Hash]
    # @!attribute [rw] created_on
    #   @return [String]
    # @!attribute [rw] updated_on
    #   @return [String]
    # @!attribute [rw] uuid
    #   @return [NillClass]
    class Comment < Base
      include Tinybucket::Model::Concerns::RepositoryKeys

      acceptable_attributes \
        :links, :id, :parent, :filename, :content, :user, :inline, \
        :created_on, :updated_on, :uuid

      # @!attribute [rw] commented_to
      #   @return [Tinybucket::Model::PullRequest, Tinybucket::Model::Commit]
      attr_accessor :commented_to

      private

      def commit_api
        create_api('Comments', repo_keys)
      end

      def pull_request_api
        create_api('PullRequests', repo_keys)
      end

      def load_model
        api =
          case commented_to
          when Tinybucket::Model::Commit
            commit_api
          when Tinybucket::Model::PullRequest
            pull_request_api
          else
            raise ArgumentError, 'commented_to was invalid'
          end

        api.commented_to = commented_ato
        api.find(id, {})
      end
    end
  end
end
