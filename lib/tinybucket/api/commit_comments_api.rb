module Tinybucket
  module Api
    class CommitCommentsApi < BaseApi
      include Tinybucket::Api::Helper::CommitCommentsHelper

      attr_accessor :repo_owner, :repo_slug

      attr_accessor :commit

      def list(options = {})
        list = get_path(path_to_list,
                        options,
                        Tinybucket::Parser::CommentsParser)

        list.next_proc = next_proc(:list, options)

        associate_with_commit(list)
        inject_api_config(list)
      end

      def find(comment_id, options = {})
        comment = get_path(path_to_find(comment_id),
                           options,
                           Tinybucket::Parser::CommentParser)

        associate_with_commit(comment)
        inject_api_config(comment)
      end

      private

      def associate_with_commit(result)
        case result
        when Tinybucket::Model::Comment
          result.commented_to = commit
        when Tinybucket::Model::Page
          result.items.map { |m| m.commented_to = commit }
        else
          fail ArgumentError, "Invalid result: #{result.inspect}"
        end

        result
      end
    end
  end
end
