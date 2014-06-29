require 'bitbucket/parser/repos_parser'

module Bitbucket
  module Api
    class ReposApi < BaseApi
      def list(options = {})
        path  = '/repositories'
        path += '/' + options[:owner] if options[:owner].present?

        opts = options.clone
        opts.delete(:owner)

        get_path(
          path,
          opts,
          Bitbucket::Parser::ReposParser
        )
      end
    end
  end
end
