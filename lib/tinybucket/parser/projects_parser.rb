# frozen_string_literal: true

module Tinybucket
  module Parser
    class ProjectsParser < BaseParser
      def convert(json)
        Tinybucket::Model::Page.new(json, Tinybucket::Model::Project)
      end
    end
  end
end
