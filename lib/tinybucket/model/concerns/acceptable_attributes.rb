module Tinybucket
  module Model
    module Concerns
      module AcceptableAttributes
        extend ActiveSupport::Concern

        included do
          def self.acceptable_attributes(*attrs)
            @_acceptable_attributes = attrs.map(&:intern)

            attr_accessor(*attrs)
          end

          def self.acceptable_attribute?(key)
            return false if @_acceptable_attributes.nil?
            @_acceptable_attributes.include?(key.intern)
          end

          protected

          def acceptable_attribute?(key)
            self.class.acceptable_attribute?(key)
          end

          def acceptable_attributes
            self.class.instance_variable_get(:@_acceptable_attributes) || []
          end
        end
      end
    end
  end
end
