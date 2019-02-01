module Tinybucket
  module Encoder
    class ApiParamsEncoder
      include Faraday::FlatParamsEncoder

      def self.encode(params = {})
        return nil if params.nil?
        unless params.respond_to?(:to_hash)
          raise TypeError,
                "Can't convert #{params.class} into Hash."
        end

        encoded_params = sort_params(params).map do |key, value|
          encode_param(key, value)
        end.join('&')

        encoded_params.empty? ? '' : 'q=' + encoded_params
      end

      def self.decode(query)
        return nil if query.nil?
        query = query.gsub(/^q=/, '')

        splitted_query = (query.split('&').map do |pair|
          pair.split('=', 2) if pair && !pair.empty?
        end).compact

        params_array = splitted_query.map do |encoded_key, encoded_value|
          decode_param(encoded_key, encoded_value)
        end

        Hash[params_array]
      end

      def self.decode_param(encoded_key, encoded_value)
        decoded_value = decode_value(encoded_value)

        # Build the Hash structure in case it exists
        multileveled_keys = encoded_key.split('.').reverse
        key = multileveled_keys.pop
        final_value = decoded_value
        until multileveled_keys.count.zero?
          final_value = Hash[[[multileveled_keys.pop.to_sym, final_value]]]
        end

        [key.to_sym, final_value]
      end

      def self.encode_param(key, value)
        # Objects to nested params
        while value.is_a? Hash
          next_level = value.first
          key = key.to_s + '.' + next_level.first.to_s
          value = next_level.last
        end

        # Encode the value to the format the API is expecting
        encoded_value = encode_value(value)

        "#{key}=#{encoded_value}"
      end

      def self.sort_params(params)
        params.sort_by { |key, _value| key }
      end
      private_class_method :sort_params

      def self.encode_value(value)
        if value.is_a? String
          "\"#{value}\""
        elsif  value.nil?
          'null'
        else
          value.to_s
        end
      end
      private_class_method :encode_value

      def self.decode_value(encoded_value)
        case encoded_value
        when /^".*"$/
          encoded_value.delete('"')
        when nil
          true
        when 'true' || 'false'
          encoded_value == 'true'
        when 'null'
          nil
        else
          begin
            Time.parse encoded_value
          rescue ArgumentError
            # Numeric
            encoded_value.to_f
          end
        end
      end
      private_class_method :decode_value
    end
  end
end
