module Tinybucket
  module Model
    class BranchRestriction < Base
      include Tinybucket::Model::Concerns::RepositoryKeys

      acceptable_attributes :groups, :id, :kind, :links, :pattern, :users, :uuid

      def update(_params)
        fail NotImplementedError
      end

      def destroy
        fail NotImplementedError
      end
    end
  end
end
