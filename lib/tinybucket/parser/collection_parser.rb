# frozen_string_literal: true

module Tinybucket
  module Parser
    class CollectionParser < FaradayMiddleware::ResponseMiddleware
      define_parser do |hash, parser_options|
        cls = parser_options[:model_class]
        throw 'model_class option does not provided' unless cls
        ::Tinybucket::Model::Page.new(hash, cls)
      end
    end
  end
end
