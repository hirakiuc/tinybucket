# frozen_string_literal: true

module Tinybucket
  module Resource
    module Commit
      class BuildStatuses < Tinybucket::Resource::Commit::Base
        # Get the build status for the commit
        #
        # @param key [String]
        # @param options [Hash]
        # @option options [String] :state
        # @option options [String] :key
        # @option options [String] :name
        # @option options [String] :url
        # @option options [String] :description
        # @return [Tinybucket::Model::BuildStatus]
        def find(key, options = {})
          build_status_api.find(@commit.hash, key, options).tap do |m|
            m.revision = @commit.hash
            m.repo_keys = @commit.repo_keys
          end
        end

        # Create a build status for the commit
        #
        # @param key [String]
        # @param options [Hash]
        # @return [Tinybucket::Model::BuildStatus]
        def create(key, options)
          build_status_api.post(@commit.hash, key, options).tap do |m|
            m.revision = @commit.hash
            m.repo_keys = @commit.repo_keys
          end
        end

        private

        def build_status_api
          create_api('BuildStatus', @commit.repo_keys)
        end

        # FIXME: raise NoMethodError on method_missing.
        def enumerator
          nil
        end
      end
    end
  end
end
