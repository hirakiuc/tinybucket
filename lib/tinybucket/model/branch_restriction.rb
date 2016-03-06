module Tinybucket
  module Model
    class BranchRestriction < Base
      include Tinybucket::Model::Concerns::RepositoryKeys

      acceptable_attributes :groups, :id, :kind, :links, :pattern, :users, :uuid

      def update(_params)
        raise NotImplementedError
      end

      def destroy
        raise NotImplementedError
      end
    end
  end
end
