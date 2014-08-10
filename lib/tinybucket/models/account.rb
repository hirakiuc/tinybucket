module Tinybucket
  module Models
    class Account < BaseModel
      attr_accessor :username, :display_name, :links
    end
  end
end
