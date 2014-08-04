module Bitbucket
  module Api
    class ReposApi < BaseApi
      def list(options = {})
        path = path_to_list(options)

        opts = options.clone
        opts.delete(:owner)
        parser = Bitbucket::Parser::ReposParser
        list = get_path(path, opts, parser)

        # pass @config to each repo as api_config
        list.each { |repo| repo.api_config = @config.dup }
        list
      end

      def find(owner, slug, options = {})
        path = path_to_find(owner, slug)
        repo = get_path(path, options, Bitbucket::Parser::RepoParser)

        # pass @config to api_config
        repo.api_config = @config.dup if repo
        repo
      end

      private

      def path_to_list(options)
        path  = '/repositories'
        path += '/' + options[:owner] if options[:owner].present?
        path
      end

      def path_to_find(owner, slug)
        # TODO: sanitize owner, slug.
        fail ArgumentError, 'require owner and repo_slug params.' \
          if owner.blank? || slug.blank?

        "/repositories/#{owner}/#{slug}"
      end
    end
  end
end
