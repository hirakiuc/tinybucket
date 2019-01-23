# frozen_string_literal: true

module Tinybucket
  module Api
    module Helper
      module ReposHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_list(owner = nil, _options = {})
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
