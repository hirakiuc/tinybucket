module Tinybucket
  module Resource
    module User
      class Following < Tinybucket::Resource::User::Base
        private

        def enumerator
          create_user_enumerator(:following)
        end
      end
    end
  end
end
