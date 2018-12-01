# frozen_string_literal: true

module Tinybucket
  module Api
    # Tags Api client
    #
    # @!attribute [rw] repo_owner
    #   @return [String] repository owner name.
    # @!attribute [rw] repo_slug
    #   @return [String] {https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D repo_slug}.
    class TagsApi < BaseApi
      include Tinybucket::Api::Helper::TagsHelper

      attr_accessor :repo_owner, :repo_slug

      # Send 'GET a tags list for a repository' request
      #
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/refs/tags#get
      #   GET a tags list for a repository
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def list(options = {})
        get_path(
          path_to_list,
          options,
          get_parser(:collection, Tinybucket::Model::Tag)
        )
      end

      # Send 'GET an individual tag' request
      #
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D/refs/tags/%7Bname%7D#get
      #   GET an individual tag
      #
      # @param name [String] The tag name
      # @param options [Hash]
      # @return [Tinybucket::Model::Tag]
      def find(name, options = {})
        get_path(
          path_to_find(name),
          options,
          get_parser(:object, Tinybucket::Model::Tag)
        )
      end
    end
  end
end
