# frozen_string_literal: true

module Tinybucket
  module Model
    extend ActiveSupport::Autoload

    [
      :Base,
      :BranchRestriction,
      :BuildStatus,
      :Comment,
      :Commit,
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
