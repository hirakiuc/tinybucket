# frozen_string_literal: true

module Tinybucket
  module Resource
    module Team
      class Projects < Base
        attr_accessor :owner

        def initialize(owner, options = {})
          @owner = owner
          @args = [options]
        end

        private

        def projects_api
          create_api('Projects').tap do |api|
            api.owner = owner
          end
        end

        def enumerator
          create_enumerator(projects_api, :list, *@args)
        end
      end
    end
  end
end
