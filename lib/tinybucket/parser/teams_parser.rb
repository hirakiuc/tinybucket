# frozen_string_literal: true

module Tinybucket
  module Parser
    class TeamsParser < BaseParser
      def convert(json)
        Tinybucket::Model::Page.new(json, Tinybucket::Model::Team)
      end
    end
  end
end
