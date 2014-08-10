module Tinybucket
  module Parser
    class CommitsParser < BaseParser
      def convert(json)
        Tinybucket::Models::Page.new(json, Tinybucket::Models::Commit)
      end
    end
  end
end
