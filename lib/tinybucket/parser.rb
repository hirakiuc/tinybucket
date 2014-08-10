module Bitbucket
  module Parser
    extend ActiveSupport::Autoload

    autoload :AccountsParser
    autoload :BaseParser
    autoload :CommitsParser
    autoload :CommitParser
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
