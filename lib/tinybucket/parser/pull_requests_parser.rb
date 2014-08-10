module Bitbucket
  module Parser
    class PullRequestsParser < BaseParser
      def convert(json)
        Bitbucket::Models::Page.new(
          json, Bitbucket::Models::PullRequest)
      end
    end
  end
end
