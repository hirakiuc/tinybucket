# frozen_string_literal: true

module Tinybucket
  module Api
    module Helper
      module PullRequestsHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_list
          base_path
        end

        def path_to_find(pr_id)
          build_path(base_path,
                     [pr_id, 'pullrequest_id'])
        end

        def path_to_commits(pr_id)
          build_path(base_path,
                     [pr_id, 'pullrequest_id'],
                     'commits')
        end

        def path_to_activities(pr_id)
          build_path(base_path,
                     [pr_id, 'pullrequest_id'],
                     'activity')
        end

        def path_to_approve(pr_id)
          build_path(base_path,
                     [pr_id, 'pullrequest_id'],
                     'approve')
        end

        def path_to_diff(pr_id)
          build_path(path_to_find(pr_id),
                     'diff')
        end

        def path_to_decline(pr_id)
          build_path(base_path,
                     [pr_id, 'pullrequest_id'],
                     'decline')
        end

        def path_to_merge(pr_id)
          build_path(base_path,
                     [pr_id, 'pullrequest_id'],
                     'merge')
        end

        def base_path
          build_path('/repositories',
                     [repo_owner, 'repo_owner'],
                     [repo_slug,  'repo_slug'],
                     'pullrequests')
        end
      end
    end
  end
end
