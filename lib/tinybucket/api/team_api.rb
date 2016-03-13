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
        list = get_path(path_to_members(name),
                        options,
                        Tinybucket::Parser::TeamsParser)

        list.next_proc = next_proc(:members, options)
        list
      end

      def followers(name, options = {})
        list = get_path(path_to_followers(name),
                        options,
                        Tinybucket::Parser::TeamsParser)

        list.next_proc = next_proc(:followers, options)
        list
      end

      def following(name, options = {})
        list = get_path(path_to_following(name),
                        options,
                        Tinybucket::Parser::TeamsParser)

        list.next_proc = next_proc(:following, options)
        list
      end

      def repos(name, options = {})
        list = get_path(path_to_repos(name),
                        options,
                        Tinybucket::Parser::ReposParser)

        list.next_proc = next_proc(:repos, options)
        list
      end
    end
  end
end
