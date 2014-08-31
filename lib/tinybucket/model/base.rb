module Tinybucket
  module Model
    class Base
      include ::ActiveModel::Serializers::JSON
      attr_accessor :api_config

      def self.concern_included?(concern_name)
        mod_name = "Tinybucket::Model::Concerns::#{concern_name}".constantize
        ancestors.include?(mod_name)
      end

      def initialize(json)
        self.attributes = json
        @api_config = {}
        @_loaded = !(json.empty?)
      end

      def attributes=(hash)
        hash.each { |key, value| send("#{key}=", value) }
      end

      def attributes
        instance_values.select do |key, _value|
          case key
          when /\A_.+\z/
          when 'api_config', 'repo_owner', 'repo_slug'
            false
          else
            true
          end
        end
      end

      protected

      def create_api(api_key, keys,  options)
        key = ('@' + api_key.underscore).intern
        api = instance_variable_get(key)
        return api if api.present?

        api = create_instance(api_key, options)
        api.repo_owner = keys[:repo_owner]
        api.repo_slug  = keys[:repo_slug]
        instance_variable_set(key, api)

        api
      end

      def create_instance(klass_name, options)
        ApiFactory.create_instance(klass_name, api_config, options)
      end
    end
  end
end
