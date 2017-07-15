# frozen_string_literal: true

module Tinybucket
  module Resource
    class Projects < Base
      attr_accessor :owner

      # Initialize
      #
      # @param owner_name [String]
      # @param options [Hash]
      def initialize(owner_name, options = {})
        @owner = owner_name
        @args = [options]
      end

      # Find the project
      #
      # @param project_key [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::Project]
      def find(project_key, options = {})
        projects_api.find(project_key, options)
      end

      # Create a new project
      #
      # NOTE: Not Implemented yet.
      #
      # @param _params [Hash]
      # @raise [NotImplementedError] to be implemented
      def create(_params)
        raise NotImplementedError
      end

      private

      def projects_api
        create_api('Projects').tap do |api|
          api.owner = @owner
        end
      end

      def enumerator
        create_enumerator(projects_api, :list, *@args)
      end
    end
  end
end
