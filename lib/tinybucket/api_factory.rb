# frozen_string_literal: true

module Tinybucket
  class ApiFactory
    class << self
      def create_instance(klass_name)
        klass =
          begin
            name = "#{klass_name}Api".intern
            Tinybucket::Api.const_get name
          rescue => e
            # TODO: log exception
            Tinybucket.logger.error e
            raise ArgumentError, 'must provide klass to be instantiated'
          end

        klass.new
      end
    end
  end
end
