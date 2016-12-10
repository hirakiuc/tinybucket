# frozen_string_literal: true

module Tinybucket
  module Model
    module Concerns
      module Enumerable
        extend ActiveSupport::Concern

        included do
          protected

          def enumerator(api_client, method, *args, &block)
            iter = Tinybucket::Iterator.new(api_client, method, *args)
            Tinybucket::Enumerator.new(iter, block)
          end
        end
      end
    end
  end
end
