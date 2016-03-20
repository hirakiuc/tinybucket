module Tinybucket
  module Model
    # Team
    #
    # @see https://confluence.atlassian.com/bitbucket/teams-endpoint-423626335.html#teamsEndpoint-Overview
    #   teams Endpoint - Bitbucket Cloud REST API document
    #
    # @!attribute [rw] username
    #   @return [String]
    # @!attribute [rw] kind
    #   @return [String, NillClass]
    # @!attribute [rw] website
    #   @return [String, NillClass]
    # @!attribute [rw] display_name
    #   @return [String]
    # @!attribute [rw] uuid
    #   @return [String]
    # @!attribute [rw] links
    #   @return [Hash]
    # @!attribute [rw] created_on
    #   @return [String]
    # @!attribute [rw] location
    #   @return [String, NillClass]
    # @!attribute [rw] type
    #   @return [String]
    class Team < Base
      acceptable_attributes \
        :username, :kind, :website, :display_name, :uuid,
        :links, :created_on, :location, :type

      # Get this team's members.
      #
      # @param options [Hash]
      # @return [Tinybucket::Enumerator] an enumerator to enumerate members
      #   as {Tinybucket::Model::Team} instance.
      def members(options = {})
        enumerator(
          team_api,
          :members,
          username,
          options
        ) { |m| block_given? ? yield(m) : m }
      end

      # Get this team's followers.
      #
      # @param options [Hash]
      # @return [Tinybucket::Enumerator] an enumerator to enumerate followers
      #   as {Tinybucket::Model::Team} instance.
      def followers(options = {})
        enumerator(
          team_api,
          :followers,
          username,
          options
        ) { |m| block_given? ? yield(m) : m }
      end

      # Get users which this team is following.
      #
      # @param options [Hash]
      # @return [Tinybucket::Enumerator] an enumerator to enumerate followings
      #   as {Tinybucket::Model::Team} instance.
      def following(options = {})
        enumerator(
          team_api,
          :following,
          username,
          options
        ) { |m| block_given? ? yield(m) : m }
      end

      # Get this team's repositories.
      #
      # @param options [Hash]
      # @return [Tinybucket::Enumerator] an enumerator to enumerate repositories
      #   as {Tinybucket::Model::Repository} instance.
      def repos(options = {})
        enumerator(
          team_api,
          :repos,
          username,
          options
        ) { |m| block_given? ? yield(m) : m }
      end

      private

      def team_api
        return @team if @team
        @team = create_instance('Team')
      end

      def load_model
        team_api.find(username)
      end
    end
  end
end
