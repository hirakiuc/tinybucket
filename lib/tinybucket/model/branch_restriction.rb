module Tinybucket
  module Model
    class BranchRestriction < Base
      attr_accessor :groups, :id, :kind, :links, :pattern, :users

      attr_accessor :repository
    end
  end
end
