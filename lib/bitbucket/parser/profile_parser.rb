module Bitbucket
  module Parser
    class ProfileParser < BaseParser
      def convert(json)
        ::Bitbucket::Models::Profile.new(json)
      end
    end
  end
end
