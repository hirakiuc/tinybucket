module Tinybucket
  module Models
    class Commit < BaseModel
      attr_accessor \
        :hash, :links, :repository, :author,
        :parents, :date, :message,
        :participants
    end
  end
end
