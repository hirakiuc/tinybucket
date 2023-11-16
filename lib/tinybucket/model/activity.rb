# frozen_string_literal: true

module Tinybucket
  module Model
    # Activity Resource
    #
    # @see https://developer.atlassian.com/cloud/bitbucket/rest/api-group-pullrequests/#api-repositories-workspace-repo-slug-pullrequests-pull-request-id-activity-get
    #   Activities Resource
    #
    # @!attribute [rw] hash
    #   @return [String]
    # @!attribute [rw] links
    #   @return [Hash]
    # @!attribute [rw] repository
    #   @return [Hash]
    # @!attribute [rw] author
    #   @return [Hash]
    # @!attribute [rw] parents
    #   @return [Array]
    # @!attribute [rw] date
    #   @return [String]
    # @!attribute [rw] message
    #   @return [String]
    # @!attribute [rw] participants
    #   @return [Array]
    # @!attribute [rw] uuid
    #   @return [NillClass]
    # @!attribute [rw] type
    #   @return [String]
    class Activity < Base
      include Tinybucket::Model::Concerns::RepositoryKeys
      include Tinybucket::Constants

      class UnknownActivityError < StandardError; end

      acceptable_attributes \
        :update, :comment

      attr_accessor :activity_type

      def initialize(json)
        super(json)

        raise UnknownActivityError if update.blank? && comment.blank?

        @activity_type = if update.present?
                           :update
                         else
                           :comment
                         end
      end

      private

      def activity_api
        create_api('Activities', repo_keys)
      end

      def load_model
        activity_api.find(hash)
      end
    end
  end
end
