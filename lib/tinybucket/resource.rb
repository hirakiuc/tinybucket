module Tinybucket
  module Resource
    extend ActiveSupport::Autoload

    [
      :Base,
      :Branches,
      :BranchRestrictions,
      :Commits,
      :Emails,
      :Forks,
      :Hooks,
      :OwnersRepos,
      :PublicRepos,
      :PullRequests,
      :Repos,
      :Watchers
    ].each do |klass_name|
      autoload klass_name
    end

    module Team
      extend ActiveSupport::Autoload

      [
        :Base,
        :Followers,
        :Following,
        :Members,
        :Repos
      ].each do |klass_name|
        autoload klass_name
      end
    end

    module User
      extend ActiveSupport::Autoload

      [
        :Base,
        :Followers,
        :Following,
        :Repos
      ].each do |klass_name|
        autoload klass_name
      end
    end

    module PullRequest
      extend ActiveSupport::Autoload

      [
        :Base,
        :Commits,
        :Comments
      ].each do |klass_name|
        autoload klass_name
      end
    end

    module Commit
      extend ActiveSupport::Autoload

      [
        :Base,
        :BuildStatuses,
        :Comments
      ].each do |klass_name|
        autoload klass_name
      end
    end
  end
end
