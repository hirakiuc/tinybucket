# frozen_string_literal: true

module Tinybucket
  module Resource
    class Teams < Base
      def initialize(role_name, options = {})
        @role_name = role_name
        @args = [options]
      end

      private

      def teams_api
        create_api('Team')
      end

      def enumerator
        create_enumerator(teams_api, :list, @role_name, *@args)
      end
    end
  end
end
