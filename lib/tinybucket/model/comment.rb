module Tinybucket
  module Model
    class Comment < Base
      include Tinybucket::Model::Concerns::RepositoryKeys
      include Tinybucket::Model::Concerns::Reloadable

      attr_accessor \
        :links, :id, :parent,  :filename, :content, :user, :inline, \
        :created_on, :updated_on

      attr_accessor :commented_to

      private

      def commit_api
        create_api('CommitComments', repo_keys, options)
      end

      def pull_request_api(options)
        create_api('PullRequests', repo_keys, options)
      end

      def load_model
        case commented_to
        when Tinybucket::Model::Commit
          commit_api({}).find(id, {})
        when Tinybucket::Model::PullRequest
          pull_request_api({}).find(id, {})
        else
          fail ArgumentError, 'commented_to was invalid'
        end
      end
    end
  end
end
