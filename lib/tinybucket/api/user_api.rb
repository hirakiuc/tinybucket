# frozen_string_literal: true

module Tinybucket
  module Api
    # User Api client
    #
    # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/users/%7Busername%7D
    #   users Endpoint
    #
    # @!attribute [rw] username
    #   @return [String]
    class UserApi < BaseApi
      include Tinybucket::Api::Helper::UserHelper

      attr_accessor :username

      # Send 'GET the user profile' request
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Profile]
      def profile(options = {})
        get_path(
          path_to_find,
          options,
          get_parser(:object, Tinybucket::Model::Profile)
        )
      end

      # Send 'GET the list of followers' request
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def followers(options = {})
        get_path(
          path_to_followers,
          options,
          get_parser(:collection, Tinybucket::Model::Profile)
        )
      end

      # Send 'GET a list of accounts the user is following' request
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def following(options = {})
        get_path(
          path_to_following,
          options,
          get_parser(:collection, Tinybucket::Model::Profile)
        )
      end

      # Send 'GET the user's repositories' request
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def repos(options = {})
        get_path(
          path_to_repos,
          options,
          get_parser(:collection, Tinybucket::Model::Repository)
        )
      end
    end
  end
end
