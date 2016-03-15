module Tinybucket
  module Model
    class Profile < Base
      include Tinybucket::Model::Concerns::Reloadable

      acceptable_attributes \
        :username, :kind, :website, :display_name,
        :links, :created_on, :location, :type, :uuid

      def followers(options = {})
        user_api.followers(options)
      end

      def following(options = {})
        user_api.following(options)
      end

      def repos(options = {})
        user_api.repos(options)
      end

      private

      def user_api
        return @user if @user

        @user = create_instance('User')
        @user.username = username
        @user
      end

      def load_model
        user_api.profile
      end
    end
  end
end
