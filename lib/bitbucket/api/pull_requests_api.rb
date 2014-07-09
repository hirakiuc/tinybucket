module Bitbucket
  module Api
    class PullRequestsApi < BaseApi
      attr_accessor :repo_owner, :repo_slug

      def list(options = {})
        path = path_to_list
        get_path(path, options, Bitbucket::Parser::PullRequestsParser)
      end

      private

      def path_to_list
        owner = (repo_owner.nil?) ? '' : repo_owner.gsub('/', '')
        slug = (repo_slug.nil?) ? '' : repo_slug.gsub('/', '')

        fail ArgumentError, 'require owner and repo_slug params.' \
          if owner.blank? || slug.blank?

        "/repositories/#{owner}/#{slug}/pullrequests"
      end
    end
  end
end
