module Tinybucket
  module Resource
    module Team
      class Followers < Tinybucket::Resource::Team::Base
        private

        def enumerator
          create_team_enumerator(:followers)
        end
      end
    end
  end
end
