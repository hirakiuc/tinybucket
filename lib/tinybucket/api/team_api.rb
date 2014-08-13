module Tinybucket
  module Api
    class TeamApi < BaseApi
      include Tinybucket::Api::Helper::TeamHelper

      attr_accessor :teamname

      def profile(options = {})
        m = get_path(path_to_profile,
                     options,
                     Tinybucket::Parser::TeamParser)

        pass_api_config(m)
      end

      def members(options = {})
        list = get_path(path_to_members,
                        options,
                        Tinybucket::Parser::TeamsParser)

        pass_api_config(list)
      end

      def followers(options = {})
        list = get_path(path_to_followers,
                        options,
                        Tinybucket::Parser::TeamsParser)

        pass_api_config(list)
      end

      def following(options = {})
        list = get_path(path_to_following,
                        options,
                        Tinybucket::Parser::TeamsParser)

        pass_api_config(list)
      end

      def repos(options = {})
        list = get_path(path_to_repos,
                        options,
                        Tinybucket::Parser::ReposParser)

        pass_api_config(list)
      end
    end
  end
end
