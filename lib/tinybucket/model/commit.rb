module Tinybucket
  module Model
    class Commit < Base
      attr_accessor \
        :hash, :links, :repository, :author, :parents, :date,
        :message, :participants

      attr_accessor :repository

      def comments(options = {})
        comments_api(options).list(options)
      end

      def comment(comment_id, options = {})
        comments_api(options).find(comment_id, options)
      end

      private

      def comments_api(options)
        fail ArgumentError, 'This method call require repository.' \
          if repository.nil?

        api = create_api('CommitComments', repository, options)
        api.commit = self
        api
      end
    end
  end
end
