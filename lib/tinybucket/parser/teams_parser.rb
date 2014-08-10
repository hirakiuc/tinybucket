module Tinybucket
  module Parser
    class TeamsParser < BaseParser
      def convert(json)
        ::Tinybucket::Models::Page.new(json, Tinybucket::Models::Team)
      end
    end
  end
end
