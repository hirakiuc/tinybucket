module Tinybucket
  module Api
    class PullRequestsApi < BaseApi
      attr_accessor :repo_owner, :repo_slug

      def list(options = {})
        path = path_to_list
        list = get_path(path, options, Tinybucket::Parser::PullRequestsParser)

        # pass @config to each model as api_config
        list.each { |m| m.api_config = @config.dup }
        list
      end

      def find(pr_id, options = {})
        path = path_to_find(pr_id)
        m = get_path(path, options, Tinybucket::Parser::PullRequestParser)

        # pass @config to each model as api_config
        m.api_config = @config.dup if m
        m
      end

      def commits(pr_id, options = {})
        path = path_to_commits(pr_id)
        list = get_path(path, options, Tinybucket::Parser::CommitsParser)

        # pass @config to each model as api_config
        list.each { |m| m.api_config = @config.dup }
        list
      end

      private

      def path_to_list
        owner = (repo_owner.nil?) ? '' : CGI.escape(repo_owner)
        slug  = (repo_slug.nil?)  ? '' : CGI.escape(repo_slug)

        fail ArgumentError, 'require owner and repo_slug params.' \
          if owner.blank? || slug.blank?

        "/repositories/#{owner}/#{slug}/pullrequests"
      end

      def path_to_find(pr_id)
        prid  = (pr_id.nil?) ?       '' : CGI.escape(pr_id.to_s)
        owner = (repo_owner.nil?) ?  '' : CGI.escape(repo_owner)
        slug  = (repo_slug.nil?) ?   '' : CGI.escape(repo_slug)

        fail ArgumentError, 'require owner and repo_slug params.' \
          if owner.blank? || slug.blank? || prid.blank?

        "/repositories/#{owner}/#{slug}/pullrequests/#{prid}"
      end

      def path_to_commits(pr_id)
        prid  = (pr_id.nil?) ?       '' : CGI.escape(pr_id.to_s)
        owner = (repo_owner.nil?) ?  '' : CGI.escape(repo_owner)
        slug  = (repo_slug.nil?) ?   '' : CGI.escape(repo_slug)

        fail ArgumentError, 'require owner/repo_slug, pr_id params.' \
          if prid.blank? || owner.blank? || slug.blank?

        "/repositories/#{owner}/#{slug}/pullrequests/#{prid}/commits"
      end
    end
  end
end
