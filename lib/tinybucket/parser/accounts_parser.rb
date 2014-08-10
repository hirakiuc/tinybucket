module Tinybucket
  module Parser
    class AccountsParser < BaseParser
      def convert(json)
        Tinybucket::Models::Page.new(json, Tinybucket::Models::Account)
      end
    end
  end
end
