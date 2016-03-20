module Tinybucket
  module Model
    # Profile
    #
    # @see https://confluence.atlassian.com/bitbucket/users-endpoint-423626336.html#usersEndpoint-GETtheuserprofile
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
      include Tinybucket::Model::Concerns::Reloadable

      acceptable_attributes \
        :username, :kind, :website, :display_name,
        :links, :created_on, :location, :type, :uuid

      # Get this user's followers
      #
      # @param options [Hash]
      # @return [Tinybucket::Enumerator] enumerator to enumerate followers
      #   as {Tinybucket::Model::Profile} instance.
      def followers(options = {})
        enumerator(
          user_api,
          :followers,
          options
        ) { |m| block_given? ? yield(m) : m }
      end

      # Get users which this user is following
      #
      # @param options [Hash]
      # @return [Tinybucket::Enumerator] an enumerator to enumerate followings
      #   as {Tinybucket::Model::Profile} instance.
      def following(options = {})
        enumerator(
          user_api,
          :following,
          options
        ) { |m| block_given? ? yield(m) : m }
      end

      # Get this user's repositories
      #
      # @param options [Hash]
      # @return [Tinybucket::Enumerator] an enumerator to enumerate repositories
      #   as {Tinybucket::Model::Repository} instance.
      def repos(options = {})
        enumerator(
          user_api,
          :repos,
          options
        ) { |m| block_given? ? yield(m) : m }
      end

      private

      def user_api
        return @user if @user

        @user = create_instance('User')
        @user.username = username
        @user
      end

      def load_model
        user_api.profile
      end
    end
  end
end
