# frozen_string_literal: true

module Tinybucket
  module Api
    # Team Api client
    #
    # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/teams
    #   teams Endpoint
    class TeamApi < BaseApi
      include Tinybucket::Api::Helper::TeamHelper

      # Send 'GET teams' request
      #
      # @param role_name [String] role name
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def list(role_name, options = {})
        get_path(
          path_to_list,
          { role: role_name }.merge(options),
          get_parser(:collection, Tinybucket::Model::Team)
        )
      end

      # Send 'GET the team profile' request
      #
      # @param name [String] The team's name
      # @param options [Hash]
      # @return [Tinybucket::Model::Team]
      def find(name, options = {})
        get_path(
          path_to_find(name),
          options,
          get_parser(:object, Tinybucket::Model::Team)
        )
      end

      # Send 'GET the team members' request
      #
      # @param name [String] The team's name
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def members(name, options = {})
        get_path(
          path_to_members(name),
          options,
          get_parser(:collection, Tinybucket::Model::Team)
        )
      end

      # Send 'GET the list of followers' request
      #
      # @param name [String] The team's name
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def followers(name, options = {})
        get_path(
          path_to_followers(name),
          options,
          get_parser(:collection, Tinybucket::Model::Team)
        )
      end

      # Send 'GET a lisf of accounts the team is following' request
      #
      # @param name [String] The team's name
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def following(name, options = {})
        get_path(
          path_to_following(name),
          options,
          get_parser(:collection, Tinybucket::Model::Team)
        )
      end

      # Send 'GET the team's repositories' request
      #
      # @param name [String] The team's name
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def repos(name, options = {})
        get_path(
          path_to_repos(name),
          options,
          get_parser(:collection, Tinybucket::Model::Repository)
        )
      end
    end
  end
end
