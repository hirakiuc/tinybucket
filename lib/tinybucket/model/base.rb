module Tinybucket
  module Model
    class Base
      include ::ActiveModel::Serializers::JSON
      attr_accessor :api_config

      def initialize(json)
        self.attributes = json
        @api_config = {}
      end

      def attributes=(hash)
        hash.each do |key, value|
          send("#{key}=", value)
        end
      end

      def attributes
        instance_values
      end

      protected

      def pull_requests_api(owner_, slug_, options)
        return @pull_requests if @pull_requests

        @pull_requests = create_instance 'PullRequests', options
        @pull_requests.repo_owner = owner_
        @pull_requests.repo_slug = slug_
        @pull_requests
      end

      def repo_api(owner_, slug_, options)
        return @repo if @repo

        @repo = create_instance 'Repo', options
        @repo.repo_owner = owner_
        @repo.repo_slug = slug_
        @repo
      end

      def commits_api(owner_, slug_, options)
        return @commits if @commits

        @commits = create_instance 'Commits', options
        @commits.repo_owner = owner_
        @commits.repo_slug = slug_
        @commits
      end

      def restrictions_api(owner_, slug_, options)
        return @restrictions if @restrictions

        @restrictions = create_instance 'BranchRestrictions', options
        @restrictions.repo_owner = owner_
        @restrictions.repo_slug = slug_
        @restrictions
      end

      def diff_api(owner_, slug_, options)
        return @diff if @diff

        @diff = create_instance 'Diff', options
        @diff.repo_owner = owner_
        @diff.repo_slug = slug_
        @diff
      end

      def create_instance(klass_name, options)
        ApiFactory.create_instance(klass_name, api_config, options)
      end
    end
  end
end
