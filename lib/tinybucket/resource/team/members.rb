# frozen_string_literal: true

module Tinybucket
  module Resource
    module Team
      class Members < Tinybucket::Resource::Team::Base
        private

        def enumerator
          create_team_enumerator(:members)
        end
      end
    end
  end
end
