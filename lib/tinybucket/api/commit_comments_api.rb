module Tinybucket
  module Api
    class CommitCommentsApi < BaseApi
      include Tinybucket::Api::Helper::CommitCommentsHelper

      attr_accessor :repo_owner, :repo_slug

      attr_accessor :commit

      def list(options = {})
        list = get_path(path_to_list,
                        options,
                        Tinybucket::Parser::CommitCommentsParser)

        inject_api_config(list)
      end

      def find(comment_id, options = {})
        comment = get_path(path_to_find(comment_id),
                           options,
                           Tinybucket::Parser::CommitCommentParser)

        inject_api_config(comment)
      end
    end
  end
end
