# frozen_string_literal: true

module Tinybucket
  module Api
    module Helper
      module ProjectsHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_list(owner)
          build_path(base_path(owner), '/')
        end

        def path_to_find(owner, project_key)
          build_path(base_path(owner),
                     [project_key, 'project_key'])
        end

        def base_path(owner)
          build_path('/teams',
                     [owner, 'owner'],
                     'projects')
        end
      end
    end
  end
end
