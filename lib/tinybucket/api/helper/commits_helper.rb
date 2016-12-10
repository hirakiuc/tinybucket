# frozen_string_literal: true

module Tinybucket
  module Api
    module Helper
      module CommitsHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_list
          build_path(base_path, 'commits')
        end

        def path_to_find(revision)
          build_path(base_path,
                     'commit',
                     [revision, 'revision'])
        end

        def path_to_branch(branch)
          build_path(base_path,
                    'commits',
                    [branch, 'branch'])
        end

        def path_to_approve(revision)
          build_path(base_path,
                     'commit',
                     [revision, 'revision'],
                     'approve')
        end

        def base_path
          build_path('/repositories',
                     [repo_owner, 'repo_owner'],
                     [repo_slug, 'repo_slug'])
        end
      end
    end
  end
end
