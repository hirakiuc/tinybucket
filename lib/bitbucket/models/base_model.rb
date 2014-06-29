require 'active_model'

module Bitbucket
  module Models
    class BaseModel
      include ::ActiveModel::Serializers::JSON

      def initialize(json)
        self.attributes = json
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
