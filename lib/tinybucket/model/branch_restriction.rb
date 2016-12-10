module Tinybucket
  module Model
    # BranchRestriction
    #
    # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/branch-restrictions
    #   branch-restrictions Resource - Bitbucket Cloud REST API document
    #
    # @!attribute [rw] groups
    #   @return [Array]
    # @!attribute [rw] id
    #   @return [Fixnum]
    # @!attribute [rw] kind
    #   @return [String]
    # @!attribute [rw] links
    #   @return [Hash]
    # @!attribute [rw] pattern
    #   @return [String]
    # @!attribute [rw] users
    #   @return [Array]
    # @!attribute [rw] uuid
    #   @return [NillClass]
    class BranchRestriction < Base
      include Tinybucket::Model::Concerns::RepositoryKeys

      acceptable_attributes :groups, :id, :kind, :links, :pattern, :users, :uuid

      # Update this branch restriction
      #
      # @todo to be implemented
      # @raise [NotImplementedError] to be implemented.
      def update(_params)
        raise NotImplementedError
      end

      # Delete this branch restriction
      #
      # @todo to be implemented
      # @raise [NotImplementedError] to be implemented.
      def destroy
        raise NotImplementedError
      end
    end
  end
end
