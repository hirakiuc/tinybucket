# frozen_string_literal: true

module Tinybucket
  module Parser
    class HooksParser < BaseParser
      def convert(json)
        Tinybucket::Model::Page.new(json, Tinybucket::Model::Hook)
      end
    end
  end
end
