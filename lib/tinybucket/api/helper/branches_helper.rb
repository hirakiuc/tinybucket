# frozen_string_literal: true

module Tinybucket
  module Api
    module Helper
      module BranchesHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_list
          build_path(base_path)
        end

        def path_to_find(branch)
          build_path(base_path,
                     [branch, 'branch'])
        end

        def base_path
          build_path('/repositories',
                     [repo_owner, 'repo_owner'],
                     [repo_slug, 'repo_slug'],
                     'refs', 'branches')
        end
      end
    end
  end
end
