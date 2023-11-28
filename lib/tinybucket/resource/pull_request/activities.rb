# frozen_string_literal: true

module Tinybucket
  module Resource
    module PullRequest
      class Activities < Tinybucket::Resource::PullRequest::Base
        private

        def enumerator
          params = [@pull_request.id].concat(@args)

          create_enumerator(pull_request_api, :activities, *params) do |m|
            inject_repo_keys(m, @pull_request.repo_keys)
          end
        end
      end
    end
  end
end