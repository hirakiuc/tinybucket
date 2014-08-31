module Tinybucket
  module Model
    class BranchRestriction < Base
      include Tinybucket::Model::Concerns::RepositoryKeys

      attr_accessor :groups, :id, :kind, :links, :pattern, :users

      def update(_params)
        fail NotImplementedError
      end

      def destroy
        fail NotImplementedError
      end
    end
  end
end
