# frozen_string_literal: true

module Tinybucket
  module Model
    module Concerns
      module Reloadable
        extend ActiveSupport::Concern

        included do
          def load
            return true if @_loaded

            self.attributes = load_model.attributes
            @_loaded = true
          rescue => e
            @_loaded = false
            Tinybucket.logger.error e
            raise e
          end

          def loaded?
            @_loaded
          end

          def reload
            @_loaded = false

            self.load
          end

          private

          def load_model
            raise NotImplementedError
          end
        end
      end
    end
  end
end
