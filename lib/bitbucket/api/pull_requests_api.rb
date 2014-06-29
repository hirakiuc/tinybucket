require 'bitbucket/parser/pull_requests_parser'

module Bitbucket
  module Api
    class PullRequestsApi < BaseApi
      def list(owner, repo_slug, options = {})
        path = path_to_list(owner, repo_slug)
        get_path(path, options, Bitbucket::Parser::PullRequestsParser)
      end

      private

      def path_to_list(owner, repo_slug)
        owner = (owner.nil?) ? '' : owner.gsub('/', '')
        repo_slug = (repo_slug.nil?) ? '' : repo_slug.gsub('/', '')

        fail ArgumentError, 'require owner and repo_slug params.' \
          if owner.blank? || repo_slug.blank?

        "/repositories/#{owner}/#{repo_slug}/pullrequests"
      end
    end
  end
end
