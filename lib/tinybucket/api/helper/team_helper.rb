module Tinybucket
  module Api
    module Helper
      module TeamHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        BASE_PATH = '/teams'

        private

        def path_to_profile
          build_path(BASE_PATH, [teamname, 'teamname'])
        end

        def path_to_members
          build_path(path_to_profile, 'members')
        end

        def path_to_followers
          build_path(path_to_profile, 'followers')
        end

        def path_to_following
          build_path(path_to_profile, 'following')
        end

        def path_to_repos
          build_path(path_to_profile, 'repositories')
        end
      end
    end
  end
end
