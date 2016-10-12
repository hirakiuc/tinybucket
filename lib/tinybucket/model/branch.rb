module Tinybucket
  module Model
    # Comment
    #
    # @see https://confluence.atlassian.com/bitbucket/pullrequests-resource-423626332.html#pullrequestsResource-GETalistofapullrequestcomments
    #   Comment resource - Bitbucket Cloud REST API document
    #
    # @!attribute [rw] links
    #   @return [Hash]
    # @!attribute [rw] type
    #   @return [String]
    # @!attribute [rw] name
    #   @return [String]
    # @!attribute [rw] repository
    #   @return [Hash]
    # @!attribute [rw] target
    #   @return [Hash]
    class Branch < Base
      include Tinybucket::Model::Concerns::RepositoryKeys

      acceptable_attributes :links, :type, :name, :repository, :target

      private

      def branches_api
        create_api('Branches', repo_keys)
      end

      def pull_request_api
        create_api('PullRequests', repo_keys)
      end

      def load_model
        branches_api.find(name, {})
      end
    end
  end
end
