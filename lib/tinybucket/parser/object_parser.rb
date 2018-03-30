# frozen_string_literal: true

module Tinybucket
  module Parser
    class ObjectParser < FaradayMiddleware::ResponseMiddleware
      define_parser do |hash, parser_options|
        cls = parser_options[:model_class]
        throw 'model_class option does not provided' unless cls
        cls.new(hash)
      end
    end
  end
end
