module Tinybucket
  module Api
    module Helper
      module BranchRestrictionsHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_list
          base_path
        end

        def path_to_find(restriction_id)
          build_path(base_path,
                     [restriction_id, 'restriction_id'])
        end

        def base_path
          build_path('/repositories',
                     [repo_owner, 'repo_owner'],
                     [repo_slug, 'repo_slug'],
                     'branch-restrictions')
        end
      end
    end
  end
end
