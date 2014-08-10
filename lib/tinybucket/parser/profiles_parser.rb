module Tinybucket
  module Parser
    class ProfilesParser < BaseParser
      def convert(json)
        ::Tinybucket::Models::Page.new(json, Tinybucket::Models::Profile)
      end
    end
  end
end
