module Tinybucket
  module Model
    class Team < Base
      include Tinybucket::Model::Concerns::Reloadable

      acceptable_attributes \
        :username, :kind, :website, :display_name, :uuid,
        :links, :created_on, :location, :type

      def members(options = {})
        team_api.members(username, options)
      end

      def followers(options = {})
        team_api.followers(username, options)
      end

      def following(options = {})
        team_api.following(username, options)
      end

      def repos(options = {})
        team_api.repos(username, options)
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
