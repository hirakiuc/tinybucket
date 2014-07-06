module Bitbucket
  module Models
    class BaseModel
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
    end
  end
end
