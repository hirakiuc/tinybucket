module Tinybucket
  module Parser
    extend ActiveSupport::Autoload

    [
      :AccountsParser,
      :BaseParser,
      :BranchRestrictionParser,
      :BranchRestrictionsParser,
      :CommitParser,
      :CommitsParser,
      :CommitCommentParser,
      :CommitCommentsParser,
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
