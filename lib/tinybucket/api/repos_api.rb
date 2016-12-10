module Tinybucket
  module Api
    # Repos Api client
    class ReposApi < BaseApi
      include Tinybucket::Api::Helper::ReposHelper

      # Send 'GET a list of repositories for an account' request
      #
      # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories
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
