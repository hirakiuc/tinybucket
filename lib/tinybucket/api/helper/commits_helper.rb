module Tinybucket
  module Api
    module Helper
      module CommitsHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        BASE_PATH = '/repositories'

        private

        def path_to_list
          build_path(BASE_PATH,
                     [repo_owner, 'repo_owner'],
                     [repo_slug, 'repo_slug'],
                     'commits')
        end

        def path_to_find(revision)
          build_path(BASE_PATH,
                     [repo_owner, 'repo_owner'],
                     [repo_slug, 'repo_slug'],
                     'commit',
                     [revision, 'revision'])
        end
      end
    end
  end
end
