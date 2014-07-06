module Bitbucket
  module Models
    class PullRequest < BaseModel
      attr_accessor \
        :state, :description, :links, :title, :close_source_branch,
        :destination, :reason, :id, :source, :created_on, :author, :updated_on,
        :merge_commit, :closed_by, :reviewers, :participants

      attr_accessor :repository
    end
  end
end
