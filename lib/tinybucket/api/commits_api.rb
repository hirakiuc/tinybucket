module Tinybucket
  module Api
    class CommitsApi < BaseApi
      include Tinybucket::Api::Helper::CommitsHelper

      attr_accessor :repo_owner, :repo_slug

      def list(options = {})
        list = get_path(path_to_list,
                        options,
                        Tinybucket::Parser::CommitsParser)

        list.next_proc = next_proc(:list, options)
        inject_api_config(list)
      end

      def find(revision, options = {})
        m = get_path(path_to_find(revision),
                     options,
                     Tinybucket::Parser::CommitParser)

        inject_api_config(m)
      end
    end
  end
end
