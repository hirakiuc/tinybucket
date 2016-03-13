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
        get_path(
          path_to_watchers,
          options,
          Tinybucket::Parser::ProfilesParser
        )
      end

      def forks(options = {})
        get_path(
          path_to_forks,
          options,
          Tinybucket::Parser::ReposParser
        )
      end
    end
  end
end
