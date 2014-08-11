module Tinybucket
  module Api
    module Helper
      module PullRequestsHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        BASE_PATH = '/repositories'

        private

        def path_to_list
          build_path(BASE_PATH,
                     [repo_owner, 'repo_owner'],
                     [repo_slug,  'repo_slug'],
                     'pullrequests')
        end

        def path_to_find(pr_id)
          build_path(path_to_list,
                     [pr_id, 'pullrequest_id'])
        end

        def path_to_commits(pr_id)
          build_path(path_to_list,
                     [pr_id, 'pullrequest_id'],
                     'commits')
        end
      end
    end
  end
end
