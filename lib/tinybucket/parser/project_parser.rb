# frozen_string_literal: true

module Tinybucket
  module Parser
    class ProjectParser < BaseParser
      def convert(json)
        Tinybucket::Model::Project.new(json)
      end
    end
  end
end
