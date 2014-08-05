module Bitbucket
  module Api
    class CommitsApi < BaseApi
      attr_accessor :repo_owner, :repo_slug

      def list(options = {})
        path = path_to_list
        list = get_path(path, options, Bitbucket::Parser::CommitsParser)

        # pass @config to each repo as api_config
        list.each { |m| m.api_config = @config.dup }
        list
      end

      def find(revision, options = {})
        path = path_to_find(revision)
        m = get_path(path, options, Bitbucket::Parser::CommitParser)

        m.api_config = @config.dup if m
        m
      end

      private

      def path_to_list
        owner = (repo_owner.nil?) ? '' : CGI.escape(repo_owner)
        slug  = (repo_slug.nil?)  ? '' : CGI.escape(repo_slug)

        fail ArgumentError, 'require owner and repo_slug params.' \
          if owner.blank? || slug.blank?

        "/repositories/#{owner}/#{slug}/commits"
      end

      def path_to_find(revision)
        owner = (repo_owner.nil?) ? '' : CGI.escape(repo_owner)
        slug  = (repo_slug.nil?)  ? '' : CGI.escape(repo_slug)
        rev   = (revision.nil?)   ? '' : CGI.escape(revision)

        fail ArgumentError, 'require owner/slug/rev' \
          if owner.blank? || slug.blank? || rev.blank?

        "/repositories/#{owner}/#{slug}/commit/#{rev}"
      end
    end
  end
end
