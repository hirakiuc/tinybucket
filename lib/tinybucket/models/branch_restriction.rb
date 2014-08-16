module Tinybucket
  module Models
    class BranchRestriction < BaseModel
      attr_accessor :groups, :id, :kind, :links, :pattern, :users

      attr_accessor :repository
    end
  end
end
