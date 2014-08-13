module Tinybucket
  module Api
    class RepoApi < BaseApi
      include Tinybucket::Api::Helper::RepoHelper

      attr_accessor :repo_owner, :repo_slug

      def find(options = {})
        repo = get_path(path_to_find,
                        options,
                        Tinybucket::Parser::RepoParser)

        pass_api_config(repo)
      end

      def watchers(options = {})
        list = get_path(path_to_watchers,
                        options,
                        Tinybucket::Parser::AccountsParser)

        pass_api_config(list)
      end

      def forks(options = {})
        list = get_path(path_to_forks,
                        options,
                        Tinybucket::Parser::ReposParser)

        pass_api_config(list)
      end
    end
  end
end
