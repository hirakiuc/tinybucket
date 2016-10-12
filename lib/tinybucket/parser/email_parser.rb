module Tinybucket
  module Parser
    class EmailParser < BaseParser
      def convert(json)
        ::Tinybucket::Model::Email.new(json)
      end
    end
  end
end
