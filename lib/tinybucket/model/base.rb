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

      def create_api(api_key, repo,  options)
        key = ('@' + api_key.underscore).intern
        api = instance_variable_get(key)
        return api if api.present?

        api = create_instance(api_key, options)
        api.repo_owner = repo.repo_owner
        api.repo_slug  = repo.repo_slug
        instance_variable_set(key, api)

        api
      end

      def create_instance(klass_name, options)
        ApiFactory.create_instance(klass_name, api_config, options)
      end
    end
  end
end
