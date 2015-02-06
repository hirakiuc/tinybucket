module Tinybucket
  module Model
    class ErrorResponse < Base
      attr_accessor :message, :fields, :detail, :id, :uuid
    end
  end
end
