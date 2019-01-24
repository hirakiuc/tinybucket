# frozen_string_literal: true
module Tinybucket
  module Api
    module Helper
      module ReposHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_list(options = {})
          owner = options.delete(:owner)
          return base_path if owner.blank?
          build_path(base_path, [owner, 'owner'])
        end

        def path_to_find(repo_owner, repo_slug)
          build_path(base_path, [repo_owner, 'owner'], [repo_slug, 'slug'])
        end

        def path_to_post(repo_owner, repo_slug)
          build_path(base_path, [repo_owner, 'owner'], [repo_slug, 'slug'])
        end

        def base_path
          '/repositories'
        end
      end
    end
  end
end
