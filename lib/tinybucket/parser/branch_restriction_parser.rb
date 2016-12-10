# frozen_string_literal: true

module Tinybucket
  module Parser
    class BranchRestrictionParser < BaseParser
      def convert(json)
        Tinybucket::Model::BranchRestriction.new(
          json
        )
      end
    end
  end
end
