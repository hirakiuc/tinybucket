module Tinybucket
  module Models
    class Repository < BaseModel
      attr_accessor \
        :scm, :has_wiki, :description, :links, :updated_on,
        :fork_policy, :created_on, :owner, :size, :parent, :has_issues,
        :is_private, :full_name, :name, :language

      def pull_requests(options = {})
        list = pull_requests_api(options).list(options)
        inject_repository(list)
      end

      def pull_request(pullrequest_id, options = {})
        m = pull_requests_api(options).find(pullrequest_id, options)
        inject_repository(m)
      end

      def watchers(options = {})
        repo_api(options).watchers(options)
      end

      def forks(options = {})
        repo_api(options).forks(options)
      end

      def commits(options = {})
        list = commits_api(options).list(options)
        inject_repository(list)
      end

      def commit(revision, options = {})
        m = commits_api(options).find(revision, options)
        inject_repository(m)
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

      private

      def pull_requests_api(options)
        return @pull_requests if @pull_requests

        @pull_requests = create_instance 'PullRequests', options
        @pull_requests.repo_owner = repo_owner
        @pull_requests.repo_slug = repo_slug

        @pull_requests
      end

      def repo_api(options)
        return @repo if @repo

        @repo = create_instance 'Repo', options
        @repo.repo_owner = repo_owner
        @repo.repo_slug = repo_slug

        @repo
      end

      def commits_api(options)
        return @commits if @commits

        @commits = create_instance 'Commits', options
        @commits.repo_owner = repo_owner
        @commits.repo_slug = repo_slug

        @commits
      end

      def inject_repository(result)
        case result
        when Tinybucket::Models::Page
          result.map { |m| m.repository = self }
        when Tinybucket::Models::BaseModel
          result.repository = self if result.respond_to?(:repository=)
        end

        result
      end
    end
  end
end
