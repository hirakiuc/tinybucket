module Tinybucket
  module Model
    class Profile < Base
      include Tinybucket::Model::Concerns::Reloadable

      acceptable_attributes \
        :username, :kind, :website, :display_name,
        :links, :created_on, :location, :type, :uuid

      def followers(options = {})
        enumerator(
          user_api,
          :followers,
          options
        ) { |m| block_given? ? yield(m) : m }
      end

      def following(options = {})
        enumerator(
          user_api,
          :following,
          options
        ) { |m| block_given? ? yield(m) : m }
      end

      def repos(options = {})
        enumerator(
          user_api,
          :repos,
          options
        ) { |m| block_given? ? yield(m) : m }
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
