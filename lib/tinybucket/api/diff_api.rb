module Tinybucket
  module Api
    # Diff Api client
    #
    # @see https://confluence.atlassian.com/bitbucket/diff-resource-425462484.html
    #   diff Resource
    #
    # @!attribute [rw] repo_owner
    #   @return [String] repository owner name.
    # @!attribute [rw] repo_slug
    #   @return [String] repository slug. (about {https://confluence.atlassian.com/bitbucket/repositories-endpoint-423626330.html#repositoriesEndpoint-Overview
    #     repo_slug})
    class DiffApi < BaseApi
      include Tinybucket::Api::Helper::DiffHelper

      attr_accessor :repo_owner, :repo_slug

      # Send 'GET a diff' request
      #
      # @param spec [String] A specification such as a branch name,
      #   revision, or commit SHA.
      # @param options [Hash]
      # @return [String] diff as raw text
      def find(spec, options = {})
        get_path(path_to_find(spec), options)
      end

      # Send 'GET a patch' request
      #
      # @param spec [String] A specification such as a branch name,
      #   revision, or commit SHA.
      # @param options [Hash]
      # @return [String] patch as raw text
      def find_patch(spec, options = {})
        get_path(path_to_patch(spec), options)
      end
    end
  end
end
