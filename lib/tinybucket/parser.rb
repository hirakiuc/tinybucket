# frozen_string_literal: true

module Tinybucket
  module Parser
    extend ActiveSupport::Autoload

    [
      :BaseParser,
      :BranchParser,
      :BranchesParser,
      :BranchRestrictionParser,
      :BranchRestrictionsParser,
      :BuildStatusParser,
      :BuildsParser,
      :CommitParser,
      :CommitsParser,
      :CommentParser,
      :CommentsParser,
      :EmailParser,
      :EmailsParser,
      :ProfileParser,
      :ProfilesParser,
      :PullRequestParser,
      :PullRequestsParser,
      :RepoParser,
      :ReposParser,
      :TeamParser,
      :TeamsParser
    ].each do |klass_name|
      autoload klass_name
    end
  end
end
