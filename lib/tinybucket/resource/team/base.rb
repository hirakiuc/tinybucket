module Tinybucket
  module Resource
    module Team
      class Base < Tinybucket::Resource::Base
        def initialize(team_name, options)
          @team_name = team_name
          @args = [options]
        end

        protected

        def team_api
          create_api('Team')
        end

        def create_team_enumerator(method)
          create_enumerator(team_api, method, @team_name, *@args)
        end
      end
    end
  end
end
