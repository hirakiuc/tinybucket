module Tinybucket
  module Model
    class PullRequest < Base
      attr_accessor \
        :state, :description, :links, :title, :close_source_branch,
        :destination, :reason, :id, :source, :created_on, :author, :updated_on,
        :merge_commit, :closed_by, :reviewers, :participants

      attr_accessor :repository

      def approve(options = {})
        pull_request_api(options).approve(id, options)
      end

      def unapprove(options = {})
        pull_request_api(options).unapprove(id, options)
      end

      def commits(options = {})
        pull_request_api(options).commits(id, options)
      end

      private

      def pull_request_api(options)
        fail ArgumentError,
             'This method call require repository.' if repository.nil?

        create_api('PullRequests', repository, options)
      end
    end
  end
end
