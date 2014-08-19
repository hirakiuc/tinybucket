module Tinybucket
  module Model
    class Repository < Base
      attr_accessor :scm, :has_wiki, :description, :links, :updated_on,
                    :fork_policy, :created_on, :owner, :size, :parent,
                    :has_issues, :is_private, :full_name, :name, :language

      def pull_requests(options = {})
        list = pull_requests_api(repo_owner, repo_slug, options).list(options)
        inject_repository(list)
      end

      def pull_request(pullrequest_id, options = {})
        m = pull_requests_api(repo_owner, repo_slug, options)
          .find(pullrequest_id, options)

        inject_repository(m)
      end

      def watchers(options = {})
        repo_api(repo_owner, repo_slug, options).watchers(options)
      end

      def forks(options = {})
        repo_api(repo_owner, repo_slug, options).forks(options)
      end

      def commits(options = {})
        list = commits_api(repo_owner, repo_slug, options).list(options)
        inject_repository(list)
      end

      def commit(revision, options = {})
        m = commits_api(repo_owner, repo_slug, options).find(revision, options)
        inject_repository(m)
      end

      def branch_restrictions(options = {})
        list = restrictions_api(repo_owner, repo_slug, options).list(options)
        inject_repository(list)
      end

      def branch_restriction(restriction_id, options = {})
        m = restrictions_api(repo_owner, repo_slug, options)
          .find(restriction_id, options)

        inject_repository(m)
      end

      def diff(spec, options = {})
        diff_api(repo_owner, repo_slug, options).find(spec, options)
      end

      def patch(spec, options = {})
        diff_api(repo_owner, repo_slug, options).find_patch(spec, options)
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

      def inject_repository(result)
        case result
        when Tinybucket::Model::Page
          result.items.map { |m| m.repository = self }
        when Tinybucket::Model::Base
          result.repository = self if result.respond_to?(:repository=)
        end

        result
      end
    end
  end
end
