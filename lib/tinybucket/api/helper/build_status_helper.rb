# frozen_string_literal: true

module Tinybucket
  module Api
    module Helper
      module BuildStatusHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_find(revision, key)
          build_path(base_path(revision),
                     [key, 'key'])
        end

        def path_to_post(revision)
          base_path(revision)
        end

        def path_to_put(revision, key)
          build_path(base_path(revision),
                     [key, 'key'])
        end

        def base_path(revision)
          build_path('/repositories',
                     [repo_owner, 'repo_owner'],
                     [repo_slug,  'repo_slug'],
                     'commit',
                     [revision, 'revision'],
                     'statuses',
                     'build')
        end
      end
    end
  end
end
