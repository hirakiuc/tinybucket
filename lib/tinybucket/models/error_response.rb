module Tinybucket
  module Models
    class ErrorResponse < BaseModel
      attr_accessor :message, :fields, :detail, :id
    end
  end
end
