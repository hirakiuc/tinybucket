module Tinybucket
  module Api
    class RepoApi < BaseApi
      include Tinybucket::Api::Helper::RepoHelper

      attr_accessor :repo_owner, :repo_slug

      def find(options = {})
        repo = get_path(path_to_find,
                        options,
                        Tinybucket::Parser::RepoParser)

        # pass @config to api_config
        repo.api_config = @config.dup if repo
        repo
      end

      def watchers(options = {})
        list = get_path(path_to_watchers,
                        options,
                        Tinybucket::Parser::AccountsParser)

        list.each { |m| m.api_config = @config.dup }
        list
      end

      def forks(options = {})
        list = get_path(path_to_forks,
                        options,
                        Tinybucket::Parser::ReposParser)

        # pass @config to api_config
        list.map { |m| m.api_config = @config.dup }
        list
      end
    end
  end
end
