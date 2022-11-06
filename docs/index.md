# Introduction

Tinybucket is a ruby wrapper library to use Bitbucket Cloud REST APIs with OAuth Authentication.

This gem is inspired by [vongrippen/bitbucket](https://github.com/vongrippen/bitbucket).

## Sample Code.

At first, I'll show you how you can use `tinybucket` gem.

```ruby
require 'rubygems'
require 'bundler/setup'

require 'tinybucket'

Tinybucket.configure do |config|
  # OAuth1 token/secret if you want to use OAuth1, not OAuth2.
  config.oauth_token = '<your oauth token>'
  config.oauth_secret = '<your oauth secret>'

  # OAuth2 access_token if you want to use OAuth2, not OAuth1.
  config.access_token = '<your oauth2 access_token>'
end

bucket = Tinybucket.new

### Iterate team repository
# Fetch a team.
team = bucket.team('our_great_team')

# A team has many repositories.
team.repos.each do |repo|
  puts "#{repo.name}"

  # Repository has branches.
  repo.branches.map(&:name).each do |name|
    puts "branch: #{name}"
  end
end

### Iterate pull requests on the user's repository.
# Fetch a user.
user = bucket.user('your_username')

# Same as a team, a user has many repositories.
# But just now, fetch a repository which owned by the user.
repo = user.repo('my_great_repo')

# A repository has many pull requests.
# This code show pull requests which has 'OPEN' state.
repo.pull_requests(state: 'OPEN')
  .map { |pr| puts "#{pr.state} - #{pr.author['username']} - #{pr.title}" }

# And show pull requests which has 'MERGED' state.
repo.pull_requests(state: 'MERGED')
  .take(10)
  .map { |pr| puts "#{pr.state} - #{pr.title} - #{pr.author}" }
```

# Features

This gem has these features.

## Configuration

- logger
- cache middleware (HTTP response cache)
- Authentication
  - OAuth1
  - OAuth2

## Pagination

After v1.0.0, tinybucket gem support [lazy enumerator](http://ruby-doc.org/core-2.2.0/Enumerator/Lazy.html) !

This feature make your code more rubyish, like this.

```ruby
# get enumerator to enumerate repositories.
repos = bucket.repos('myname')

# Select repositories which has 2 pull requests to be reviewed.
repo_names = repos('my_name').select do |repo|
  repo.pull_requests.size > 2
end.map(&:full_name)
```

This enumerable feature depends on [Paging through object collections](https://developer.atlassian.com/bitbucket/api/2/reference/meta/pagination) at Bitbucket Cloud REST API.

#### NOTE: About `size` attribute

[object collections wrapper](https://developer.atlassian.com/bitbucket/api/2/reference/meta/pagination) has `size` attribute at Bitbucket Cloud REST API.

The `size` attribute describe as `optional` attribute.

In tinybucket gem, collection size depend on `side` attribute of [object collections wrapper](https://developer.atlassian.com/bitbucket/api/2/reference/meta/pagination) in Bitbucket Cloud REST API.

So enumerator's `size` attribute may return `nil`.

## Supported APIs

`tinybucket` gem does not support all of Bitbucket Cloud REST APIs, just now.

Pull requests are welcome. :smile:

- Teams
- Users
- Repositories
- Repository
- PullRequests
- Commits
- Branches
- Branch Restrictions
- diff
- Build Status

# HowToUse

=> [HowToUse](./how_to_use.md)

# License

See LICENSE file.
