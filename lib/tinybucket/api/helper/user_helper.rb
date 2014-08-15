module Tinybucket
  module Api
    module Helper
      module UserHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_find
          base_path
        end

        def path_to_followers
          build_path(base_path, 'followers')
        end

        def path_to_following
          build_path(base_path, 'following')
        end

        def path_to_repos
          build_path('/repositories', [username, 'username'])
        end

        def base_path
          build_path('/users', [username, 'username'])
        end
      end
    end
  end
end
