require 'bitbucket/models/base_model'

module Bitbucket
  module Models
    class Repository < BaseModel
      attr_accessor \
        :scm, :has_wiki, :description, :links, :updated_on,
        :fork_policy, :created_on, :owner, :size, :parent, :has_issues,
        :is_private, :full_name, :name, :language
    end
  end
end
