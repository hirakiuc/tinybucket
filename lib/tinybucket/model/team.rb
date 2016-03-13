module Tinybucket
  module Model
    class Team < Base
      include Tinybucket::Model::Concerns::Reloadable

      acceptable_attributes \
        :username, :kind, :website, :display_name, :uuid,
        :links, :created_on, :location, :type

      def members(options = {})
        enumerator(
          team_api,
          :members,
          username,
          options
        ) { |m| block_given? ? yield(m) : m }
      end

      def followers(options = {})
        enumerator(
          team_api,
          :followers,
          username,
          options
        ) { |m| block_given? ? yield(m) : m }
      end

      def following(options = {})
        enumerator(
          team_api,
          :following,
          username,
          options
        ) { |m| block_given? ? yield(m) : m }
      end

      def repos(options = {})
        enumerator(
          team_api,
          :repos,
          username,
          options
        ) { |m| block_given? ? yield(m) : m }
      end

      private

      def team_api
        return @team if @team
        @team = create_instance('Team')
      end

      def load_model
        team_api.find(username)
      end
    end
  end
end
