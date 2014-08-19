module Tinybucket
  module Model
    class Profile < Base
      attr_accessor \
        :username, :kind, :website, :display_name,
        :links, :created_on, :location, :type

      def followers(options = {})
        user_api(options).followers(options)
      end

      def following(options = {})
        user_api(options).following(options)
      end

      def repos(options = {})
        user_api(options).repos(options)
      end

      private

      def user_api(options)
        return @user if @user

        @user = create_instance 'User', options
        @user.username = username
        @user
      end
    end
  end
end
