module Tinybucket
  class ApiFactory
    class << self
      def create_instance(klass_name, config, options)
        options.symbolize_keys!

        klass =
          begin
            name = "#{klass_name}Api".intern
            Tinybucket::Api.const_get name
          rescue => e
            # TODO: log exception
            Tinybucket.logger.error e
            raise ArgumentError, 'must provide klass to be instantiated'
          end

        klass.new config, options
      end
    end
  end
end
