module Bitbucket
  module Parser
    extend ActiveSupport::Autoload

    autoload :BaseParser
    autoload :PullRequestParser
    autoload :PullRequestsParser
    autoload :RepoParser
    autoload :ReposParser
  end
end
