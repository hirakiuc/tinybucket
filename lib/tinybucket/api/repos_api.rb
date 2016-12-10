# frozen_string_literal: true

module Tinybucket
  module Api
    # Repos Api client
    class ReposApi < BaseApi
      include Tinybucket::Api::Helper::ReposHelper

      # Send 'GET a list of repositories for an account' request
      #
      # @see https://confluence.atlassian.com/bitbucket/repositories-endpoint-423626330.html#repositoriesEndpoint-GETalistofrepositoriesforanaccount
      #   GET a list of repositories for an account
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def list(options = {})
        opts = options.clone
        opts.delete(:owner)

        get_path(
          path_to_list(options),
          opts,
          Tinybucket::Parser::ReposParser
        )
      end
    end
  end
end
