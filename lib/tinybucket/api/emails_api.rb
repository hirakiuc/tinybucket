module Tinybucket
  module Api
    # Emails Api client
    #
    # @see https://confluence.atlassian.com/bitbucket/teams-endpoint-423626335.html
    #   teams Endpoint
    class EmailsApi < BaseApi
      include Tinybucket::Api::Helper::EmailsHelper

      # Send 'GET the email' request
      #
      # @param name [String] The user's email
      #
      # @return [Tinybucket::Model::Email]
      def find(email, options = {})
        get_path(
          path_to_find(email),
          options,
          Tinybucket::Parser::EmailParser
        )
      end

      # Send 'GET the list of emails' request
      #
      #
      # @return [Tinybucket::Model::Page]
      def list(options = {})
        get_path(
          path_to_list,
          options,
          Tinybucket::Parser::EmailsParser
        )
      end
    end
  end
end
