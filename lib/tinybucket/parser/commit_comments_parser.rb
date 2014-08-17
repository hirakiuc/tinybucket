module Tinybucket
  module Parser
    class CommitCommentsParser < BaseParser
      def convert(json)
        Tinybucket::Model::Page.new(
          json, Tinybucket::Model::CommitComment)
      end
    end
  end
end
