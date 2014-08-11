module Tinybucket
  module Api
    class UserApi < BaseApi
      include Tinybucket::Api::Helper::UserHelper

      attr_accessor :username

      def profile(options = {})
        m = get_path(path_to_find,
                     options,
                     Tinybucket::Parser::ProfileParser)

        # pass @config to profile as api_config
        m.api_config = @config.dup
        m
      end

      def followers(options = {})
        list = get_path(path_to_followers,
                        options,
                        Tinybucket::Parser::ProfilesParser)

        # pass @config to each profile as api_config
        list.map { |m| m.api_config = @config.dup }
        list
      end

      def following(options = {})
        list = get_path(path_to_following,
                        options,
                        Tinybucket::Parser::ProfilesParser)

        # pass @config to each profile as api_config
        list.map { |m| m.api_config = @config.dup }
        list
      end

      def repos(options = {})
        list = get_path(path_to_repos,
                        options,
                        Tinybucket::Parser::ReposParser)

        # pass @config to each profile as api_config
        list.map { |m| m.api_config = @config.dup }
        list
      end
    end
  end
end
