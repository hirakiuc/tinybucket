require 'bitbucket/parser/base_parser'
require 'bitbucket/models/pull_request'

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
