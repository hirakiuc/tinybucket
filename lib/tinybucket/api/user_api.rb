module Tinybucket
  module Api
    class UserApi < BaseApi
      include Tinybucket::Api::Helper::UserHelper

      attr_accessor :username

      def profile(options = {})
        get_path(
          path_to_find,
          options,
          Tinybucket::Parser::ProfileParser
        )
      end

      def followers(options = {})
        get_path(
          path_to_followers,
          options,
          Tinybucket::Parser::ProfilesParser
        )
      end

      def following(options = {})
        get_path(
          path_to_following,
          options,
          Tinybucket::Parser::ProfilesParser
        )
      end

      def repos(options = {})
        get_path(
          path_to_repos,
          options,
          Tinybucket::Parser::ReposParser
        )
      end
    end
  end
end
