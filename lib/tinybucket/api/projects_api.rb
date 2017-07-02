# frozen_string_literal: true

module Tinybucket
  module Api
    class ProjectsApi < BaseApi
      include Tinybucket::Api::Helper::ProjectsHelper
      attr_accessor :owner

      def list(options = {})
        get_path(
          path_to_list(owner),
          options,
          Tinybucket::Parser::ProjectsParser
        )
      end

      def find(project_key, options = {})
        get_path(
          path_to_find(owner, project_key),
          options,
          Tinybucket::Parser::ProjectParser
        )
      end
    end
  end
end
