module Tinybucket
  module Resource
    class Emails < Tinybucket::Resource::Base
      # Find the commit
      #
      # @param email [String]
      # @param options [Hash]
      # @return [Tinybucket::Model::Email]
      def find(email, options = {})
        emails_api.find(email, options)
      end

      private
      def emails_api
        create_api('Emails')
      end

      def enumerator
        create_enumerator(emails_api, :list, {})
      end
    end
  end
end
