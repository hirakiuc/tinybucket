module Tinybucket
  module Api
    class CommitsApi < BaseApi
      include Tinybucket::Api::Helper::CommitsHelper

      attr_accessor :repo_owner, :repo_slug

      def list(options = {})
        get_path(
          path_to_list,
          options,
          Tinybucket::Parser::CommitsParser
        )
      end

      def find(revision, options = {})
        get_path(
          path_to_find(revision),
          options,
          Tinybucket::Parser::CommitParser
        )
      end
    end
  end
end
