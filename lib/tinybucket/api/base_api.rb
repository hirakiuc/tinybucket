module Tinybucket
  module Api
    class BaseApi
      include Tinybucket::Connection
      include Tinybucket::Request
    end
  end
end
