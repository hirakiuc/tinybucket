module Tinybucket
  module Parser
    class PullRequestsParser < BaseParser
      def convert(json)
        Tinybucket::Model::Page.new(
          json, Tinybucket::Model::PullRequest
        )
      end
    end
  end
end
