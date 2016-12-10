# frozen_string_literal: true

module Tinybucket
  module Api
    module Helper
      module HooksHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_list
          base_path
        end

        def path_to_find(hook)
          build_path(base_path, [hook, 'hook'])
        end

        def path_to_post
          base_path
        end

        def path_to_put(hook)
          build_path(base_path, [hook, 'hook'])
        end

        def path_to_delete(hook)
          build_path(base_path, [hook, 'hook'])
        end

        def base_path
          build_path('/repositories',
                     [repo_owner, 'repo_owner'],
                     [repo_slug, 'repo_slug'],
                     'hooks')
        end
      end
    end
  end
end
