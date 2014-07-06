module Bitbucket
  module Parser
    class RepoParser < BaseParser
      def convert(json)
        ::Bitbucket::Models::Repository.new(json)
      end
    end
  end
end
