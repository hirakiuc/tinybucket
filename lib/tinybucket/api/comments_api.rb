module Tinybucket
  module Api
    class CommentsApi < BaseApi
      include Tinybucket::Api::Helper::CommentsHelper

      attr_accessor :repo_owner, :repo_slug

      attr_accessor :commented_to

      def list(options = {})
        list = get_path(path_to_list,
                        options,
                        Tinybucket::Parser::CommentsParser)

        associate_with_target(list)
        list
      end

      def find(comment_id, options = {})
        comment = get_path(path_to_find(comment_id),
                           options,
                           Tinybucket::Parser::CommentParser)

        associate_with_target(comment)
        comment
      end

      private

      def associate_with_target(result)
        case result
        when Tinybucket::Model::Comment
          result.commented_to = commented_to
        when Tinybucket::Model::Page
          result.items.map { |m| m.commented_to = commented_to }
        else
          raise ArgumentError, "Invalid result: #{result.inspect}"
        end

        result
      end
    end
  end
end
