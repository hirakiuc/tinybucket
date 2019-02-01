# frozen_string_literal: true

module Tinybucket
  module Resource
    class Repos < Base
      def initialize(owner = nil, options = {})
        @owner = owner
        @args = [options]
      end

      # List repositories (public ones if no owner provided, owned ones otherwise)
      #
      # @param options [Hash] Configuration options
      # @return [Tinybucket::Model::Page] Paginated repositories
      def list(options = {})
        options[:owner] = @owner if @owner.present?
        repos_api.list(options)
      end

      # Finds the repository defined by the given owner and slug
      #
      # @param repo_slug [String] The repository slug identifier
      # @param options [Hash]
      # @return [Tinybucket::Model::Repository, NilClass] The identified repository if present and accessible
      def find(repo_slug, options = {})
        return nil unless @owner.present? and repo_slug.present?
        repos_api.find(@owner, repo_slug, options)
      end

      # Creates a new repository with the attributes provided
      #
      # @param repo_slug [String] The repository slug identifier
      # @param options [Hash] Repository attributes
      # @return [Tinybucket::Model::Repository] The created repository
      def create(repo_slug, options = {})
        unless @owner.present?
          raise ArgumentError,
                'must provide an owner in order to create a repository'
        end
        unless repo_slug.present?
          raise ArgumentError,
                'must provide a repo slug in order to create a repository'
        end
        repos_api.create(@owner, repo_slug, options)
      end

      private

      def user_api
        create_api('User').tap do |api|
          api.username = @owner
        end
      end

      def repos_api
        create_api('Repos')
      end

      def enumerator
        if @owner
          create_enumerator(user_api, :repos, *@args)
        else
          create_enumerator(repos_api, :list, *@args)
        end
      end
    end
  end
end
