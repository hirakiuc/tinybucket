# frozen_string_literal: true

module Tinybucket
  module Resource
    class Tags < Tinybucket::Resource::Base
      def initialize(repo, options)
        @repo = repo
        @args = [options]
      end

      # Find the tag
      #
      # @param tag [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::Tag]
      def find(tag, options = {})
        tags_api.find(tag, options).tap do |m|
          inject_repo_keys(m, @repo.repo_keys)
        end
      end

      private

      def tags_api
        create_api('Tags', @repo.repo_keys)
      end

      def enumerator
        create_enumerator(tags_api, :list, *@args) do |m|
          inject_repo_keys(m, @repo.repo_keys)
        end
      end
    end
  end
end
