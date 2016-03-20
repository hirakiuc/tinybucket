module Tinybucket
  module Model
    # ErrorResponse
    #
    # @see https://confluence.atlassian.com/bitbucket/version-2-423626329.html#Version2-Standardizederrorresponses
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
    class ErrorResponse < Base
      acceptable_attributes :message, :fields, :detail, :id, :uuid
    end
  end
end
