module Tinybucket
  module Models
    class Team < BaseModel
      attr_accessor \
        :username, :kind, :website, :display_name,
        :links, :created_on, :location, :type

      def members(options = {})
        @team ||= create_instance 'Team', options
        @team.teamname = username

        @team.members(options)
      end

      def followers(options = {})
        @team ||= create_instance 'Team', options
        @team.teamname = username

        @team.followers(options)
      end

      def following(options = {})
        @team ||= create_instance 'Team', options
        @team.teamname = username

        @team.following(options)
      end

      def repos(options = {})
        @team ||= create_instance 'Team', options
        @team.teamname = username

        @team.repos(options)
      end
    end
  end
end
