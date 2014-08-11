module Tinybucket
  module Api
    module Helper
      module ReposHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        BASE_PATH = '/repositories'

        private

        def path_to_list(options)
          owner = options[:owner]
          return BASE_PATH if owner.blank?
          build_path(BASE_PATH, [owner, 'owner'])
        end
      end
    end
  end
end
