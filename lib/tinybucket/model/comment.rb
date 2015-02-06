module Tinybucket
  module Model
    class Comment < Base
      include Tinybucket::Model::Concerns::RepositoryKeys
      include Tinybucket::Model::Concerns::Reloadable

      attr_accessor \
        :links, :id, :parent,  :filename, :content, :user, :inline, \
        :created_on, :updated_on, :uuid

      attr_accessor :commented_to

      private

      def commit_api
        create_api('Comments', repo_keys, options)
      end

      def pull_request_api(options)
        create_api('PullRequests', repo_keys, options)
      end

      def load_model
        api =
          case commented_to
          when Tinybucket::Model::Commit
            commit_api({})
          when Tinybucket::Model::PullRequest
            pull_request_api({})
          else
            fail ArgumentError, 'commented_to was invalid'
          end

        api.commented_to = commented_ato
        api.find(id, {})
      end
    end
  end
end
