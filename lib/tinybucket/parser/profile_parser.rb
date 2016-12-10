# frozen_string_literal: true

module Tinybucket
  module Parser
    class ProfileParser < BaseParser
      def convert(json)
        ::Tinybucket::Model::Profile.new(json)
      end
    end
  end
end
