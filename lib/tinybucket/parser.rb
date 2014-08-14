module Tinybucket
  module Parser
    extend ActiveSupport::Autoload

    autoload :AccountsParser
    autoload :BaseParser
    autoload :CommitParser
    autoload :CommitsParser
    autoload :CommitCommentParser
    autoload :CommitCommentsParser
    autoload :ProfileParser
    autoload :ProfilesParser
    autoload :PullRequestParser
    autoload :PullRequestsParser
    autoload :RepoParser
    autoload :ReposParser
    autoload :TeamParser
    autoload :TeamsParser
  end
end
