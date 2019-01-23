# frozen_string_literal: true

module Tinybucket
  module Api
    # Repos Api client
    class ReposApi < BaseApi
      include Tinybucket::Api::Helper::ReposHelper

      # Send 'GET a list of repositories for an account' request or public ones if no account specified
      #
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D
      #
      #   GET a list of repositories for an account or public ones if none specified
      #
      # @param owner [String] The name of the account
      # @param options [Hash] Configuration options for the request
      # @return [Tinybucket::Model::Page]
      def list(owner = nil, options = {})
        get_path(
          path_to_list(owner, options),
          options,
          get_parser(:collection, Tinybucket::Model::Repository)
        )
      end
    end
  end
end
