module Tinybucket
  module Parser
    class CommitCommentParser < BaseParser
      def convert(json)
        Tinybucket::Model::CommitComment.new(json)
      end
    end
  end
end
