module Bitbucket
  module Parser
    class TeamParser < BaseParser
      def convert(json)
        ::Bitbucket::Models::Team.new(json)
      end
    end
  end
end
