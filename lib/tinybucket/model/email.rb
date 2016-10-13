module Tinybucket
  module Model
    # Profile
    #
    # @see https://developer.atlassian.com/bitbucket/api/2/reference/resource/user/emails
    #   emails Endpoint - Bitbucket Cloud REST API document
    #
    # @!attribute [rw] is_primary
    #   @return [Boolean]
    # @!attribute [rw] is_confirmed
    #   @return [Boolean]
    # @!attribute [rw] type
    #   @return [String]
    # @!attribute [rw] email
    #   @return [String]
    # @!attribute [rw] links
    #   @return [Hash]
    class Email < Base
      acceptable_attributes \
        :is_primary, :is_confirmed, :type, :email, :links

      private

      def email_api
        create_api('Emails')
      end

      def load_model
        email_api.find(email)
      end
    end
  end
end
