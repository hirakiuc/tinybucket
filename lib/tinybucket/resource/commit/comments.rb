module Tinybucket
  module Resource
    module Commit
      class Comments < Tinybucket::Resource::Commit::Base
        # Get the specific commit comment which associate with the commit.
        #
        # @param comment_id [String]
        # @param options [Hash]
        # @return [Tinybucket::Model::Comment]
        def find(comment_id, options = {})
          comments_api.find(comment_id, options).tap do |m|
            m.repo_keys = @commit.repo_keys
          end
        end

        private

        def comments_api
          create_api('Comments', @commit.repo_keys).tap do |api|
            api.commented_to = @commit
          end
        end

        def enumerator
          create_enumerator(comments_api, :list, *@args) do |m|
            inject_repo_keys(m, @commit.repo_keys)
          end
        end
      end
    end
  end
end
