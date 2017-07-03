# frozen_string_literal: true

module Tinybucket
  module Parser
    class HookParser < BaseParser
      def convert(json)
        ::Tinybucket::Model::Hook.new(json)
      end
    end
  end
end
