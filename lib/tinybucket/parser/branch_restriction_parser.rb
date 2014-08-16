module Tinybucket
  module Parser
    class BranchRestrictionParser < BaseParser
      def convert(json)
        Tinybucket::Models::BranchRestriction.new(json)
      end
    end
  end
end
