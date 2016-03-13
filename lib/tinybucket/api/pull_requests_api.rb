module Tinybucket
  module Api
    class PullRequestsApi < BaseApi
      include Tinybucket::Api::Helper::PullRequestsHelper

      attr_accessor :repo_owner, :repo_slug

      def list(options = {})
        get_path(
          path_to_list,
          options,
          Tinybucket::Parser::PullRequestsParser
        )
      end

      def find(pr_id, options = {})
        get_path(
          path_to_find(pr_id),
          options,
          Tinybucket::Parser::PullRequestParser
        )
      end

      def commits(pr_id, options = {})
        get_path(
          path_to_commits(pr_id),
          options,
          Tinybucket::Parser::CommitsParser
        )
      end

      def approve(pr_id, options = {})
        result = post_path(path_to_approve(pr_id), options)
        (result['approved'] == true)
      end

      def decline(pr_id, options = {})
        result = post_path(path_to_decline(pr_id), options)
        (result['state'] == 'DECLINED')
      end

      def unapprove(pr_id, options = {})
        result = delete_path(path_to_approve(pr_id), options)
        (result['approved'] == false)
      end

      def merge(pr_id, options = {})
        result = post_path(path_to_merge(pr_id), options)
        (result['state'] == 'MERGED')
      end

      def diff(pr_id, options = {})
        get_path(path_to_diff(pr_id), options)
      end
    end
  end
end
