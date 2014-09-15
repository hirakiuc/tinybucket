module Tinybucket
  module Parser
    class CommentParser < BaseParser
      def convert(json)
        Tinybucket::Model::Comment.new(json)
      end
    end
  end
end
