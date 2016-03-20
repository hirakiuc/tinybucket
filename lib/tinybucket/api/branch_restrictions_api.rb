module Tinybucket
  module Api
    class BranchRestrictionsApi < BaseApi
      include Tinybucket::Api::Helper::BranchRestrictionsHelper

      attr_accessor :repo_owner, :repo_slug

      def list(options = {})
        get_path(
          path_to_list,
          options,
          Tinybucket::Parser::BranchRestrictionsParser
        )
      end

      def find(restriction_id, options = {})
        get_path(
          path_to_find(restriction_id),
          options,
          Tinybucket::Parser::BranchRestrictionParser
        )
      end
    end
  end
end
