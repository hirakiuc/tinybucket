# frozen_string_literal: true

module Tinybucket
  module Resource
    class Commits < Base
      def initialize(repo, options)
        @repo = repo
        @args = [options]
      end

      # Find the commit
      #
      # @param revision [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::Commit]
      def find(revision, options = {})
        commits_api.find(revision, options).tap do |m|
          inject_repo_keys(m, @repo.repo_keys)
        end
      end

      # Returns the commits for a specific branch
      #
      # @param name [String]
      # @param options [Hash]
      # @return [Tinybucket::Iterator]
      def branch(name, options = {})
        create_enumerator(commits_api, :branch, name, options) do |m|
          inject_repo_keys(m, @repo.repo_keys)
        end
      end

      # Returns the commits for a specific tag
      #
      # @param name [String]
      # @param options [Hash]
      # @return [Tinybucket::Iterator]
      def tag(name, options = {})
        create_enumerator(commits_api, :tag, name, options) do |m|
          inject_repo_keys(m, @repo.repo_keys)
        end
      end

      private

      def commits_api
        create_api('Commits', @repo.repo_keys)
      end

      def enumerator
        create_enumerator(commits_api, :list, *@args) do |m|
          inject_repo_keys(m, @repo.repo_keys)
        end
      end
    end
  end
end
