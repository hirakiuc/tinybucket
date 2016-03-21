module Tinybucket
  module Error
    extend ActiveSupport::Autoload

    autoload :BaseError
    autoload :ServiceError
    autoload :Conflict
    autoload :NotFound
  end
end
