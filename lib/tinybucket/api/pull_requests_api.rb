module Tinybucket
  module Api
    class PullRequestsApi < BaseApi
      include Tinybucket::Api::Helper::PullRequestsHelper

      attr_accessor :repo_owner, :repo_slug

      def list(options = {})
        list = get_path(path_to_list,
                        options,
                        Tinybucket::Parser::PullRequestsParser)

        # pass @config to each model as api_config
        list.each { |m| m.api_config = @config.dup }
        list
      end

      def find(pr_id, options = {})
        m = get_path(path_to_find(pr_id),
                     options,
                     Tinybucket::Parser::PullRequestParser)

        # pass @config to each model as api_config
        m.api_config = @config.dup if m
        m
      end

      def commits(pr_id, options = {})
        list = get_path(path_to_commits(pr_id),
                        options,
                        Tinybucket::Parser::CommitsParser)

        # pass @config to each model as api_config
        list.each { |m| m.api_config = @config.dup }
        list
      end
    end
  end
end
