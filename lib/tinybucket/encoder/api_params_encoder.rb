module Tinybucket
  module Encoder
    class ApiParamsEncoder
      def self.encode(params = {})
        return nil if params.nil?
        params = sort_parameters(params)
        query_params = params.delete(:q)
        encoded_query_params = encode_query_parameters(query_params) if query_params
        params_encoded = Faraday::FlatParamsEncoder.encode(params) unless params.empty?
        [params_encoded, encoded_query_params].compact.join('&')
      end

      def self.decode(query)
        return nil if query.nil?
        decoded_params = Faraday::FlatParamsEncoder.decode(query)
        encoded_query_params = decoded_params.delete('q') || ''
        decoded_query_params = decode_query_parameters(encoded_query_params)
        decoded_params.merge(decoded_query_params).symbolize_keys
      end

      def self.sort_parameters(parameters)
        parameters.sort_by { |key, _value| key }.to_h
      end

      def self.encode_query_parameters(query_parameters)
        formatted_parameters = query_parameters.map do |key, value|
          while value.is_a?(Hash)
            next_level = value.first
            key = key.to_s + '.' + next_level.first.to_s
            value = next_level.last
          end

          encoded_value = encode_query_value(value)
          [key, encoded_value]
        end
        'q=' + Faraday::FlatParamsEncoder.encode(formatted_parameters)
      end
      private_class_method :encode_query_parameters

      def self.decode_query_parameters(encoded_parameters)
        decoded_parameters = Faraday::FlatParamsEncoder.decode(encoded_parameters)
        formatted_parameters = decoded_parameters.map do |key, value|
          multileveled_keys = key.split('.').reverse
          key = multileveled_keys.pop
          decoded_value = decode_query_value(value)
          final_value = decoded_value
          until multileveled_keys.count.zero?
            final_value = Hash[[[multileveled_keys.pop.to_sym, final_value]]]
          end

          [key, final_value]
        end
        formatted_parameters.empty? ? {} : { q: formatted_parameters.to_h.symbolize_keys }
      end
      private_class_method :decode_query_parameters

      def self.encode_query_value(value)
        if value.is_a? String
          "\"#{value}\""
        elsif value.nil?
          'null'
        else
          value
        end
      end
      private_class_method :encode_query_value

      def self.decode_query_value(value)
        case value
        when /^".*"$/
          value.gsub(/^"/, '').gsub(/"$/, '')
        when 'null'
          nil
        when nil
          true
        when 'true', 'false', true, false
          value.to_s == 'true'
        when /^[0-9]+$/
          value.to_i
        when /^[0-9]+\.[0-9]+$/
          value.to_f
        else
          begin
            Time.parse value
          rescue ArgumentError
            value
          end
        end
      end
      private_class_method :decode_query_value
    end
  end
end
