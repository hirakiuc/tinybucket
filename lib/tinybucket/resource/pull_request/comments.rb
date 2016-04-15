module Tinybucket
  module Resource
    module PullRequest
      class Comments < Tinybucket::Resource::PullRequest::Base
        # Get the specific comment on the pull request.
        #
        # @param comment_id [String]
        # @param options [Hash]
        # @return [Tinybucket::Model::Comment]
        def find(comment_id, options)
          comment_api.find(comment_id, options)
        end

        private

        def comment_api
          create_api('Comments', @pull_request.repo_keys).tap do |api|
            api.commented_to = @pull_request
          end
        end

        def enumerator
          create_enumerator(comment_api, :list, *@args) do |m|
            inject_repo_keys(m, @pull_request.repo_keys)
          end
        end
      end
    end
  end
end
