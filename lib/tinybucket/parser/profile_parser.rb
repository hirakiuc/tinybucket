module Tinybucket
  module Parser
    class ProfileParser < BaseParser
      def convert(json)
        ::Tinybucket::Models::Profile.new(json)
      end
    end
  end
end
