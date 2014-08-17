module Tinybucket
  module Model
    class Base
      include ::ActiveModel::Serializers::JSON
      attr_accessor :api_config

      def initialize(json)
        self.attributes = json
        @api_config = {}
      end

      def attributes=(hash)
        hash.each do |key, value|
          send("#{key}=", value)
        end
      end

      def attributes
        instance_values
      end

      protected

      def create_instance(klass_name, options)
        ApiFactory.create_instance(klass_name, api_config, options)
      end
    end
  end
end
