# frozen_string_literal: true

module Tinybucket
  module Api
    # Repos Api client
    class ReposApi < BaseApi
      include Tinybucket::Api::Helper::ReposHelper
    
      #
      # GET a list of repositories for an account or public ones if none specified
      #
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories#get
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D#get
      #
      # @param owner [String] The name of the account
      # @param options [Hash] Configuration options for the request
      # @return [Tinybucket::Model::Page]
      def list(options = {})
        get_path(
          path_to_list(options),
          options,
          get_parser(:collection, Tinybucket::Model::Repository)
        )
      end

      #
      # GET the identified repository for the given account, nil otherwise
      #
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D#get
      #
      # @param owner [String] The name of the account
      # @param options [Hash] Configuration options for the request
      # @return [Tinybucket::Model::Page]
      def find(repo_owner, repo_slug, options = {})
        get_path(
          path_to_find(repo_owner, repo_slug),
          options,
          get_parser(:object, Tinybucket::Model::Repository)
        )
      end

      #
      # POST (create) a new repository with the provided information for the given account
      #
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D#post
      #
      # @param owner [String] The name of the account
      # @param options [Hash] Configuration options for the request
      # @return [Tinybucket::Model::Page]
      def create(repo_owner, repo_slug, options = {})
        post_path(
          path_to_post(repo_owner, repo_slug),
          options,
          get_parser(:object, Tinybucket::Model::Repository)
        )
      end
    end
  end
end
