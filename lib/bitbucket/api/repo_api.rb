module Bitbucket
  module Api
    class RepoApi < BaseApi
      attr_accessor :repo_owner, :repo_slug

      def find(options = {})
        path = path_to_find
        repo = get_path(path, options, Bitbucket::Parser::RepoParser)

        # pass @config to api_config
        repo.api_config = @config.dup if repo
        repo
      end

      private

      def path_to_find
        owner = (repo_owner.nil?) ? '' : CGI.escape(repo_owner)
        slug  = (repo_slug.nil?)  ? '' : CGI.escape(repo_slug)

        fail ArgumentError, 'require owner and repo_slug params.' \
          if owner.blank? || slug.blank?

        "/repositories/#{owner}/#{slug}"
      end
    end
  end
end
