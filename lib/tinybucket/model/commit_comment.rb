module Tinybucket
  module Model
    class CommitComment < Base
      include Tinybucket::Model::Concerns::RepositoryKeys

      attr_accessor \
        :links, :id, :parent,  :filename, :content, :user, :inline, \
        :created_on, :updated_on
    end
  end
end
