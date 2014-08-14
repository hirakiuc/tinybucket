module Tinybucket
  module Models
    extend ActiveSupport::Autoload

    autoload :Account
    autoload :BaseModel
    autoload :Commit
    autoload :CommitComment
    autoload :ErrorResponse
    autoload :Page
    autoload :Profile
    autoload :PullRequest
    autoload :Repository
    autoload :Team
  end
end
