# frozen_string_literal: true

module Tinybucket
  module Model
    # Diffstat Resource
    #
    # @see https://developer.atlassian.com/cloud/bitbucket/rest/api-group-pullrequests/#api-repositories-workspace-repo-slug-pullrequests-pull-request-id-diffstat-get
    #   Diffstat Resource
    #
    # @!attribute [r] type
    #   @return [Symbol] type
    # @!attribute [rw] lines_added
    #   @return [Fixnum]
    # @!attribute [rw] lines_removed
    #   @return [Fixnum]
    # @!attribute [rw] status
    #   @return [String]
    # @!attribute [rw] old
    #   @return [Hash]
    # @!attribute [rw] new
    #   @return [Hash]
    class Diffstat < Base
      include Tinybucket::Model::Concerns::RepositoryKeys
      include Tinybucket::Constants

      acceptable_attributes \
        :type, :lines_added, :lines_removed, :status, :old, :new

      private

      def diffstat_api
        create_api('Diffstats', repo_keys)
      end

      def load_model
        diffstat_api.find(hash)
      end
    end
  end
end
