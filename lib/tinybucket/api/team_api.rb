module Tinybucket
  module Api
    class TeamApi < BaseApi
      attr_accessor :teamname

      def profile(options = {})
        path = path_to_profile
        m = get_path(path, options, Tinybucket::Parser::TeamParser)

        # pass @config to profile as api-config
        m.api_config = @config.dup
        m
      end

      def members(options = {})
        path = path_to_members
        list = get_path(path, options, Tinybucket::Parser::TeamsParser)

        # pass @config to profile as api_config
        list.map { |m| m.api_config = @config.dup }
        list
      end

      def followers(options = {})
        path = path_to_followers
        list = get_path(path, options, Tinybucket::Parser::TeamsParser)

        # pass @config to each profiles as api_config
        list.map { |m| m.api_config = @config.dup }
        list
      end

      def following(options = {})
        path = path_to_following
        list = get_path(path, options, Tinybucket::Parser::TeamsParser)

        # pass @config to each profiles as api_config
        list.map { |m| m.api_config = @config.dup }
        list
      end

      def repos(options = {})
        path = path_to_repos
        list = get_path(path, options, Tinybucket::Parser::ReposParser)

        # pass @config to each profiles as api_config
        list.map { |m| m.api_config = @config.dup }
        list
      end

      private

      def path_to_profile
        name = (teamname.nil?) ? '' : CGI.escape(teamname)

        fail ArgumentError, 'require teamname' if name.blank?

        "/teams/#{name}"
      end

      def path_to_members
        name = (teamname.nil?) ? '' : CGI.escape(teamname)

        fail ArgumentError, 'require teamname' if name.blank?

        "/teams/#{name}/members"
      end

      def path_to_followers
        name = (teamname.nil?) ? '' : CGI.escape(teamname)

        fail ArgumentError, 'require teamname' if name.blank?

        "/teams/#{name}/followers"
      end

      def path_to_following
        name = (teamname.nil?) ? '' : CGI.escape(teamname)

        fail ArgumentError, 'require teamname' if name.blank?

        "/teams/#{name}/following"
      end

      def path_to_repos
        name = (teamname.nil?) ? '' : CGI.escape(teamname)

        fail ArgumentError, 'require teamname' if name.blank?

        "/teams/#{name}/repositories"
      end
    end
  end
end
