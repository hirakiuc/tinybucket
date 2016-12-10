# frozen_string_literal: true

module Tinybucket
  module Api
    module Helper
      module CommentsHelper
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
          case commented_to
          when Tinybucket::Model::Commit
            base_path_of_commit
          when Tinybucket::Model::PullRequest
            base_path_of_pullrequest
          else
            raise ArgumentError, 'commented_to must be a pull_request or commit'
          end
        end

        def base_path_of_commit
          build_path('/repositories',
                     [repo_owner, 'repo_owner'],
                     [repo_slug,  'repo_slug'],
                     'commit',
                     [commented_to.hash, 'revision'],
                     'comments')
        end

        def base_path_of_pullrequest
          build_path('/repositories',
                     [repo_owner, 'repo_owner'],
                     [repo_slug,  'repo_slug'],
                     'pullrequests',
                     [commented_to.id, 'pull_request_id'],
                     'comments')
        end
      end
    end
  end
end
