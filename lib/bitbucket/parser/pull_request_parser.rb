require 'bitbucket/parser/base_parser'
require 'bitbucket/models/pull_request'

module Bitbucket
  module Parser
    class PullRequestParser < BaseParser
      def convert(json)
        Bitbucket::Models::PullRequest.new(json)
      end
    end
  end
end
