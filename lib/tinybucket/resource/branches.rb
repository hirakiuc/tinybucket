# frozen_string_literal: true

module Tinybucket
  module Resource
    class Branches < Tinybucket::Resource::Base
      def initialize(repo, options)
        @repo = repo
        @args = [options]
      end

      # Find the branch
      #
      # @param branch [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::Branch]
      def find(branch, options = {})
        branches_api.find(branch, options).tap do |m|
          inject_repo_keys(m, @repo.repo_keys)
        end
      end

      private

      def branches_api
        create_api('Branches', @repo.repo_keys)
      end

      def enumerator
        create_enumerator(branches_api, :list, *@args) do |m|
          inject_repo_keys(m, @repo.repo_keys)
        end
      end
    end
  end
end
