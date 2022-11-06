# frozen_string_literal: true

module Tinybucket
  module Model
    class Base
      include ::ActiveModel::Serializers::JSON
      include Concerns::AcceptableAttributes
      include Concerns::Enumerable
      include Concerns::Reloadable
      include Concerns::ApiCallable

      def self.concern_included?(concern_name)
        mod_name = "Tinybucket::Model::Concerns::#{concern_name}".constantize
        ancestors.include?(mod_name)
      end

      def initialize(json)
        self.attributes = json
        @_loaded = !json.empty?
      end

      def attributes=(hash)
        hash.each_pair do |key, value|
          if acceptable_attribute?(key)
            send("#{key}=".intern, value)
          else
            logger.warn("Ignored '#{key}' attribute (value: #{value}). [#{self.class}]")
          end
        end
      end

      def attributes
        acceptable_attributes.map do |key|
          { key => send(key.intern) }
        end.reduce(&:merge)
      end

      protected

      def logger
        Tinybucket.logger
      end
    end
  end
end
