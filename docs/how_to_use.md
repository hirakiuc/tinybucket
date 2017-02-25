[To index](./index.md)

# HowToUse

## Install

Add this line to your application's Gemfile:

    gem 'tinybucket'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tinybucket

## Configuration

```ruby
logger = Logger.new($stdout)
logger.level = Logger::WARN

Tinybucket.configure do |config|
  # Configure logger if you want.
  #
  # optional, default: nil (no logging)
  config.logger = logger

  # Configure cache_store options if you need.
  #
  # see https://github.com/plataformatec/faraday-http-cache
  #
  # optional, default: nil (disable request cache)
  config.cache_store_options = { store: Rails.cache, logger: logger }

  # Configure access_token if you can prepare OAuth2 access_token.
  config.access_token = 'your_access_token'

  # Configure oauth_token/oauth_secret if you want to use OAuth1.0 authentication.
  # (This config will be ignored if you configure OAuth2 access_token.)
  config.oauth_token = 'key'
  config.oauth_secret = 'secret'
end
```

## init

```ruby
bucket = Tinybucket.new
```

## Get repositories.

### Get a public repository.

- Bitbucket(`tinybucket`) has many public repositories(`repos`).

```ruby
# Get public repositories.
# WARN: This code will take a while because fetching all of public repositories.
public_repos = bucket.repos

public_repos.each do |repo|
  # do some task with repo
end

# You can get a repository with owner name and repository name.
repo = bucket.repo('someone', 'great_repo')
```

### Get a repository which owned by a team.

- Bitbucket(`tinybucket`) has the team which named `your_team_name`.
- A team has many repositories(`repos`).

```ruby
team = bucket.team('your_team_name')

# Enumerate the team's repositories
team.repos.each do |repo|
  # do some task
end

# You can get a repository with repository name.
repo = team.repos('great_repo')
```

### Get a repository which owned by a user.

- Bitbucket(`tinybucket`) has the user which named `your_user_name`.

```ruby
user = bucket.user('your_user_name')

# Enumerate the user's repositories
user.repos.each do |repo|
  # do some task
end
```
## Use the repository resources.

### Watchers

- A repository(`repo`) has many watchers.

```ruby
# Enumerate watchers of the repository.
repo.watchers.each do |watcher|
  # do some task
end
```

### Forks

- A repository(`repo`) has many forks.

```ruby
repo.forks.each do |fork|
  # do some task
end
```

### Branches

- A repository(`repo`) has many branches.

```ruby
# Enumerate branches in the repository.
repo.branches.each do |branch|
  # do some task
end

# Get the branch with name.
branch = repo.branch('master')
```

### Pull Requests

- A repository(`repo`) has many pull requests.

```ruby
# Enumerate pull requests in the repository.
repo.pull_requests.each do |pr|
  # do some task
end

# Enumerate 'MERGED' state PRs in the repository.
repo.pull_requests(state: 'MERGED').each do |pr|
  # do some task
end

# Get a pull request with ID(ex: 10)
pr = repo.pull_request(10)
```

### Commits

- A repository(`repo`) has many commits.

```ruby
# Enumerate commits in the repository.
repo.commits.each do |commit|
  # do some task
end

# Get a commit in the repository.
commit = repo.commit('COMMIT_HASH')
```

### BranchRestrictions

- A repository(`repo`) has many branch-restrictions.

```ruby
# Enumerate branch restrictions in the repository.
repo.branch_restrictions.each do |restriction|
  # do some task
end

# Get a branch restriction in the repository.
restriction = repo.branch_restriction(restriction_id)
```

### Diff

- Get the diff with branch name or revision or commit Hash.

TBD.

### Patch

- Get the patch with branch name or revision or commit Hash.

TBD.
