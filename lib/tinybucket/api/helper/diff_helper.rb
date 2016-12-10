# frozen_string_literal: true

module Tinybucket
  module Api
    module Helper
      module DiffHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_find(spec)
          build_path(base_path,
                     'diff',
                     [spec, 'spec'])
        end

        def path_to_patch(spec)
          build_path(base_path,
                     'patch',
                     [spec, 'spec'])
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
