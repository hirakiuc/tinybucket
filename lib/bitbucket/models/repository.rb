module Bitbucket
  module Models
    class Repository < BaseModel
      attr_accessor \
        :scm, :has_wiki, :description, :links, :updated_on,
        :fork_policy, :created_on, :owner, :size, :parent, :has_issues,
        :is_private, :full_name, :name, :language

      def pull_requests(options = {})
        @pull_requests ||= create_instance 'PullRequests', options

        list = @pull_requests.list(repo_owner, repo_slug, options)
        list.each { |pr| pr.repository = self }

        list
      end

      private

      def create_instance(klass_name, options)
        ApiFactory.create_instance(klass_name, api_config, options)
      end

      def repo_owner
        case owner
        when Hash
          owner.key?('username') ? owner['username'] : nil
        when String
          owner
        else
          nil
        end
      end

      def repo_slug
        return nil if full_name.blank?

        # full_name seems to be constructed with owner/repo_slug
        keys = full_name.split('/')
        return nil if keys.size < 2
        keys[1]
      end
    end
  end
end
