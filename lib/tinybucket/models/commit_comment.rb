module Tinybucket
  module Models
    class CommitComment < BaseModel
      attr_accessor \
        :links, :id, :parent,  :filename, :content, :user, :inline, \
        :created_on, :updated_on

      attr_accessor :commit
    end
  end
end
