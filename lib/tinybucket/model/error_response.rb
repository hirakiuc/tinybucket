# frozen_string_literal: true

module Tinybucket
  module Model
    # ErrorResponse
    #
    # @see https://developer.atlassian.com/bitbucket/api/2/reference/meta/uri-uuid#stand-error
    #   Standardized error responses - Bitbucket Cloud REST API document
    #
    # @!attribute [rw] message
    #   @return [String]
    # @!attribute [rw] fields
    #   @return [Hash]
    # @!attribute [rw] detail
    #   @return [String]
    # @!attribute [rw] id
    #   @return [String]
    # @!attribute [rw] uuid
    #   @return [NillClass]
    class ErrorResponse
      acceptable_attributes :message, :fields, :detail, :id, :uuid
    end
  end
end
