module Tinybucket
  module Parser
    class BranchesParser < BaseParser
      def convert(json)
        Tinybucket::Model::Page.new(json, Tinybucket::Model::Branch)
      end
    end
  end
end
