# frozen_string_literal: true

module Tinybucket
  module Model
    class Project < Base
      # Project
      #
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/teams/%7Busername%7D/projects
      #   projects Endpoint
      #
      # @!attribute [rw] type
      #   @return [String]
      # @!attribute [rw] description
      #   @return [String, NilClass]
      # @!attribute [rw] links
      #   @return [Hash]
      # @!attribute [rw] uuid
      #   @return [String]
      # @!attribute [rw] created_on
      #   @return [String]
      # @!attribute [rw] key
      #   @return [String]
      # @!attribute [rw] updated_on
      #   @return [String]
      # @!attribute [rw] is_private
      #   @return [TrueClass, FalseClass]
      # @!attribute [rw] name
      #   @return [String]
      # @!attribute [rw] owner
      #   @return [Hash]
      acceptable_attributes \
        :type, :description, :links, :uuid, :created_on,
        :key, :updated_on, :is_private, :name, :owner

      # Update the remote reference and the instance of this project
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Project]
      def update(options)
        self.attributes = projects_api.put(key, options).attributes
        self
      end

      # Destroy this project
      #
      # @return [NilClass]
      def destroy
        projects_api.delete(key)
      end

      # Get repositories
      #
      # @return [Tinybucket::Resource::Repos]
      def repos
        repos_resource
      end

      private

      def projects_api
        create_api('Projects').tap do |api|
          api.owner = owner["username"]
        end
      end

      def owner_name
        raise 'This project is not loaded yet.' if (owner.nil? || owner['username'].nil?)
        owner['username']
      end

      def repos_resource
        Tinybucket::Resource::Repos.new(owner_name, q: %(project.key="#{key}"))
      end
    end
  end
end
