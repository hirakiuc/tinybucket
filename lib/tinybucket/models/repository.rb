module Tinybucket
  module Models
    class Repository < BaseModel
      attr_accessor \
        :scm, :has_wiki, :description, :links, :updated_on,
        :fork_policy, :created_on, :owner, :size, :parent, :has_issues,
        :is_private, :full_name, :name, :language

      def pull_requests(options = {})
        @pull_requests ||= create_instance 'PullRequests', options
        @pull_requests.repo_owner = repo_owner
        @pull_requests.repo_slug = repo_slug

        list = @pull_requests.list(options)
        list.map do |pr|
          pr.repository = self
          pr.api_config = api_config.dup
        end

        list
      end

      def pull_request(pullrequest_id, options = {})
        @pull_request ||= create_instance 'PullRequests', options
        @pull_request.repo_owner = repo_owner
        @pull_request.repo_slug = repo_slug

        m = @pull_request.find(pullrequest_id, options)
        m.repository = self

        m
      end

      def watchers(options = {})
        @repo ||= create_instance 'Repo', options
        @repo.repo_owner = repo_owner
        @repo.repo_slug = repo_slug

        @repo.watchers(options)
      end

      def forks(options = {})
        @repo ||= create_instance 'Repo', options
        @repo.repo_owner = repo_owner
        @repo.repo_slug = repo_slug

        @repo.forks(options)
      end

      def commits(options = {})
        @commits ||= create_instance 'Commits', options
        @commits.repo_owner = repo_owner
        @commits.repo_slug = repo_slug

        @commits.list(options)
      end

      def commit(revision, options = {})
        @commits ||= create_instance 'Commits', options
        @commits.repo_owner = repo_owner
        @commits.repo_slug = repo_slug

        @commits.find(revision, options)
      end

      def repo_owner
        case owner
        when Hash
          owner.key?('username') ? owner['username'] : nil
        when String
          owner
        else
          nil
        end
      end

      def repo_slug
        return nil if full_name.blank?

        # full_name seems to be constructed with owner/repo_slug
        keys = full_name.split('/')
        return nil if keys.size < 2
        keys[1]
      end
    end
  end
end
