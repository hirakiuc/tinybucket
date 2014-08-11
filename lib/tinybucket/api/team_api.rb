module Tinybucket
  module Api
    class TeamApi < BaseApi
      include Tinybucket::Api::Helper::TeamHelper

      attr_accessor :teamname

      def profile(options = {})
        m = get_path(path_to_profile,
                     options,
                     Tinybucket::Parser::TeamParser)

        # pass @config to profile as api-config
        m.api_config = @config.dup
        m
      end

      def members(options = {})
        list = get_path(path_to_members,
                        options,
                        Tinybucket::Parser::TeamsParser)

        # pass @config to profile as api_config
        list.map { |m| m.api_config = @config.dup }
        list
      end

      def followers(options = {})
        list = get_path(path_to_followers,
                        options,
                        Tinybucket::Parser::TeamsParser)

        # pass @config to each profiles as api_config
        list.map { |m| m.api_config = @config.dup }
        list
      end

      def following(options = {})
        list = get_path(path_to_following,
                        options,
                        Tinybucket::Parser::TeamsParser)

        # pass @config to each profiles as api_config
        list.map { |m| m.api_config = @config.dup }
        list
      end

      def repos(options = {})
        list = get_path(path_to_repos,
                        options,
                        Tinybucket::Parser::ReposParser)

        # pass @config to each profiles as api_config
        list.map { |m| m.api_config = @config.dup }
        list
      end
    end
  end
end
