module Tinybucket
  module Model
    class Repository < Base
      include Tinybucket::Model::Concerns::RepositoryKeys
      include Tinybucket::Model::Concerns::Reloadable

      attr_accessor :scm, :has_wiki, :description, :links, :updated_on,
                    :fork_policy, :created_on, :owner, :size, :parent,
                    :has_issues, :is_private, :full_name, :name, :language

      def create(_params)
        fail NotImplementedError
      end

      def destroy
        fail NotImplementedError
      end

      def pull_requests(options = {})
        list = pull_requests_api(options).list(options)
        inject_repo_keys(list)
      end

      def pull_request(pullrequest_id = nil, options = {})
        m = if pullrequest_id.present?
              pull_requests_api(options).find(pullrequest_id, options)
            else
              Tinybucket::Model::PullRequest.new({})
            end
        inject_repo_keys(m)
      end

      def watchers(options = {})
        repo_api(options).watchers(options)
      end

      def forks(options = {})
        repo_api(options).forks(options)
      end

      def commits(options = {})
        list = commits_api(options).list(options)
        inject_repo_keys(list)
      end

      def commit(revision, options = {})
        m = commits_api(options).find(revision, options)
        inject_repo_keys(m)
      end

      def branch_restrictions(options = {})
        list = restrictions_api(options).list(options)
        inject_repo_keys(list)
      end

      def branch_restriction(restriction_id, options = {})
        m = restrictions_api(options).find(restriction_id, options)
        inject_repo_keys(m)
      end

      def diff(spec, options = {})
        diff_api(options).find(spec, options)
      end

      def patch(spec, options = {})
        diff_api(options).find_patch(spec, options)
      end

      private

      def pull_requests_api(options)
        create_api('PullRequests', repo_keys, options)
      end

      def repo_api(options)
        create_api('Repo', repo_keys, options)
      end

      def commits_api(options)
        create_api('Commits', repo_keys, options)
      end

      def restrictions_api(options)
        create_api('BranchRestrictions', repo_keys, options)
      end

      def diff_api(options)
        create_api('Diff', repo_keys, options)
      end

      def load_model
        repo_api({}).find()
      end
    end
  end
end
