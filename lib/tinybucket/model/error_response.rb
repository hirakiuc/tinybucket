module Tinybucket
  module Model
    class ErrorResponse < Base
      acceptable_attributes :message, :fields, :detail, :id, :uuid
    end
  end
end
