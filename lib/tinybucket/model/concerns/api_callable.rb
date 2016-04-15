module Tinybucket
  module Model
    module Concerns
      module ApiCallable
        protected

        def create_api(name, keys = {})
          api = ApiFactory.create_instance(name)
          return api if keys.empty?

          api.tap do |m|
            m.repo_owner = keys[:repo_owner]
            m.repo_slug  = keys[:repo_slug]
          end
        end
      end
    end
  end
end
