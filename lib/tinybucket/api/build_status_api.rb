# frozen_string_literal: true

module Tinybucket
  module Api
    # BuildStatus Api client
    #
    # @see https://confluence.atlassian.com/bitbucket/statuses-build-resource-779295267.html
    #   statuses/build Resource - Bitbucket Cloud REST API
    class BuildStatusApi < BaseApi
      include Tinybucket::Api::Helper::BuildStatusHelper

      attr_accessor :revision, :repo_owner, :repo_slug

      # Send 'GET a builds list for a commit' request
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def list(options = {})
        get_path(
          path_to_list,
          options,
          get_parser(:collection, Tinybucket::Model::BuildStatus)
        )
      end

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
          get_parser(:object, Tinybucket::Model::BuildStatus)
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
          get_parser(:object, Tinybucket::Model::BuildStatus)
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
          get_parser(:object, Tinybucket::Model::BuildStatus)
        )
      end
    end
  end
end
