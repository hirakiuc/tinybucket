module Tinybucket
  module Resource
    module User
      class Base < Tinybucket::Resource::Base
        def initialize(user_name, options)
          @user_name = user_name
          @args = [options]
        end

        protected

        def user_api
          create_api('User').tap do |api|
            api.username = @user_name
          end
        end

        def email_api
          create_api('Email')
        end

        def create_user_enumerator(method)
          create_enumerator(user_api, method, *@args)
        end
      end
    end
  end
end
