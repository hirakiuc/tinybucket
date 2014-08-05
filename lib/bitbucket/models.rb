module Bitbucket
  module Models
    extend ActiveSupport::Autoload

    autoload :BaseModel
    autoload :Commit
    autoload :ErrorResponse
    autoload :Page
    autoload :PullRequest
    autoload :Repository
  end
end
