module Tinybucket
  module Response
    class ErrorHandler < Faraday::Response::Middleware
      def on_complete(env)
        status_code = env[:status].to_i

        return if status_code < 400

        Tinybucket.logger.error "Invalid response code:#{status_code}"
        raise Tinybucket::Error::ServiceError.new(env)
      end
    end
  end
end
