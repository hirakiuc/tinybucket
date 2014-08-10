module Bitbucket
  module Parser
    class ReposParser < BaseParser
      def convert(json)
        Bitbucket::Models::Page.new(
          json, Bitbucket::Models::Repository)
      end
    end
  end
end
