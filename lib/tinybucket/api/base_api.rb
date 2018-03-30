# frozen_string_literal: true

module Tinybucket
  module Api
    class Parser
      attr_reader :type, :options

      def initialize(type, model_class)
        parser_class =
          case type
          when :collection then Tinybucket::Parser::CollectionParser
          when :object     then Tinybucket::Parser::ObjectParser
          else throw "Unknown parser type: #{type}"
          end

        @type = parser_class
        @options = {model_class: model_class}
      end
    end

    class BaseApi
      include Tinybucket::Connection
      include Tinybucket::Request

      protected

      #
      # Get parser
      #
      # @param type [Symbol] :collection or :object
      # @param model_class [Tinybucket::Model::Base] SubClass of Tinybucket::Model::Base
      # @return [Hash]
      def get_parser(type, model_class)
        Tinybucket::Api::Parser.new(type, model_class)
      end

      private

      def logger
        Tinybucket.logger
      end
    end
  end
end
