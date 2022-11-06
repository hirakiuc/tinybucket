# frozen_string_literal: true

module Tinybucket
  module Api
    module Helper
      module TeamHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_list
          base_path
        end

        def path_to_find(name)
          team_path(name)
        end

        def path_to_members(name)
          build_path(team_path(name), 'members')
        end

        def path_to_followers(name)
          build_path(team_path(name), 'followers')
        end

        def path_to_following(name)
          build_path(team_path(name), 'following')
        end

        def path_to_repos(name)
          build_path(team_path(name), 'repositories')
        end

        def base_path
          build_path('/teams')
        end

        def team_path(name)
          build_path(base_path, [name, 'teamname'])
        end
      end
    end
  end
end
