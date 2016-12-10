# frozen_string_literal: true

module Tinybucket
  module Parser
    class ProfilesParser < BaseParser
      def convert(json)
        Tinybucket::Model::Page.new(json, Tinybucket::Model::Profile)
      end
    end
  end
end
