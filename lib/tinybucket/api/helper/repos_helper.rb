module Tinybucket
  module Api
    module Helper
      module ReposHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_list(options)
          owner = options[:owner]
          return base_path if owner.blank?
          build_path(base_path, [owner, 'owner'])
        end

        def base_path
          '/repositories'
        end
      end
    end
  end
end
