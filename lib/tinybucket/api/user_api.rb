module Bitbucket
  module Api
    class UserApi < BaseApi
      attr_accessor :username

      def profile(options = {})
        path = path_to_find
        m = get_path(path, options, Bitbucket::Parser::ProfileParser)

        # pass @config to profile as api_config
        m.api_config = @config.dup
        m
      end

      def followers(options = {})
        path = path_to_followers
        list = get_path(path, options, Bitbucket::Parser::ProfilesParser)

        # pass @config to each profile as api_config
        list.map { |m| m.api_config = @config.dup }
        list
      end

      def following(options = {})
        path = path_to_following
        list = get_path(path, options, Bitbucket::Parser::ProfilesParser)

        # pass @config to each profile as api_config
        list.map { |m| m.api_config = @config.dup }
        list
      end

      def repos(options = {})
        path = path_to_repos
        list = get_path(path, options, Bitbucket::Parser::ReposParser)

        # pass @config to each profile as api_config
        list.map { |m| m.api_config = @config.dup }
        list
      end

      private

      def path_to_find
        name = (username.nil?) ? '' : CGI.escape(username)

        fail ArgumentError, 'require username' if name.blank?

        "/users/#{name}"
      end

      def path_to_followers
        name = (username.nil?) ? '' : CGI.escape(username)

        fail ArgumentError, 'require username' if name.blank?

        "/users/#{name}/followers"
      end

      def path_to_following
        name = (username.nil?) ? '' : CGI.escape(username)

        fail ArgumentError, 'require username' if name.blank?

        "/users/#{name}/following"
      end

      def path_to_repos
        name = (username.nil?) ? '' : CGI.escape(username)

        fail ArgumentError, 'require username' if name.blank?

        "/repositories/#{name}"
      end
    end
  end
end
