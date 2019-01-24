# frozen_string_literal: true

module Tinybucket
  module Model
    # Repository
    #
    # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories
    #   Repository Endpoint
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
    # @!attribute [rw] project
    #   @return [Hash]
    class Repository < Base
      include Tinybucket::Model::Concerns::RepositoryKeys

      acceptable_attributes \
        :scm, :has_wiki, :description, :links, :updated_on,
        :fork_policy, :created_on, :owner, :size, :parent, :uuid,
        :has_issues, :is_private, :full_name, :name, :language,
        :website, :type, :project

      def initialize(json)
        super(json)

        return unless full_name && full_name.split('/').size == 2
        @repo_owner, @repo_slug = full_name.split('/')
      end


      # Update this repository (remotely and the current instance)
      #
      # @param options [Hash] Attributes to be updated for current repository
      # @return [Tinybucket::Model::Repository] The updated repository
      def update(options)
        self.attributes = repo_api.put(options).attributes
        @repo_owner, @repo_slug = full_name.split('/')
        self
      end

      # Destroy this repository
      #
      # @return [NilClass]
      def destroy
        repo_api.delete
      end

      # Get pull requests on thie repository.
      #
      # @param options [Hash]
      # @return [Tinybucket::Enumerator] an enumerator to enumerate
      #   pull requests as {Tinybucket::Model::PullRequest} instance.
      def pull_requests(options = {})
        pull_requests_resource(options)
      end

      # Get the specific pull request on this repository.
      #
      # @param pullrequest_id [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::PullRequest]
      def pull_request(pullrequest_id, options = {})
        pull_requests_resource.find(pullrequest_id, options)
      end

      # Get watchers on this repository.
      #
      # @param options [Hash]
      # @return [Tinybucket::Resource::Watchers]
      def watchers(options = {})
        watchers_resource(options)
      end

      # Get repository forks.
      #
      # @param options [Hash]
      # @return [Tinybucket::Resource::Forks]
      def forks(options = {})
        forks_resource(options)
      end

      # Get commits on this repository.
      #
      # @param options [Hash]
      # @return [Tinybucket::Resource::Commits]
      def commits(options = {})
        commits_resource(options)
      end

      # Get the specific commit on this repository.
      #
      # @param revision [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::Commit]
      def commit(revision, options = {})
        commits_resource.find(revision, options)
      end

      # Get branches on this repository
      #
      # @param options [Hash]
      # @return [Tinybucket::Resource::Branches]
      def branches(options = {})
        branches_resource(options)
      end

      # Get the specific branch on this repository.
      #
      # @param branch [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::Branches]
      def branch(branch, options = {})
        branches_resource.find(branch, options)
      end

      # Get the branch restriction information associated with this repository.
      #
      # @param options [Hash]
      # @return [Tinybucket::Resource::BranchRestrictions]
      def branch_restrictions(options = {})
        branch_restrictions_resource(options)
      end

      # Get the specific branch restriction information on this repository.
      #
      # @param restriction_id [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::BranchRestriction]
      def branch_restriction(restriction_id, options = {})
        branch_restrictions_resource.find(restriction_id, options)
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

      def branch_restrictions_resource(options = {})
        Tinybucket::Resource::BranchRestrictions.new(self, options)
      end

      def branches_resource(options = {})
        Tinybucket::Resource::Branches.new(self, options)
      end

      def commits_resource(options = {})
        Tinybucket::Resource::Commits.new(self, options)
      end

      def hooks_resource(options = {})
        Tinybucket::Resource::Hooks.new(self, options)
      end

      def pull_requests_resource(options = {})
        Tinybucket::Resource::PullRequests.new(self, options)
      end

      def watchers_resource(options = {})
        Tinybucket::Resource::Watchers.new(self, options)
      end

      def forks_resource(options = {})
        Tinybucket::Resource::Forks.new(self, options)
      end

      def repo_api
        create_api('Repo', repo_keys)
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
