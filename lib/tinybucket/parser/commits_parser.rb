# frozen_string_literal: true

module Tinybucket
  module Parser
    class CommitsParser < BaseParser
      def convert(json)
        Tinybucket::Model::Page.new(json, Tinybucket::Model::Commit)
      end
    end
  end
end
