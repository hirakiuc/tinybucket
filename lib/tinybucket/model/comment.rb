module Tinybucket
  module Model
    # Comment
    #
    # @see https://confluence.atlassian.com/bitbucket/pullrequests-resource-423626332.html#pullrequestsResource-GETalistofapullrequestcomments
    #   Comment resource - Bitbucket Cloud REST API document
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
      include Tinybucket::Model::Concerns::Reloadable

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
