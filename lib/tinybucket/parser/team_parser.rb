module Tinybucket
  module Parser
    class TeamParser < BaseParser
      def convert(json)
        Tinybucket::Model::Team.new(json)
      end
    end
  end
end
