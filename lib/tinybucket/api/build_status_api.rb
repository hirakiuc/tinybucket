module Tinybucket
  module Api
    # BuildStatus Api client
    #
    # @see https://confluence.atlassian.com/bitbucket/statuses-build-resource-779295267.html
    #   statuses/build Resource - Bitbucket Cloud REST API
    class BuildStatusApi < BaseApi
      include Tinybucket::Api::Helper::BuildStatusHelper

      attr_accessor :repo_owner, :repo_slug

      # Send 'GET the build status for a commit' request
      #
      # @param revision [String]
      # @param key [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::BuildStatus]
      def find(revision, key, options = {})
        get_path(
          path_to_find(revision, key),
          options,
          Tinybucket::Parser::BuildStatusParser
        )
      end

      # Send 'POST a build status for a commit' request
      #
      # @param revision [String]
      # @param key [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::BuildStatus]
      def post(revision, key, options)
        post_path(
          path_to_post(revision),
          options.merge(key: key),
          Tinybucket::Parser::BuildStatusParser
        )
      end

      # Send 'PUT a build status for a commit' request
      #
      # @param revision [String]
      # @param key [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::BuildStatus]
      def put(revision, key, options)
        put_path(
          path_to_put(revision, key),
          options,
          Tinybucket::Parser::BuildStatusParser
        )
      end
    end
  end
end
