# frozen_string_literal: true

module Tinybucket
  module Resource
    class Hooks < Tinybucket::Resource::Base
      def initialize(repo, options)
        @repo = repo
        @args = [options]
      end

      # Find the hook
      #
      # @param hook [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::Hook]
      def find(hook, options = {})
        hooks_api.find(hook, options).tap do |m|
          inject_repo_keys(m, @repo.repo_keys)
        end
      end

      # Create a new hook
      #
      # @param url [String]
      # @param events [Array]
      # @param description [String]
      # @param description [Boolean]
      # @param options [Hash]
      # @return [Tinybucket::Model::Hook]
      def create(url, events, description = '', active = true, options = {})
        hooks_api.post(url, events, description, active, options).tap do |m|
          m.repo_keys = @repo.repo_keys
        end
      end

      private

      def hooks_api
        create_api('Hooks', @repo.repo_keys)
      end

      def enumerator
        create_enumerator(hooks_api, :list, *@args) do |m|
          inject_repo_keys(m, @repo.repo_keys)
        end
      end
    end
  end
end
