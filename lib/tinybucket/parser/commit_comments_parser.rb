module Tinybucket
  module Parser
    class CommitCommentsParser < BaseParser
      def convert(json)
        Tinybucket::Models::Page.new(
          json, Tinybucket::Models::CommitComment)
      end
    end
  end
end
