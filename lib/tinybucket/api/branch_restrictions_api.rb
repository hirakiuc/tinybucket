module Tinybucket
  module Api
    class BranchRestrictionsApi < BaseApi
      include Tinybucket::Api::Helper::BranchRestrictionsHelper

      attr_accessor :repo_owner, :repo_slug

      def list(options = {})
        list = get_path(path_to_list,
                        options,
                        Tinybucket::Parser::BranchRestrictionsParser)

        list.next_proc = next_proc(:list, options)
        inject_api_config(list)
      end

      def find(restriction_id, options = {})
        m = get_path(path_to_find(restriction_id),
                     options,
                     Tinybucket::Parser::BranchRestrictionParser)

        inject_api_config(m)
      end
    end
  end
end
