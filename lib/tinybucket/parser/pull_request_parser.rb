module Tinybucket
  module Parser
    class PullRequestParser < BaseParser
      def convert(json)
        Tinybucket::Models::PullRequest.new(json)
      end
    end
  end
end
