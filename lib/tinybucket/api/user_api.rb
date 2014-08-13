module Tinybucket
  module Api
    class UserApi < BaseApi
      include Tinybucket::Api::Helper::UserHelper

      attr_accessor :username

      def profile(options = {})
        m = get_path(path_to_find,
                     options,
                     Tinybucket::Parser::ProfileParser)

        pass_api_config(m)
      end

      def followers(options = {})
        list = get_path(path_to_followers,
                        options,
                        Tinybucket::Parser::ProfilesParser)

        pass_api_config(list)
      end

      def following(options = {})
        list = get_path(path_to_following,
                        options,
                        Tinybucket::Parser::ProfilesParser)

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
