module Tinybucket
  module Parser
    class ReposParser < BaseParser
      def convert(json)
        Tinybucket::Models::Page.new(
          json, Tinybucket::Models::Repository)
      end
    end
  end
end
