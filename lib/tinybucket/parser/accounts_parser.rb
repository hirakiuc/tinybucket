module Bitbucket
  module Parser
    class AccountsParser < BaseParser
      def convert(json)
        Bitbucket::Models::Page.new(json, Bitbucket::Models::Account)
      end
    end
  end
end
