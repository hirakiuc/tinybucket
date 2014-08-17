module Tinybucket
  module Parser
    class AccountsParser < BaseParser
      def convert(json)
        Tinybucket::Model::Page.new(json, Tinybucket::Model::Account)
      end
    end
  end
end
