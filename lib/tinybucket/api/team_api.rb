module Tinybucket
  module Api
    class TeamApi < BaseApi
      include Tinybucket::Api::Helper::TeamHelper

      def find(name, options = {})
        get_path(
          path_to_find(name),
          options,
          Tinybucket::Parser::TeamParser
        )
      end

      def members(name, options = {})
        get_path(
          path_to_members(name),
          options,
          Tinybucket::Parser::TeamsParser
        )
      end

      def followers(name, options = {})
        get_path(
          path_to_followers(name),
          options,
          Tinybucket::Parser::TeamsParser
        )
      end

      def following(name, options = {})
        get_path(
          path_to_following(name),
          options,
          Tinybucket::Parser::TeamsParser
        )
      end

      def repos(name, options = {})
        get_path(
          path_to_repos(name),
          options,
          Tinybucket::Parser::ReposParser
        )
      end
    end
  end
end
