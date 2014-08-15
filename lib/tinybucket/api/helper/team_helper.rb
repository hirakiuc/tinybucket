module Tinybucket
  module Api
    module Helper
      module TeamHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_profile
          base_path
        end

        def path_to_members
          build_path(base_path, 'members')
        end

        def path_to_followers
          build_path(base_path, 'followers')
        end

        def path_to_following
          build_path(base_path, 'following')
        end

        def path_to_repos
          build_path(base_path, 'repositories')
        end

        def base_path
          build_path('/teams', [teamname, 'teamname'])
        end
      end
    end
  end
end
