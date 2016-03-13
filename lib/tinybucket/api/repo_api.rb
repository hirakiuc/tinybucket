module Tinybucket
  module Api
    class RepoApi < BaseApi
      include Tinybucket::Api::Helper::RepoHelper

      attr_accessor :repo_owner, :repo_slug

      def find(options = {})
        get_path(
          path_to_find,
          options,
          Tinybucket::Parser::RepoParser
        )
      end

      def watchers(options = {})
        list = get_path(path_to_watchers,
                        options,
                        Tinybucket::Parser::ProfilesParser)

        list.next_proc = next_proc(:watchers, options)
        list
      end

      def forks(options = {})
        list = get_path(path_to_forks,
                        options,
                        Tinybucket::Parser::ReposParser)

        list.next_proc = next_proc(:forks, options)
        list
      end
    end
  end
end
