module Tinybucket
  module Response
    class Handler < Faraday::Response::Middleware
      def on_complete(env)
        status_code = env[:status].to_i

        return if status_code < 400

        case status_code
        when 404
          raise Tinybucket::Error::NotFound.new(env)
        when 409
          raise Tinybucket::Error::Conflict.new(env)
        else
          Tinybucket.logger.error "Invalid response code:#{status_code}"
          raise Tinybucket::Error::ServiceError.new(env)
        end
      end
    end
  end
end
