module Tinybucket
  module Resource
    class Emails < Tinybucket::Resource::Base
      def emails_api
        create_api('Emails')
      end

      def enumerator
        create_enumerator(emails_api, :list, {})
      end
    end
  end
end
