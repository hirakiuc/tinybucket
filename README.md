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

NOTE: `x` mark means `Already implemented.`.

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

#### teams Endpoint

```
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

```
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

```
# [x] GET a list of all public repositories
repos = bucket.repos

# [x] GET a list of repositories owned by the account 'someone'
repos  = bucket.repos('someone')
```

##### repository Resource

```
# [x] GET a repository
repo = bucket.repo('someone', 'great_repo')

# [x] Load a repository
# (Load the repository attributes from Bitbucket WebAPI)
repo.load

# [ ] POST a new repository
    repo.create(params)

# [ ] DELETE a repository
    repo.destroy

# [x] GET a list of watchers
watchers = repo.watchers

# [x] GET a list of forks
repos = repo.forks
```

##### pullrequests Resource

```
repo = bucket.repo('someone', 'great_repo')

# [x] GET a list of open pull requests
pull_requests = repo.pull_requests(options)

# [x] GET a specific pull request
pull_request   = repo.pull_request(pr_id)

# [ ] POST (create) a new pull request
     repo.pull_request.create(params)

# [ ] PUT a pull request update
     repo.pull_request(pr_id).update(params)

# [x] GET the commits for a pull request
commits = pull_request.commits

# [x] POST a pull request approval
          pull_request.approve

# [x] DELETE a pull request approval
          pull_request.unapprove

# [x] GET the diff for a pull request
diff = pull_request.diff

# [ ] GET the log of all of a repository's pull request activity
activities = repo.pull_requests_activities(options) # TODO: fix method name.

# [ ] GET the activity for a pull request
activities = pull_request.activities(options)

# [ ] Accept and merge a pull request
             pull_request.merge(options)

# [ ] Decline or reject a pull request
             pull_request.decline(options)

# [x] GET a list of pull request comments
comments = pull_request.comments

# [x] GET an individual pull request comment
comment = pull_request.comment(comment_id)
```

##### commits or commit Resource

```
repo = bucket.repo('someone', 'great_repo')

# [x] GET a commits list for a repository or compare commits across branches
# branchortag, include, exclude options
commits = repo.commits(options)

# [x] GET an individual commit
commit = repo.commit('revision')

# [x] GET a list of commit comments
comments = commit.comments

# [x] GET an individual commit comment
comment = commit.comment(comment_id)

# [ ] POST a commit approval
  commit.approve

# [ ] DELETE a commit approval
  commit.unapprove
```

##### branch-restrictions Resource

```
repo = bucket.repo('someone', 'great_repo').find

# [x] GET the branch-restrictions
restrictions = repo.branch_restrictions

# [ ] POST the branch-restrictions
  repo.create_branch_restrictions(restrictions)

# [x] GET a specific restriction
restriction = repo.branch_restriction(restriction_id)

# [ ] PUT a branch restriction update
  restriction.update(params)

# [ ] DELETE the branch restriction
  restriction.destroy
```

##### diff Resource

```
repo = bucket.repo('someone', 'great_repo').find
COMMIT_ID = '7e968c5'

# [x] GET a diff
diff = repo.diff(COMMIT_ID)

# [x] GET a patch
patch = repo.patch(COMMIT_ID)
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
