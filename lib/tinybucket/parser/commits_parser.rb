module Bitbucket
  module Parser
    class CommitsParser < BaseParser
      def convert(json)
        Bitbucket::Models::Page.new(json, Bitbucket::Models::Commit)
      end
    end
  end
end
