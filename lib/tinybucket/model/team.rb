module Tinybucket
  module Model
    class Team < Base
      attr_accessor \
        :username, :kind, :website, :display_name,
        :links, :created_on, :location, :type

      def members(options = {})
        team_api(options).members(options)
      end

      def followers(options = {})
        team_api(options).followers(options)
      end

      def following(options = {})
        team_api(options).following(options)
      end

      def repos(options = {})
        team_api(options).repos(options)
      end

      private

      def team_api(options)
        return @team if @team

        @team = create_instance 'Team', options
        @team.teamname = username
        @team
      end
    end
  end
end
