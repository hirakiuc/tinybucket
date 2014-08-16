module Tinybucket
  module Parser
    class BranchRestrictionsParser < BaseParser
      def convert(json)
        Tinybucket::Models::Page.new(
          json, Tinybucket::Models::BranchRestriction)
      end
    end
  end
end
