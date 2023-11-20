# frozen_string_literal: true

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
      :Activity,
      :Diffstat,
      :ErrorResponse,
      :Page,
      :Profile,
      :Project,
      :PullRequest,
      :Repository,
      :Tag,
      :Team
    ].each do |klass_name|
      autoload klass_name
    end
  end
end
