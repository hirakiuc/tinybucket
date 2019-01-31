module Tinybucket
  module Encoder
    class ApiParamsEncoder
      include Faraday::FlatParamsEncoder

      def self.encode(params = {})
        return nil if params.nil?

        unless params.is_a?(Array)
          unless params.respond_to?(:to_hash)
            raise TypeError,
                  "Can't convert #{params.class} into Hash."
          end
          params = params.to_hash
          params = params.map do |key, value|
            key = key.to_s if key.is_a?(Symbol)
            [key, value]
          end
          # Useful default for OAuth and caching.
          # Only to be used for non-Array inputs. Arrays should preserve order.
          params.sort!
        end

        encoded_params = params.map do |key, value|
          # Objects to nested params
          while value.is_a? Hash do
            next_level = value.first
            key = key.to_s + '.' + next_level.first.to_s
            value = next_level.last
          end
           
          # Encode the value to the format the API is expecting
          encoded_value = if value.is_a? String
                            "\"#{value}\""
                          elsif  value.nil?
                            "null"
                          else
                            value.to_s
                          end

          "#{key}=#{encoded_value}"
        end.join('&')

        encoded_params.empty? ? '' : 'q=' + encoded_params
      end

      def self.decode(query)
        return nil if query.nil?
        query = query.gsub(/^q=/, '')

        splitted_query = (query.split('&').map do |pair|
          pair.split('=', 2) if pair && !pair.empty?
        end).compact

        params_array = splitted_query.map do |key, value|
          decoded_value =
            if value.nil? # Hidden boolean
              true
            elsif value.start_with? '"' and value.end_with? '"' # String
              value.delete('"')
            elsif %w[true false].include? value # Not hidden boolean
              value == 'true'
            elsif value == 'null'
              value = nil
            else 
              begin # DateTime
                DateTime.parse value
              rescue ArgumentError # Number
                value.to_f
              end
            end

          # Build the Hash structure in case it exists
          multileveled_keys = key.split('.').reverse
          key = multileveled_keys.pop
          final_value = decoded_value
          while not multileveled_keys.count.zero? do
            final_value = Hash[[[multileveled_keys.pop.to_sym, final_value]]]
          end
          
          [key.to_sym, final_value]
        end

        Hash[params_array]
      end
    end
  end
end
