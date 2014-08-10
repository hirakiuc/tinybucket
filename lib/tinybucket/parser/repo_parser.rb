module Tinybucket
  module Parser
    class RepoParser < BaseParser
      def convert(json)
        ::Tinybucket::Models::Repository.new(json)
      end
    end
  end
end
