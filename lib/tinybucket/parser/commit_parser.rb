module Tinybucket
  module Parser
    class CommitParser < BaseParser
      def convert(json)
        Tinybucket::Model::Commit.new(json)
      end
    end
  end
end
