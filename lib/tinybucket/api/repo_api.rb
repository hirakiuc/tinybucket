module Tinybucket
  module Api
    class RepoApi < BaseApi
      include Tinybucket::Api::Helper::RepoHelper

      attr_accessor :repo_owner, :repo_slug

      def find(options = {})
        repo = get_path(path_to_find,
                        options,
                        Tinybucket::Parser::RepoParser)

        inject_api_config(repo)
      end

      def watchers(options = {})
        list = get_path(path_to_watchers,
                        options,
                        Tinybucket::Parser::AccountsParser)

        list.next_proc = next_proc(:watchers, options)
        inject_api_config(list)
      end

      def forks(options = {})
        list = get_path(path_to_forks,
                        options,
                        Tinybucket::Parser::ReposParser)

        list.next_proc = next_proc(:forks, options)
        inject_api_config(list)
      end
    end
  end
end
