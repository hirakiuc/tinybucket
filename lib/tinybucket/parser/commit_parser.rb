module Tinybucket
  module Parser
    class CommitParser < BaseParser
      def convert(json)
        Tinybucket::Models::Commit.new(json)
      end
    end
  end
end
