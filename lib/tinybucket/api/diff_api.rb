module Tinybucket
  module Api
    class DiffApi < BaseApi
      include Tinybucket::Api::Helper::DiffHelper

      attr_accessor :repo_owner, :repo_slug

      def find(spec, options = {})
        get_path(path_to_find(spec), options)
      end

      def find_patch(spec, options = {})
        get_path(path_to_patch(spec), options)
      end
    end
  end
end
