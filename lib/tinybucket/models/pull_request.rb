module Tinybucket
  module Models
    class PullRequest < BaseModel
      attr_accessor \
        :state, :description, :links, :title, :close_source_branch,
        :destination, :reason, :id, :source, :created_on, :author, :updated_on,
        :merge_commit, :closed_by, :reviewers, :participants

      attr_accessor :repository

      def commits(options = {})
        @pull_requests ||= create_instance 'PullRequests', options

        if repository.present?
          @pull_requests.repo_owner = repository.repo_owner
          @pull_requests.repo_slug  = repository.repo_slug
        end

        @pull_requests.commits(id, options)
      end
    end
  end
end
