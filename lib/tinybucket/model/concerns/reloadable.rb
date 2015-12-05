module Tinybucket
  module Model
    module Concerns
      module Reloadable
        extend ActiveSupport::Concern

        included do
          def load
            return true if @_loaded

            @_loaded = \
              begin
                self.attributes = load_model.attributes
                true
              rescue => e
                Tinybucket.logger.error e
                false
              end

            @_loaded
          end

          def loaded?
            @_loaded
          end

          def reload
            @_loaded = false
            load
          end

          private

          def load_model
            fail NotImplementedError
          end
        end
      end
    end
  end
end
