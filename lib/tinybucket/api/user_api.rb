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
          Tinybucket::Parser::ProfileParser
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
          Tinybucket::Parser::ProfilesParser
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
          Tinybucket::Parser::ProfilesParser
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
          Tinybucket::Parser::ReposParser
        )
      end
    end
  end
end
