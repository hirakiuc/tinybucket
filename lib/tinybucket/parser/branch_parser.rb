# frozen_string_literal: true

module Tinybucket
  module Parser
    class BranchParser < BaseParser
      def convert(json)
        Tinybucket::Model::Branch.new(
          json
        )
      end
    end
  end
end
