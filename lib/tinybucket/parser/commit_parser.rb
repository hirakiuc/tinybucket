module Bitbucket
  module Parser
    class CommitParser < BaseParser
      def convert(json)
        Bitbucket::Models::Commit.new(json)
      end
    end
  end
end
