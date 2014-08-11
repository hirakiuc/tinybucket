module Tinybucket
  module Api
    module Helper
      module UserHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        BASE_PATH = '/users'

        private

        def path_to_find
          build_path(BASE_PATH, [username, 'username'])
        end

        def path_to_followers
          build_path(path_to_find, 'followers')
        end

        def path_to_following
          build_path(path_to_find, 'following')
        end

        def path_to_repos
          build_path('/repositories', [username, 'username'])
        end
      end
    end
  end
end
