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
    end
  end
end
