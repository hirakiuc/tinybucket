module Bitbucket
  class Client
    include ActiveSupport::Configurable

    def initialize(options = {})
      options.each_pair do |key, value|
        config.send("#{key}=", value)
      end

      yield(config) if block_given?
    end

    def repos(options = {})
      @repos ||= create_instance('Repos', options)
      @repos.list(options)
    end

    def repo(owner, repo_slug, options = {})
      @repo ||= create_instance('Repo', options)

      @repo.repo_owner = owner
      @repo.repo_slug  = repo_slug

      @repo
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
