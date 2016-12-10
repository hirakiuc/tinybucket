module Tinybucket
  module Model
    extend ActiveSupport::Autoload

    [
      :Base,
      :Branch,
      :BranchRestriction,
      :BuildStatus,
      :Comment,
      :Commit,
      :Email,
      :ErrorResponse,
      :Hook,
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
