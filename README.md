tinybucket gem
==========

A Ruby client library for Bitbucket REST API v2 with OAuth Authentication.

**WARNING** This gem is under development.

This gem is inspired by [vongrippen/bitbucket](https://github.com/vongrippen/bitbucket). Thanks.

[![GitHub version](https://badge.fury.io/gh/hirakiuc%2Ftinybucket.png)](http://badge.fury.io/gh/hirakiuc%2Ftinybucket)
[![Build Status](https://travis-ci.org/hirakiuc/tinybucket.svg?branch=master)](https://travis-ci.org/hirakiuc/tinybucket)
[![Code Climate](https://codeclimate.com/github/hirakiuc/tinybucket/badges/gpa.svg)](https://codeclimate.com/github/hirakiuc/tinybucket)
[![Coverage Status](https://coveralls.io/repos/hirakiuc/tinybucket/badge.png?branch=master)](https://coveralls.io/r/hirakiuc/tinybucket?branch=master)

## Installation

Add this line to your application's Gemfile:

    gem 'tinybucket'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bitbucket

## Usage

**WARNING** These specs will be changed at any time.

### init

```
bucket = Tinybucket.new(oauth_key: 'key', oauth_secret: 'secret')
```

```
bucket = Tinybucket.new do |config|
  config.oauth_key    = 'key'
  config.oauth_secret = 'secret'
end
```

#### repositories Endpoint

```
# [x] GET a list of all public repositories
repos = bucket.repos

# [x] GET a list of repositories for an account
repos  = bucket.repos(owner: 'someone')
```

##### repository Resource

```
# [x] GET a repository
repo = bucket.repo('someone', 'great_repo').find

# [ ] POST a new repository
repo = bucket.repo('someone', 'great_repo').create(params)

# [ ] DELETE a repository
       bucket.repo('someone', 'great_repo').destroy

# [x] GET a list of watchers
watchers = bucket.repo('someone', 'great_repo').watchers

# [x] GET a list of forks
repos = bucket.repo('someone', 'great_repo').forks
```

##### pullrequests Resource

```
repo = bucket.repo('someone', 'great_repo')

# [x] GET a list of open pull requests
pull_requests = repo.pull_requests(options)

# [ ] POST (create) a new pull request
                repo.pull_request(params).create

# [ ] PUT a pull request update
                repo.pull_request(pr_id).update(params)

# [x] GET a specific pull request
pull_request   = repo.pull_request(pr_id).find

# [x] GET the commits for a pull request
commits = repo.pull_request(pr_id).commits

# [ ] POST a pull request approval
                 repo.pull_request(pr_id).approve

# [ ] DELETE a pull request approval
                 repo.pull_request(pr_id).unapprove

# [ ] GET the diff for a pull request
diff = repo.pull_request(pr_id).diff

# [ ] GET the log of all of a repository's pull request activity
activities = repo.pull_requests_activities(options) # TODO: fix method name.

# [ ] GET the activity for a pull request
activities = repo.pull_request(pr_id).activities(options)

# [ ] Accept and merge a pull request
             repo.pull_request(pr_id).merge(options)

# [ ] Decline or reject a pull request
             repo.pull_request(pr_id).decline(options)

# [ ] GET a list of pull request comments
comments = repo.pull_request(pr_id).comments

# [ ] GET an individual pull request comment
comment = repo.pull_request(pr_id).comment(comment_id)
```

##### commits or commit Resource

```
repo = bucket.repo('someone', 'great_repo')

# GET a commits list for a repository or compare commits across branches
# branchortag, include, exclude options
commits = repo.commits(options)

# GET an individual commit
commit = repo.commit('revision').find

# GET a list of commit comments
comments = repo.commit('revision').comments

# GET an individual commit comment
comment = repo.commit('revision').comment(comment_id)

# POST a commit approval
  repo.commit('revision').approve

# DELETE a commit approval
  repo.commit('revision').unapprove
```

##### branch-restrictions Resource

```
pending
```

##### diff Resource

```
pending
```

#### teams Endpoint

```
# [x] GET the team profile
profile = bucket.team('team name').profile

# [x] GET the team members
members = bucket.team('team name').members

# [x] GET the team followers
followers = bucket.team('team name').followers

# [x] GET a list of accounts the team is following
following = bucket.team('team name').following

# [x] GET the team's repositories
repos = bucket.team('team name').repos
```

#### users Endpoint

```
# [x] GET the user profile
profile = bucket.user('user name').profile

# [x] GET the list of followers
followers = bucket.user('user name').followers

# [x] GET a list of accounts the user is following
followings = bucket.user('user name').followings

# [x] GET the user's repositories
repos = bucket.user('user name').repos
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
