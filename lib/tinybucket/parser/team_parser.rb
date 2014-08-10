module Tinybucket
  module Parser
    class TeamParser < BaseParser
      def convert(json)
        ::Tinybucket::Models::Team.new(json)
      end
    end
  end
end
