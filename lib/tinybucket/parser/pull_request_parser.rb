module Tinybucket
  module Parser
    class PullRequestParser < BaseParser
      def convert(json)
        Tinybucket::Model::PullRequest.new(json)
      end
    end
  end
end
