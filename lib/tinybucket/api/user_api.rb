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

      # Get Owner's email addresses
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/user/emails
      #
      # @return [Tinybucket::Resource::Page]
      def emails
        emails_resource
      end

      # Get a single email address model that belongs to the owner
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/user/emails/%7Bemail%7D
      #
      # @param email [String]
      # @return [Tinybucket::Resource::Page]
      def email(email)
        emails_resource.find(email)
      end

      private

      def emails_resource
        Tinybucket::Resource::Emails.new
      end
    end
  end
end
