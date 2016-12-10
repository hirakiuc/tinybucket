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
    # @return [Tinybucket::Resource::Repos] repository resource
    def repos(*args)
      case args.size
      when 0
        public_repos
      when 1
        case args.first
        when Hash           then public_repos(args.first)
        when String, Symbol then owners_repos(args.first)
        else                     raise ArgumentError
        end
      when 2
        case args.first
        when String, Symbol then owners_repos(args[0], args[1])
        else                     raise ArgumentError
        end
      else
        raise ArgumentError
      end
    end

    # Get the repository
    #
    # @param owner [String] repository owner name.
    # @param repo_slug [String] repository slug. (about {https://developer.atlassian.com/bitbucket/api/2/reference/resource/repositories/%7Busername%7D/%7Brepo_slug%7D
    # @return [Tinybucket::Model::Repository]
    def repo(owner, repo_slug)
      Tinybucket::Model::Repository.new({}).tap do |m|
        m.repo_owner = owner
        m.repo_slug = repo_slug
      end
    end

    # Get the team
    #
    # @param teamname [String] the team name.
    # @return [Tinybucket::Model::Team]
    def team(teamname)
      Tinybucket::Model::Team.new({}).tap do |m|
        m.username = teamname
      end
    end

    # Get the user profile
    #
    # @param username [String] the user name.
    # @return [Tinybucket::Model::Profile]
    def user(username)
      Tinybucket::Model::Profile.new({}).tap do |m|
        m.username = username
      end
    end

    private

    # Get public repositories
    #
    # @param options [Hash]
    # @return [Tinybucket::Resource::Repos]
    def public_repos(options = {})
      raise ArgumentError unless options.is_a?(Hash)

      Tinybucket::Resource::Repos.new(nil, options)
    end

    # Get Owner's repositories
    #
    # @param owner [String]
    # @param options [Hash]
    # @return [Tinybucket::Resource::Repos]
    def owners_repos(owner, options = {})
      raise ArgumentError unless options.is_a?(Hash)

      Tinybucket::Resource::Repos.new(owner, options)
    end
  end
end
