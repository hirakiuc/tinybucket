module Bitbucket
  module Response
    class ErrorHandler < Faraday::Response::Middleware
      def on_complete(env)
        status_code = env[:status].to_i
        fail Bitbucket::Error::ServiceError.new(env) if status_code >= 400
      end
    end
  end
end
