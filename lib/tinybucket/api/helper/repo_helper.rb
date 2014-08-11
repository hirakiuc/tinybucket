module Tinybucket
  module Api
    module Helper
      module RepoHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        BASE_PATH = '/repositories'

        private

        def path_to_find
          build_path(BASE_PATH,
                     [repo_owner, 'repo_owner'],
                     [repo_slug, 'repo_slug'])
        end

        def path_to_watchers
          path_to_find + '/watchers'
        end

        def path_to_forks
          path_to_find + '/forks'
        end
      end
    end
  end
end
