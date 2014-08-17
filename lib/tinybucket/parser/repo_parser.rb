module Tinybucket
  module Parser
    class RepoParser < BaseParser
      def convert(json)
        ::Tinybucket::Model::Repository.new(json)
      end
    end
  end
end
