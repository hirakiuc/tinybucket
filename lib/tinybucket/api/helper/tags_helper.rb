module Tinybucket
  module Api
    module Helper
      module TagsHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_list
          build_path(base_path)
        end

        def path_to_find(tag)
          build_path(base_path,
                     [tag, 'tag'])
        end

        def base_path
          build_path('/repositories',
                     [repo_owner, 'repo_owner'],
                     [repo_slug, 'repo_slug'],
                     'refs', 'tags')
        end
      end
    end
  end
end
