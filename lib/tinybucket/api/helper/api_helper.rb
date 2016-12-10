# frozen_string_literal: true

module Tinybucket
  module Api
    module Helper
      module ApiHelper
        private

        def next_proc(method, options)
          lambda do |next_options|
            send(method, options.merge(next_options))
          end
        end

        def urlencode(v, key)
          if v.blank? || (escaped = CGI.escape(v.to_s)).blank?
            msg = "Invalid #{key} parameter. (#{v})"
            raise ArgumentError, msg
          end

          escaped
        end

        def build_path(base_path, *components)
          components.reduce(base_path) do |path, component|
            part = if component.is_a?(Array)
                     urlencode(*component)
                   else
                     component.to_s
                   end
            path + '/' + part
          end
        rescue ArgumentError => e
          raise ArgumentError, "Failed to build request URL: #{e}"
        end
      end
    end
  end
end
