# frozen_string_literal: true

module Tinybucket
  module Model
    module Concerns
      module RepositoryKeys
        extend ActiveSupport::Concern

        included do
          attr_accessor :repo_owner, :repo_slug

          def repo_keys?
            repo_owner.present? && repo_slug.present?
          end

          def repo_keys
            { repo_owner: repo_owner, repo_slug: repo_slug }
          end

          def repo_keys=(keys)
            self.repo_owner = keys[:repo_owner]
            self.repo_slug  = keys[:repo_slug]
          end

          private

          def inject_repo_keys(result)
            case result
            when Tinybucket::Model::Page
              result.items.map do |m|
                next unless m.class.concern_included?(:RepositoryKeys)
                m.repo_keys = repo_keys
              end
            when Tinybucket::Model::Base
              result.repo_keys = repo_keys \
                if result.class.concern_included?(:RepositoryKeys)
            end

            result
          end
        end
      end
    end
  end
end
