# frozen_string_literal: true

module Tinybucket
  module Model
    class Project < Base
      acceptable_attributes \
        :description, :links, :uuid, :created_on,
        :key, :updated_on, :is_private, :name
    end
  end
end
