# Bitbucket

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'bitbucket'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bitbucket

## Usage

TODO: Write usage instructions here

### init

```
bucket = Bitbucket.new(options)
```

```
bucket = Bitbucket.new do |config|
  config.oauth_key    = 'key'
  config.oauth_secret = 'secret'
end
```

#### repositories Endpoint

```
# GET a list of repositories for an account
my_repos  = bucket.repos(owner: :self)

# GET a list of all public repositories
repos = bucket.repos
```

repos is an array contains Bitbucket::Repository object.

```
Bitbucket::Repository
   RepoApi
      => repository resource
      => pullrequests resource
      => commits or commit resource
      => branch-restrictions resource
      => diff resource
```

##### repository Resource

bucket.repo(owner: 'self', repo_slug: 'slug') で RepoApi が返ってくる感じ

repo (Repository Model) には RepoApi , repository attributes が含まれる感じ

```
# GET a repository
repo = bucket.repo(owner: 'self', repo_slug: 'slug')

# POST a new repository
repo = bucket.repo(owner: 'self', repo_slug: 'slug').create(options)

# DELETE a repository
           bucket.repo(owner: 'self', repo_slug: 'slug').delete

# GET a list of watchers
watchers = bucket.repo(owner: 'self', repo_slug: 'slug').watchers

# GET a list of forks
repos = bucket.repo(owner: 'self', repo_slug: 'slug').forks
```

##### pullrequests Resource

bucket.pull_requests(owner: 'self', repo_slug: 'slug') で PullRequestsApi が返ってくる感じ

bucket.repo(owner: 'self', repo_slug: 'slug').pull_requests で PullRequestsApi が返ってくる感じ
  all で PullRequest modelsのarrayが返る

PullRequest が attributes と PullRequestApi を保持
  親にあたるrepoへの参照も保持

```
repo = bucket.repo(owner: 'self', repo_slug: 'slug')

# GET a list of open pull requests
pull_requests = repo.pull_requests(options).all

# POST (create) a new pull request
                         repo.pull_request(options).create

# PUT a pull request update
                         repo.pull_request(id: pr_id).update(options)

# GET a specific pull request
pull_request   = repo.pull_request(id: pr_id)

# GET the commits for a pull request
commits = repo.pull_request(id: pr_id).commits

# POST a pull request approval
                 repo.pull_request(id: pr_id).approve
                 
# DELETE a pull request approval
                 repo.pull_request(id: pr_id).unapprove

# GET the diff for a pull request
diff = repo.pull_request(id: pr_id).diff

# GET the log of all of a repository's pull request activity
activities = repo.pull_requests.activities(options)

# GET the activity for a pull request
activities = repo.pull_request(id: pr_id).activities(options)

# Accept and merge a pull request
                  repo.pull_request(id: pr_id).merge(options)

# Decline or reject a pull request
                  repo.pull_request(id: pr_id).decline(options)

# GET a list of pull request comments
comments = repo.pull_request(id: pr_id).comments

# GET an individual pull request comment
comment = repo.pull_request(id: pr_id).comment(id: comment_id)
```

##### commits or commit Resource

```
pending
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
# GET the team profile
profile = bucket.team('team name', options).profile

# GET the team members
members = bucket.team('team name', options).members

# GET the team followers
followers = bucket.team('team name', options).followers

# GET the team's repositories
repos = bucket.team('team name', options).repos
```

#### users Endpoint

```
# GET the user profile
profile = bucket.user('user name').profile

# GET the list of followers
followers = bucket.user('user name').followers

# GET a list of accounts the user is following
followings = bucket.user('user name').followings

# GET the user's repositories
repos = bucket.user('user name').repos
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/bitbucket/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request