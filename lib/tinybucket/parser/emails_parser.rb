# frozen_string_literal: true

module Tinybucket
  module Parser
    class EmailsParser < BaseParser
      def convert(json)
        Tinybucket::Model::Page.new(json, Tinybucket::Model::Email)
      end
    end
  end
end
