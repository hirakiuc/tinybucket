module Tinybucket
  module Resource
    module PullRequest
      class Commits < Tinybucket::Resource::PullRequest::Base
        private

        def enumerator
          params = [@pull_request.id].concat(@args)

          create_enumerator(pull_request_api, :commits, *params) do |m|
            inject_repo_keys(m, @pull_request.repo_keys)
          end
        end
      end
    end
  end
end
