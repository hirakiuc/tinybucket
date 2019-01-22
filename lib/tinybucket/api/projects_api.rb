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
          get_parser(:collection, Tinybucket::Model::Project)
        )
      end

      def find(project_key, options = {})
        get_path(
          path_to_find(owner, project_key),
          options,
          get_parser(:object, Tinybucket::Model::Project)
        )
      end

      def post(options = {})
        post_path(
          path_to_post(owner),
          options,
          get_parser(:object, Tinybucket::Model::Project)
        )
      end

      def put(project_key, options = {})
        put_path(
          path_to_put(owner, project_key),
          options,
          get_parser(:object, Tinybucket::Model::Project)
        )
      end

      def delete(project_key, options = {})
        delete_path(
          path_to_delete(owner, project_key),
          options,
          get_parser(:object, Tinybucket::Model::Project)
        )
      end
    end
  end
end
