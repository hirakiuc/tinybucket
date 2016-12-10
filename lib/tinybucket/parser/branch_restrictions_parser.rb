# frozen_string_literal: true

module Tinybucket
  module Parser
    class BranchRestrictionsParser < BaseParser
      def convert(json)
        Tinybucket::Model::Page.new(
          json, Tinybucket::Model::BranchRestriction
        )
      end
    end
  end
end
