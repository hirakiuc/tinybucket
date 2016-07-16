module Tinybucket
  module Parser
    class ReposParser < BaseParser
      def convert(json)
        Tinybucket::Model::Page.new(
          json, Tinybucket::Model::Repository
        )
      end
    end
  end
end
