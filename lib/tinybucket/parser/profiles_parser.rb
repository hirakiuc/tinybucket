module Bitbucket
  module Parser
    class ProfilesParser < BaseParser
      def convert(json)
        ::Bitbucket::Models::Page.new(json, Bitbucket::Models::Profile)
      end
    end
  end
end
