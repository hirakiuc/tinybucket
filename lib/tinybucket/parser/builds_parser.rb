# frozen_string_literal: true

module Tinybucket
  module Parser
    class BuildsParser < BaseParser
      def convert(json)
        Tinybucket::Model::Page.new(json, Tinybucket::Model::BuildStatus)
      end
    end
  end
end
