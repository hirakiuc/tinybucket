module Tinybucket
  module Model
    class Team < Base
      include Tinybucket::Model::Concerns::Reloadable

      attr_accessor \
        :username, :kind, :website, :display_name,
        :links, :created_on, :location, :type

      def members(options = {})
        team_api(options).members(username, options)
      end

      def followers(options = {})
        team_api(options).followers(username, options)
      end

      def following(options = {})
        team_api(options).following(username, options)
      end

      def repos(options = {})
        team_api(options).repos(username, options)
      end

      private

      def team_api(options)
        return @team if @team

        @team = create_instance 'Team', options
      end

      def load_model
        team_api({}).find(username)
      end
    end
  end
end
