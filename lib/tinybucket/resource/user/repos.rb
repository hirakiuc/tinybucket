module Tinybucket
  module Resource
    module User
      class Repos < Tinybucket::Resource::User::Base
        private

        def enumerator
          create_user_enumerator(:repos)
        end
      end
    end
  end
end
