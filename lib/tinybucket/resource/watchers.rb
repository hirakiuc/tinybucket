module Tinybucket
  module Resource
    class Watchers < Base
      def initialize(repo, options)
        @repo = repo
        @args = [options]
      end

      private

      def repo_api
        create_api('Repo', @repo.repo_keys)
      end

      def enumerator
        create_enumerator(repo_api, :watchers, *@args) do |m|
          inject_repo_keys(m, @repo.repo_keys)
        end
      end
    end
  end
end
