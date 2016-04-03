module Tinybucket
  module Resource
    module Team
      class Repos < Tinybucket::Resource::Team::Base
        private

        def enumerator
          create_team_enumerator(:repos)
        end
      end
    end
  end
end
