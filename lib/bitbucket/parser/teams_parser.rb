module Bitbucket
  module Parser
    class TeamsParser < BaseParser
      def convert(json)
        ::Bitbucket::Models::Page.new(json, Bitbucket::Models::Team)
      end
    end
  end
end
