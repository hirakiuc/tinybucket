# frozen_string_literal: true

module Tinybucket
  module Model
    class Project < Base
      acceptable_attributes \
        :type, :description, :links, :uuid, :created_on,
        :key, :updated_on, :is_private, :name, :owner

      # Update this project
      #
      # @param _params [Hash]
      # @raise [NotImplementedError] to be implemented
      def update(_params)
        raise NotImplementedError
      end

      # Destroy this project
      #
      # @raise [NotImplementedError] to be implemented.
      def destroy
        raise NotImplementedError
      end

      # Get repositories
      #
      # @return [Tinybucket::Resource::Repos]
      def repos
        repos_resource
      end

      private

      def owner_name
        raise 'This project is not loaded yet.' if (owner.nil? || owner['username'].nil?)
        owner['username']
      end

      def repos_resource
        Tinybucket::Resource::Repos.new(owner_name, q: %|project.key="#{key}"|)
      end
    end
  end
end
