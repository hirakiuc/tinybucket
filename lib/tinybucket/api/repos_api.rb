module Tinybucket
  module Api
    class ReposApi < BaseApi
      include Tinybucket::Api::Helper::ReposHelper

      def list(options = {})
        opts = options.clone
        opts.delete(:owner)

        get_path(
          path_to_list(options),
          opts,
          Tinybucket::Parser::ReposParser
        )
      end
    end
  end
end
