module Bitbucket
  module Models
    extend ActiveSupport::Autoload

    autoload :Account
    autoload :BaseModel
    autoload :Commit
    autoload :ErrorResponse
    autoload :Page
    autoload :PullRequest
    autoload :Repository
  end
end
