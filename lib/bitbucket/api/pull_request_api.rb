module Bitbucket
  module Api
    class PullRequestApi < BaseApi
      attr_accessor :repo_owner, :repo_slug

      def find(pr_id, options = {})
        path = path_to_find(pr_id)
        get_path(path, options, Bitbucket::Parser::PullRequestParser)
      end

      private

      def path_to_find(pr_id)
        user = (repo_owner.nil?) ? '' : repo_owner.gsub('/', '')
        slug = (repo_slug.nil?) ? '' : repo_slug.gsub('/', '')

        fail ArgumentError, 'require owner and repo_slug params.' \
          if user.blank? || slug.blank?

        "/repositories/#{user}/#{slug}/#{pr_id}"
      end
    end
  end
end
