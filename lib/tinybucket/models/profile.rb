module Tinybucket
  module Models
    class Profile < BaseModel
      attr_accessor \
        :username, :kind, :website, :display_name,
        :links, :created_on, :location, :type

      def followers(options = {})
        @user ||= create_instance 'User', options
        @user.username = username

        @user.followers(options)
      end

      def following(options = {})
        @user ||= create_instance 'User', options
        @user.username = username

        @user.following(options)
      end

      def repos(options = {})
        @user ||= create_instance 'User', options
        @user.username = username

        @user.repos(options)
      end
    end
  end
end
