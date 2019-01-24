tinybucket gem
==========

A Ruby client library for Bitbucket REST API v2 with OAuth Authentication.

**WARNING** This gem is under development.

This gem is inspired by [vongrippen/bitbucket](https://github.com/vongrippen/bitbucket). Thanks.

[![Gem Version](https://badge.fury.io/rb/tinybucket.svg)](https://badge.fury.io/rb/tinybucket)
[![Build Status](https://travis-ci.org/hirakiuc/tinybucket.svg?branch=master)](https://travis-ci.org/hirakiuc/tinybucket)
[![Code Climate](https://codeclimate.com/github/hirakiuc/tinybucket/badges/gpa.svg)](https://codeclimate.com/github/hirakiuc/tinybucket)
[![Test Coverage](https://codeclimate.com/github/hirakiuc/tinybucket/badges/coverage.svg)](https://codeclimate.com/github/hirakiuc/tinybucket/coverage)
[![Inline docs](http://inch-ci.org/github/hirakiuc/tinybucket.svg?branch=master)](http://inch-ci.org/github/hirakiuc/tinybucket)

[yard doc](http://www.rubydoc.info/github/hirakiuc/tinybucket/master) (master branch)

## Installation

Add this line to your application's Gemfile:

    gem 'tinybucket'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tinybucket

## Usage

**WARNING** These specs will be changed at any time.

NOTE: `x` mark means `Already implemented.`.

### Configure

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

### Pagination

After v1.0.0, tinybucket gem support [lazy enumerator](http://ruby-doc.org/core-2.2.0/Enumerator/Lazy.html) !

This feature make your code more rubyish, like this.

```ruby
# get enumerator to enumerate repositories.
repos = bucket.repos('myname')

# Select repositories which has 2 pull requests to be reviewed.
repos = repos('my_name').select do |repo|
  repo.pull_requests.size > 2
end.map(&:full_name)
```

This enumerable feature depends on [Paging through object collections](https://developer.atlassian.com/bitbucket/api/2/reference/meta/pagination) at Bitbucket Cloud REST API.

#### NOTE: About `size` attribute

[object collections wrapper](https://developer.atlassian.com/bitbucket/api/2/reference/meta/pagination) has `size` attribute at Bitbucket Cloud REST API.

The `size` attribute describe as `optional` attribute.

In tinybucket gem, collection size depend on `side` attribute of [object collections wrapper](https://developer.atlassian.com/bitbucket/api/2/reference/meta/pagination) in Bitbucket Cloud REST API.

So enumerator's `size` attribute may return `nil`.

### init

```ruby
bucket = Tinybucket.new
```

### Endpoints

#### teams Endpoint

```ruby
# [x] GET the team profile
team = bucket.team('team name')

# [x] GET the team members
members = team.members

# [x] GET the team followers
followers = team.followers

# [x] GET a list of accounts the team is following
following = team.following

# [x] GET the team's repositories
repos = team.repos
```

#### users Endpoint

```ruby
# [x] GET the user profile
user = bucket.user('user name')

# [x] GET the list of followers
followers = user.followers

# [x] GET a list of accounts the user is following
followings = user.followings

# [x] GET the user's repositories
repos = user.repos
```

#### repositories Endpoint

```ruby
# [x] GET a list of all public repositories
repos = bucket.repos

# [x] GET a list of repositories owned by the account 'someone'
repos  = bucket.repos('someone')
```

##### repository Resource

###### Collection Methods

```ruby
repos = bucket.repos('myname')

# [x] POST (create) a new repository
repos.create(params)

# [x] GET a repository
repos.find('repo_slug', params)
```

###### Object Methods

```ruby
# [x] GET a repository
repo = bucket.repo('someone', 'great_repo')

# [x] Load a repository
# (Load the repository attributes from Bitbucket WebAPI)
repo.load

# [x] PUT (update) a repository
repo.update(params)

# [x] DELETE a repository
repo.destroy

# [x] GET a list of watchers
watchers = repo.watchers

# [x] GET a list of forks
repos = repo.forks
```

##### pullrequests Resource

###### Collection Methods

```ruby
repo = bucket.repo('someone', 'great_repo')

# [x ] GET a list of pull requests
pull_requests = repo.pull_requests(options)

# [ ] POST (create) a new pull request
pull_requests.create(params)

# [ ] GET the log of all of a repository's pull request activity
activities = pull_requests.activities(options)
```

###### Object Methods

```ruby
repo = bucket.repo('someone', 'great_repo')

# [x] GET a specific pull request
pull_request = repo.pull_request(pr_id)

# [ ] PUT a pull request update
pull_request.update(params)

# [x] GET the commits for a pull request
commits = pull_request.commits

# [x] POST a pull request approval
pull_request.approve

# [x] DELETE a pull request approval
pull_request.unapprove

# [x] GET the diff for a pull request
diff = pull_request.diff

# [ ] GET the activity for a pull request
activities = pull_request.activities(options)

# [x] Accept and merge a pull request
pull_request.merge(options)

# [x] Decline or reject a pull request
pull_request.decline(options)

# [x] GET a list of pull request comments
comments = pull_request.comments

# [x] GET an individual pull request comment
comment = pull_request.comment(comment_id)
```

##### commits or commit Resource

###### Collection Methods

```ruby
repo = bucket.repo('someone', 'great_repo')

# [x] GET a commits list for a repository or compare commits across branches
# branchortag, include, exclude options
commits = repo.commits(options)
```

###### Object Methods

```ruby
repo = bucket.repo('someone', 'great_repo')

# [x] GET an individual commit
commit = repo.commit('revision')

# [x] GET a list of commit comments
comments = commit.comments

# [x] GET an individual commit comment
comment = commit.comment(comment_id)

# [x] POST a commit approval
commit.approve

# [x] DELETE a commit approval
commit.unapprove
```

##### branches Resource

###### Collection Methods

```ruby
repo = bucket.repo('someone', 'great_repo')

# [x ] GET a list of branches
branches = repo.branches(options)
```

###### Object Methods
```ruby
repo = bucket.repo('someone', 'great_repo')

# [x] GET a specific branch
branch = repo.branch(branch_name)
```

##### branch-restrictions Resource

###### Collection Methods

```ruby
repo = bucket.repo('someone', 'great_repo')

# [x] GET the branch-restrictions
restrictions = repo.branch_restrictions

# [ ] POST the branch-restrictions
new_restriction = restrictions.create(params)
```

###### Object Methods

```ruby
repo = bucket.repo('someone', 'great_repo').find

# [x] GET a specific restriction
restriction = repo.branch_restriction(restriction_id)

# [ ] PUT a branch restriction update
restriction.update(params)

# [ ] DELETE the branch restriction
restriction.destroy
```

##### diff Resource

```ruby
repo = bucket.repo('someone', 'great_repo')
COMMIT_ID = '7e968c5'

# [x] GET a diff
diff = repo.diff(COMMIT_ID)

# [x] GET a patch
patch = repo.patch(COMMIT_ID)
```

##### statuses/build Resource

###### Collection Methods

```ruby
repo = bucket.repo('someone', 'great_repo')

COMMIT_ID = '7e968c5'
commit = repo.commit(COMMIT_ID)

BUILD_STATUS_KEY = 'tinybucket'

# [x] POST a build status for a commit
commit.build_statuses.create(
  key: BUILD_STATUS_KEY,
  state: 'INPROGRESS',
  name: 'Name of build',
  url: 'link to the build result',
  description: 'about build'
)
```

###### Object Methods

```
repo = bucket.repo('someone', 'great_repo')

COMMIT_ID = '7e968c5'
commit = repo.commit(COMMIT_ID)

BUILD_STATUS_KEY = 'tinybucket'

# [x] GET the build status for a commit
status = commit.build_status(BUILD_STATUS_KEY)

# [x] PUT a build status for a commit
status.update(
  state: 'SUCCESSFUL',
  name: 'Name of build',
  url: 'link to the build result',
  description: 'about build'
)
```

## Contribution

1. Fork it ( https://github.com/[my-github-username]/bitbucket/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

See LICENSE file.

## Author

[hirakiuc](https://github.com/hirakiuc)
