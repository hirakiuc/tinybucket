# frozen_string_literal: true

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
      # @return [Tinybucket::Resource::Team::Members]
      def members(options = {})
        Tinybucket::Resource::Team::Members.new(username, options)
      end

      # Get this team's followers.
      #
      # @param options [Hash]
      # @return [Tinybucket::Resource::Team::Followers]
      def followers(options = {})
        Tinybucket::Resource::Team::Followers.new(username, options)
      end

      # Get users which this team is following.
      #
      # @param options [Hash]
      # @return [Tinybucket::Resource::Team::Following]
      def following(options = {})
        Tinybucket::Resource::Team::Following.new(username, options)
      end

      # Get this team's repositories.
      #
      # @param options [Hash]
      # @return [Tinybucket::Resource::Team::Repos]
      def repos(options = {})
        Tinybucket::Resource::Team::Repos.new(username, options)
      end

      private

      def team_api
        create_api('Team')
      end

      def load_model
        team_api.find(username)
      end
    end
  end
end
