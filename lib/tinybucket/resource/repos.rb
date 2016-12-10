# frozen_string_literal: true

module Tinybucket
  module Resource
    class Repos < Base
      def initialize(owner, options)
        @owner = owner
        @args = [options]
      end

      def create(_options)
        raise NotImplementedError
      end

      def find(_options)
        raise NotImplementedError
      end

      private

      def user_api
        create_api('User').tap do |api|
          api.username = @owner
        end
      end

      def repos_api
        create_api('Repos')
      end

      def enumerator
        if @owner
          create_enumerator(user_api, :repos, *@args)
        else
          create_enumerator(repos_api, :list, *@args)
        end
      end
    end
  end
end
