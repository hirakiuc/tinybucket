module Tinybucket
  class Client
    include ActiveSupport::Configurable

    def initialize(options = {})
      options.each_pair do |key, value|
        config.send("#{key}=", value)
      end

      yield(config) if block_given?
    end

    # Get Repositories
    #
    # when you want to get repositories of the owner, call with owner, options.
    # ex) repos('owner', options) or repos('owner')
    #
    # when you want to get public repositories of the owner, call with options.
    # ex) repos(options) or repos
    #
    # @overload repos(owner, options)
    #   get the repositories of the owner.
    #   @param  owner   [String, Symbol] string or symbol to describe the owner.
    #   @option options [Hash] a hash with options
    # @overload repos(options)
    #   get public repositories.
    #   @option options [Hash] a hash with options
    # @return Tinybucket::Model::Page model instance.
    def repos(*args)
      case args.size
      when 0
        public_repos(*args)
      when 1
        case args.first
        when Hash
          public_repos(*args)
        when String, Symbol
          owners_repos(*args)
        else
          raise ArgumentError
        end
      when 2
        owners_repos(*args)
      else
        raise ArgumentError
      end
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

    def public_repos(*args)
      options = args.empty? ? {} : args.first
      raise ArgumentError unless options.is_a?(Hash)

      @repos ||= create_instance('Repos', options)
      @repos.list(options)
    end

    def owners_repos(*args)
      owner = args.first
      options = (args.size == 2) ? args[1] : {}
      raise ArgumentError unless options.is_a?(Hash)

      @user ||= create_instance('User', options)
      @user.username = owner
      @user.repos(options)
    end

    def create_instance(name, options)
      ApiFactory.create_instance(name, config, options)
    end
  end
end
