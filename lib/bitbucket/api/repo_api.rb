module Bitbucket
  module Api
    class RepoApi < BaseApi
      attr_accessor :owner, :repo_slug

      def find(options = {})
        path = path_to_find
        repo = get_path(path, options, Bitbucket::Parser::RepoParser)

        # pass @config to api_config
        repo.api_config = @config.dup
        repo
      end

      private

      def path_to_find
        user = (owner.nil?) ? '' : owner.gsub('/', '')
        slug = (repo_slug.nil?) ? '' : repo_slug.gsub('/', '')

        fail ArgumentError, 'require owner and repo_slug params.' \
          if user.blank? || slug.blank?

        "/repositories/#{user}/#{slug}"
      end
    end
  end
end
