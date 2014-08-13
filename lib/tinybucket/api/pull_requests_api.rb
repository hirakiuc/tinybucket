module Tinybucket
  module Api
    class PullRequestsApi < BaseApi
      include Tinybucket::Api::Helper::PullRequestsHelper

      attr_accessor :repo_owner, :repo_slug

      def list(options = {})
        list = get_path(path_to_list,
                        options,
                        Tinybucket::Parser::PullRequestsParser)

        pass_api_config(list)
      end

      def find(pr_id, options = {})
        m = get_path(path_to_find(pr_id),
                     options,
                     Tinybucket::Parser::PullRequestParser)

        pass_api_config(m)
      end

      def commits(pr_id, options = {})
        list = get_path(path_to_commits(pr_id),
                        options,
                        Tinybucket::Parser::CommitsParser)

        pass_api_config(list)
      end
    end
  end
end
