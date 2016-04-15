module Tinybucket
  module Resource
    module User
      class Followers < Tinybucket::Resource::User::Base
        private

        def enumerator
          create_user_enumerator(:followers)
        end
      end
    end
  end
end
