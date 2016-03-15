module Tinybucket
  module Model
    class Repository < Base
      include Tinybucket::Model::Concerns::RepositoryKeys
      include Tinybucket::Model::Concerns::Reloadable

      acceptable_attributes \
        :scm, :has_wiki, :description, :links, :updated_on,
        :fork_policy, :created_on, :owner, :size, :parent, :uuid,
        :has_issues, :is_private, :full_name, :name, :language

      def create(_params)
        raise NotImplementedError
      end

      def destroy
        raise NotImplementedError
      end

      def pull_requests(options = {})
        list = pull_requests_api.list(options)
        inject_repo_keys(list)
      end

      def pull_request(pullrequest_id = nil, options = {})
        m = if pullrequest_id.present?
              pull_requests_api.find(pullrequest_id, options)
            else
              Tinybucket::Model::PullRequest.new({})
            end
        inject_repo_keys(m)
      end

      def watchers(options = {})
        repo_api.watchers(options)
      end

      def forks(options = {})
        repo_api.forks(options)
      end

      def commits(options = {})
        list = commits_api.list(options)
        inject_repo_keys(list)
      end

      def commit(revision, options = {})
        m = commits_api.find(revision, options)
        inject_repo_keys(m)
      end

      def branch_restrictions(options = {})
        list = restrictions_api.list(options)
        inject_repo_keys(list)
      end

      def branch_restriction(restriction_id, options = {})
        m = restrictions_api.find(restriction_id, options)
        inject_repo_keys(m)
      end

      def diff(spec, options = {})
        diff_api.find(spec, options)
      end

      def patch(spec, options = {})
        diff_api.find_patch(spec, options)
      end

      private

      def pull_requests_api
        create_api('PullRequests', repo_keys)
      end

      def repo_api
        create_api('Repo', repo_keys)
      end

      def commits_api
        create_api('Commits', repo_keys)
      end

      def restrictions_api
        create_api('BranchRestrictions', repo_keys)
      end

      def diff_api
        create_api('Diff', repo_keys)
      end

      def load_model
        repo_api.find()
      end
    end
  end
end
