module Tinybucket
  module Api
    module Helper
      module EmailsHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_list
          base_path
        end

        def path_to_find(email)
          build_path(base_path, [email, 'email'])
        end

        def base_path
          build_path('/user/emails')
        end
      end
    end
  end
end
