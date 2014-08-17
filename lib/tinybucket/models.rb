module Tinybucket
  module Models
    extend ActiveSupport::Autoload

    [
      :Account,
      :BaseModel,
      :BranchRestriction,
      :Commit,
      :CommitComment,
      :ErrorResponse,
      :Page,
      :Profile,
      :PullRequest,
      :Repository,
      :Team
    ].each do |klass_name|
      autoload klass_name
    end
  end
end
