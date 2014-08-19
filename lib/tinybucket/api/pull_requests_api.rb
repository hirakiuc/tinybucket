module Tinybucket
  module Api
    class PullRequestsApi < BaseApi
      include Tinybucket::Api::Helper::PullRequestsHelper

      attr_accessor :repo_owner, :repo_slug

      def list(options = {})
        list = get_path(path_to_list,
                        options,
                        Tinybucket::Parser::PullRequestsParser)

        list.next_proc = next_proc(:list, options)
        inject_api_config(list)
      end

      def find(pr_id, options = {})
        m = get_path(path_to_find(pr_id),
                     options,
                     Tinybucket::Parser::PullRequestParser)

        inject_api_config(m)
      end

      def commits(pr_id, options = {})
        list = get_path(path_to_commits(pr_id),
                        options,
                        Tinybucket::Parser::CommitsParser)

        list.next_proc = next_proc(:commits, options)
        inject_api_config(list)
      end
    end
  end
end
