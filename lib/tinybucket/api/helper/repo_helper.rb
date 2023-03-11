# frozen_string_literal: true

module Tinybucket
  module Api
    module Helper
      module RepoHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_find
          build_path('/repositories',
                     [repo_owner, 'repo_owner'],
                     [repo_slug, 'repo_slug'])
        end

        def path_to_put
          build_path('/repositories',
                     [repo_owner, 'repo_owner'],
                     [repo_slug, 'repo_slug'])
        end

        def path_to_delete
          build_path('/repositories',
                     [repo_owner, 'repo_owner'],
                     [repo_slug, 'repo_slug'])
        end

        def path_to_watchers
          build_path(base_path, '/watchers')
        end

        def path_to_forks
          build_path(base_path, '/forks')
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
