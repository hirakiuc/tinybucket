# frozen_string_literal: true

module Tinybucket
  module Resource
    module PullRequest
      class Base < Tinybucket::Resource::Base
        def initialize(pull_request, options)
          @pull_request = pull_request
          @args = [options]
        end

        protected

        def pull_request_api
          create_api('PullRequests', @pull_request.repo_keys)
        end
      end
    end
  end
end
