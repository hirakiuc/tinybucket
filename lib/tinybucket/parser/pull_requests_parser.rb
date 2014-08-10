module Tinybucket
  module Parser
    class PullRequestsParser < BaseParser
      def convert(json)
        Tinybucket::Models::Page.new(
          json, Tinybucket::Models::PullRequest)
      end
    end
  end
end
