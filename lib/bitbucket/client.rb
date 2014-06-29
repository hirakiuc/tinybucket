module Bitbucket
  class Client
    include ActiveSupport::Configurable

    def initialize(_options)
      yield(config) if block_given?
    end

    def repos(options = {})
      @repos ||= create_instance('Repos', options)
      @repos.list(options)
    end

    def repo(owner, repo_slug, options = {})
      @repo ||= create_instance('Repo', options)
      @repo.find(owner, repo_slug, options)
    end

    def teams(options = {})
      @teams ||= create_instance('Teams', options)
    end

    def users(options = {})
      @users ||= create_instance('Users', options)
    end

    private

    def create_instance(name, options)
      ApiFactory.create_instance(name, config, options)
    end
  end
end
