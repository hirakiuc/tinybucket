module Bitbucket
  module Response
    class ErrorHandler < Faraday::Response::Middleware
      def on_complete(env)
        status_code = env[:status].to_i

        return if status_code < 400

        Bitbucket.logger.error "Invalid response code:#{status_code}"
        fail Bitbucket::Error::ServiceError.new(env)
      end
    end
  end
end
