module Tinybucket
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

    def repo(owner, repo_slug)
      m = Tinybucket::Model::Repository.new({})
      m.repo_owner = owner
      m.repo_slug = repo_slug
      m.api_config = config.dup
      m
    end

    def team(teamname)
      m = Tinybucket::Model::Team.new({})
      m.username = teamname
      m.api_config = config.dup
      m
    end

    def user(username)
      m = Tinybucket::Model::Profile.new({})
      m.username = username
      m.api_config = config.dup
      m
    end

    private

    def create_instance(name, options)
      ApiFactory.create_instance(name, config, options)
    end
  end
end
