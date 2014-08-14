module Tinybucket
  module Parser
    class CommitCommentParser < BaseParser
      def convert(json)
        Tinybucket::Models::CommitComment.new(json)
      end
    end
  end
end
