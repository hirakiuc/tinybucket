# frozen_string_literal: true

module Tinybucket
  module Api
    # Comments Api client
    #
    # @!attribute [rw] repo_owner
    #   @return [String] repository owner name.
    # @!attribute [rw] repo_slug
    #   @return [String] repository slug. (about {https://confluence.atlassian.com/bitbucket/repositories-endpoint-423626330.html#repositoriesEndpoint-Overview
    #     repo_slug})
    # @!attribute [rw] commented_to
    #   @return [Tinybucket::Model::Commit, Tinybucket::Model::PullRequest]
    class CommentsApi < BaseApi
      include Tinybucket::Api::Helper::CommentsHelper

      attr_accessor :repo_owner, :repo_slug

      attr_accessor :commented_to

      # Send 'GET a list of comments' request.
      #
      # This method send different request depend on 'commented_to' attribute.
      #
      # @note When 'commented_to' is {Tinybucket::Model::Commit} instance,
      #   this method send {https://confluence.atlassian.com/bitbucket/commits-or-commit-resource-389775478.html#commitsorcommitResource-GETalistofcommitcomments
      #   GET a list of commit comments}.
      # @note When 'commented_to' is {Tinybucket::Model::PullRequest} instance,
      #   this method send {https://confluence.atlassian.com/bitbucket/pullrequests-resource-423626332.html#pullrequestsResource-GETalistofapullrequestcomments
      #   GET a list of pull request comments}.
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def list(options = {})
        list = get_path(path_to_list,
                        options,
                        Tinybucket::Parser::CommentsParser)

        associate_with_target(list)
        list
      end

      # Send 'GET a individual comment' request.
      #
      # This method send different request depend on 'commented_to' attribute.
      #
      # @note When 'commented_to' is {Tinybucket::Model::Commit} instance,
      #   this method send {https://confluence.atlassian.com/bitbucket/commits-or-commit-resource-389775478.html#commitsorcommitResource-GETanindividualcommitcomment
      #   GET an individual commit comment}.
      # @note When 'commented_to' is {Tinybucket::Model::PullRequest} instance,
      #   this method send {https://confluence.atlassian.com/bitbucket/pullrequests-resource-423626332.html#pullrequestsResource-GETanindividualpullrequestcomment
      #   GET an individual pull request comment}.
      #
      # @param comment_id [String] comment identifier
      # @param options [Hash]
      # @return [Tinybucket::Model::Comment]
      def find(comment_id, options = {})
        comment = get_path(path_to_find(comment_id),
                           options,
                           Tinybucket::Parser::CommentParser)

        associate_with_target(comment)
        comment
      end

      private

      def associate_with_target(result)
        case result
        when Tinybucket::Model::Comment
          result.commented_to = commented_to
        when Tinybucket::Model::Page
          result.items.map { |m| m.commented_to = commented_to }
        else
          raise ArgumentError, "Invalid result: #{result.inspect}"
        end

        result
      end
    end
  end
end
