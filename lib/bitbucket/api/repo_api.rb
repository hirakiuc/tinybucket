require 'bitbucket/parser/repo_parser'

module Bitbucket
  module Api
    class RepoApi < BaseApi
      def find(owner, repo_slug, options = {})
        path = path_to_find(owner, repo_slug)
        repo = get_path(path, options, Bitbucket::Parser::RepoParser)

        # pass @config to api_config
        repo.api_config = @config.dup
        repo
      end

      private

      def path_to_find(owner, repo_slug)
        owner = (owner.nil?) ? '' : owner.gsub('/', '')
        repo_slug = (repo_slug.nil?) ? '' : repo_slug.gsub('/', '')

        fail ArgumentError, 'require owner and repo_slug params.' \
          if owner.blank? || repo_slug.blank?

        "/repositories/#{owner}/#{repo_slug}"
      end
    end
  end
end
