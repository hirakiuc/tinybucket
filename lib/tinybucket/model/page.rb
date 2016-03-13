module Tinybucket
  module Model
    class Page
      attr_reader :attrs
      attr_reader :items

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
