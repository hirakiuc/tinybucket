# frozen_string_literal: true

module Tinybucket
  module Parser
    class CommentsParser < BaseParser
      def convert(json)
        Tinybucket::Model::Page.new(
          json, Tinybucket::Model::Comment
        )
      end
    end
  end
end
