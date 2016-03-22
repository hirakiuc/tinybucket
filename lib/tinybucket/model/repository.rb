module Tinybucket
  module Model
    # Repository
    #
    # @see https://confluence.atlassian.com/bitbucket/repositories-endpoint-423626330.html#repositoriesEndpoint-Overview
    #   Repository Endpoint - Bitbucket Cloud REST API document
    #
    # @!attribute [rw] scm
    #   @return [String]
    # @!attribute [rw] has_wiki
    #   @return [true, false]
    # @!attribute [rw] description
    #   @return [String]
    # @!attribute [rw] links
    #   @return [Hash]
    # @!attribute [rw] updated_on
    #   @return [String]
    # @!attribute [rw] fork_policy
    #   @return [String]
    # @!attribute [rw] created_on
    #   @return [String]
    # @!attribute [rw] owner
    #   @return [Hash]
    # @!attribute [rw] size
    #   @return [Fixnum]
    # @!attribute [rw] parent
    #   @return [Hash, NillClass]
    # @!attribute [rw] uuid
    #   @return [String]
    # @!attribute [rw] has_issues
    #   @return [true, false]
    # @!attribute [rw] is_private
    #   @return [true, false]
    # @!attribute [rw] full_name
    #   @return [String]
    # @!attribute [rw] name
    #   @return [String]
    # @!attribute [rw] language
    #   @return [String]
    # @!attribute [rw] website
    #   @return [String]
    # @!attribute [rw] type
    #   @return [String]
    class Repository < Base
      include Tinybucket::Model::Concerns::RepositoryKeys

      acceptable_attributes \
        :scm, :has_wiki, :description, :links, :updated_on,
        :fork_policy, :created_on, :owner, :size, :parent, :uuid,
        :has_issues, :is_private, :full_name, :name, :language,
        :website, :type

      def initialize(json)
        super(json)

        if full_name && full_name.split('/').size == 2
          @repo_owner, @repo_slug = full_name.split('/')
        end
      end

      # Create a new repository.
      #
      # @todo to be implemented.
      # @raise [NotImplementedError] to be implemented.
      def create(_params)
        raise NotImplementedError
      end

      # Remove this repository
      #
      # @todo to be implemented.
      # @raise [NotImplementedError] to be implemented.
      def destroy
        raise NotImplementedError
      end

      # Get pull requests on thie repository.
      #
      # @param options [Hash]
      # @return [Tinybucket::Enumerator] an enumerator to enumerate
      #   pull requests as {Tinybucket::Model::PullRequest} instance.
      def pull_requests(options = {})
        enumerator(
          pull_requests_api,
          :list,
          options
        ) do |m|
          inject_repo_keys(m)
          block_given? ? yield(m) : m
        end
      end

      # Get the specific pull request on this repository.
      #
      # @param pullrequest_id [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::PullRequest]
      def pull_request(pullrequest_id = nil, options = {})
        m = if pullrequest_id.present?
              pull_requests_api.find(pullrequest_id, options)
            else
              Tinybucket::Model::PullRequest.new({})
            end
        inject_repo_keys(m)
      end

      # Get watchers on this repository.
      #
      # @param options [Hash]
      # @return [Tinybucket::Enumerator] an enumerator to enumerate watchers
      #   as {Tinybucket::Model::Profile} instance.
      def watchers(options = {})
        enumerator(
          repo_api,
          :watchers,
          options
        ) do |m|
          inject_repo_keys(m)
          block_given? ? yield(m) : m
        end
      end

      # Get repository forks.
      #
      # @param options [Hash]
      # @return [Tinybucket::Enumerator] an enumerator to enumerate forks
      #   as {Tinybucket::Model::Repository} instance.
      def forks(options = {})
        enumerator(
          repo_api,
          :forks,
          options
        ) do |m|
          inject_repo_keys(m)
          block_given? ? yield(m) : m
        end
      end

      # Get commits on this repository.
      #
      # @param options [Hash]
      # @return [Tinybucket::Enumerator] an enumerator to enumerate commits
      #   as {Tinybucket::Model::Commit} instance.
      def commits(options = {})
        enumerator(
          commits_api,
          :list,
          options
        ) do |m|
          inject_repo_keys(m)
          block_given? ? yield(m) : m
        end
      end

      # Get the specific commit on this repository.
      #
      # @param revision [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::Commit]
      def commit(revision, options = {})
        m = commits_api.find(revision, options)
        inject_repo_keys(m)
      end

      # Get the branch restriction information associated with this repository.
      #
      # @param options [Hash]
      # @return [Tinybucket::Enumerator] an enumerator to enumerate
      #   branch restriction information as
      #   {Tinybucket::Model::BranchRestriction} instance.
      def branch_restrictions(options = {})
        enumerator(
          restrictions_api,
          :list,
          options
        ) do |m|
          inject_repo_keys(m)
          block_given? ? yield(m) : m
        end
      end

      # Get the specific branch restriction information on this repository.
      #
      # @param restriction_id [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::BranchRestriction]
      def branch_restriction(restriction_id, options = {})
        m = restrictions_api.find(restriction_id, options)
        inject_repo_keys(m)
      end

      # Get the diff for this repository.
      #
      # @param spec [String] A specification such as a branch name,
      #   revision, or commit SHA.
      # @param options [Hash]
      # @return [String] diff as raw text.
      def diff(spec, options = {})
        diff_api.find(spec, options)
      end

      # Get the patch for the specification.
      #
      # @param spec [String] A specification such as a branch name,
      #   revision, or commit SHA.
      # @return [String] patch as raw text.
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
