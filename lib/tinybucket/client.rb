module Tinybucket
  class Client
    include ::Tinybucket::Model::Concerns::Enumerable

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
    # @return [Tinybucket::Enumerator] enumerator to enumerate repositories
    #   as [Tinybucket::Model::Repository]
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

    # Get the repository
    #
    # @param owner [String] repository owner name.
    # @param repo_slug [String] repository slug. (about {https://confluence.atlassian.com/bitbucket/repositories-endpoint-423626330.html#repositoriesEndpoint-Overview
    #     repo_slug})
    # @return [Tinybucket::Model::Repository]
    def repo(owner, repo_slug)
      m = Tinybucket::Model::Repository.new({})
      m.repo_owner = owner
      m.repo_slug = repo_slug
      m
    end

    # Get the team
    #
    # @param teamname [String] the team name.
    # @return [Tinybucket::Model::Team]
    def team(teamname)
      m = Tinybucket::Model::Team.new({})
      m.username = teamname
      m
    end

    # Get the user profile
    #
    # @param username [String] the user name.
    # @return [Tinybucket::Model::Profile]
    def user(username)
      m = Tinybucket::Model::Profile.new({})
      m.username = username
      m
    end

    private

    def public_repos(*args)
      options = args.empty? ? {} : args.first
      raise ArgumentError unless options.is_a?(Hash)

      enumerator(
        repos_api,
        :list,
        options
      )
    end

    def owners_repos(*args)
      owner = args.first
      options = (args.size == 2) ? args[1] : {}
      raise ArgumentError unless options.is_a?(Hash)

      enumerator(
        user_api(owner),
        :repos,
        options
      )
    end

    def repos_api
      create_instance('Repos')
    end

    def user_api(owner)
      api = create_instance('User')
      api.username = owner
      api
    end

    def create_instance(name)
      ApiFactory.create_instance(name)
    end
  end
end
