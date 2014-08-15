module Tinybucket
  module Api
    module Helper
      module CommitCommentsHelper
        include ::Tinybucket::Api::Helper::ApiHelper

        private

        def path_to_list
          base_path
        end

        def path_to_find(comment_id)
          build_path(base_path,
                     [comment_id, 'comment_id'])
        end

        def base_path
          assert_commit

          build_path('/repositories',
                     [repo_owner, 'repo_owner'],
                     [repo_slug,  'repo_slug'],
                     'commit',
                     [commit.hash, 'revision'],
                     'comments')
        end

        def assert_commit
          fail ArgumentError, 'commit was nil.' if commit.nil?
        end
      end
    end
  end
end
