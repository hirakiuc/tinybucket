# frozen_string_literal: true

module Tinybucket
  module Model
    # Profile
    #
    # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/users/%7Busername%7D
    #   users Endpoint - Bitbucket Cloud REST API document
    #
    # @!attribute [rw] username
    #   @return [String]
    # @!attribute [rw] kind
    #   @return [NillClass]
    # @!attribute [rw] website
    #   @return [String]
    # @!attribute [rw] display_name
    #   @return [String]
    # @!attribute [rw] links
    #   @return [Hash]
    # @!attribute [rw] created_on
    #   @return [String]
    # @!attribute [rw] location
    #   @return [String]
    # @!attribute [rw] type
    #   @return [String]
    # @!attribute [rw] uuid
    #   @return [String]
    class Profile < Base
      acceptable_attributes \
        :username, :kind, :website, :display_name,
        :links, :created_on, :location, :type, :uuid

      # Get this user's followers
      #
      # @param options [Hash]
      # @return [Tinybucket::Resource::User::Followers]
      def followers(options = {})
        Tinybucket::Resource::User::Followers.new(username, options)
      end

      # Get users which this user is following
      #
      # @param options [Hash]
      # @return [Tinybucket::Resource::User::Following]
      def following(options = {})
        Tinybucket::Resource::User::Following.new(username, options)
      end

      # Get this user's repositories
      #
      # @param options [Hash]
      # @return [Tinybucket::Resource::User::Repos]
      def repos(options = {})
        Tinybucket::Resource::User::Repos.new(username, options)
      end

      private

      def user_api
        create_api('User').tap do |api|
          api.username = username
        end
      end

      def load_model
        user_api.profile
      end
    end
  end
end
