module Tinybucket
  module Resource
    module Team
      class Following < Tinybucket::Resource::Team::Base
        private

        def enumerator
          create_team_enumerator(:following)
        end
      end
    end
  end
end
