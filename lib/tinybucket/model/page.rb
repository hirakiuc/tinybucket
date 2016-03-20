module Tinybucket
  module Model
    # Page
    #
    # @see https://confluence.atlassian.com/bitbucket/version-2-423626329.html#Version2-Pagingthroughobjectcollections
    #   Paging through object collections - Bitbucket Cloud REST API document
    #
    # @!attribute [r] attrs
    #   This attribute is a Hash object which contains
    #   'size', 'page', 'pagelen', 'next', 'previous' key/value pairs.
    #   @return [Hash]
    # @!attribute [r] items
    #   This attribute is a array of model instance created with
    #   'values' attribute in json.
    class Page
      attr_reader :attrs
      attr_reader :items

      # Initialize with json and Model class.
      #
      # @param json [Hash]
      # @param item_klass [Class]
      def initialize(json, item_klass)
        @attrs = parse_attrs(json)
        @items = parse_values(json, item_klass)
      end

      private

      def parse_attrs(json)
        %w(size page pagelen next previous).map do |attr|
          { attr.to_sym => json[attr] }
        end.reduce(&:merge)
      end

      def parse_values(json, item_klass)
        return [] if json['values'].nil? || !json['values'].is_a?(Array)

        json['values'].map { |hash| item_klass.new(hash) }
      end
    end
  end
end
