module Tinybucket
  module Api
    class TeamApi < BaseApi
      include Tinybucket::Api::Helper::TeamHelper

      attr_accessor :teamname

      def profile(options = {})
        m = get_path(path_to_profile,
                     options,
                     Tinybucket::Parser::TeamParser)

        inject_api_config(m)
      end

      def members(options = {})
        list = get_path(path_to_members,
                        options,
                        Tinybucket::Parser::TeamsParser)

        list.next_proc = next_proc(:members, options)
        inject_api_config(list)
      end

      def followers(options = {})
        list = get_path(path_to_followers,
                        options,
                        Tinybucket::Parser::TeamsParser)

        list.next_proc = next_proc(:followers, options)
        inject_api_config(list)
      end

      def following(options = {})
        list = get_path(path_to_following,
                        options,
                        Tinybucket::Parser::TeamsParser)

        list.next_proc = next_proc(:following, options)
        inject_api_config(list)
      end

      def repos(options = {})
        list = get_path(path_to_repos,
                        options,
                        Tinybucket::Parser::ReposParser)

        list.next_proc = next_proc(:repos, options)
        inject_api_config(list)
      end
    end
  end
end
