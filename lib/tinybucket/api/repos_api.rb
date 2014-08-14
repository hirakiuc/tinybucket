module Tinybucket
  module Api
    class ReposApi < BaseApi
      include Tinybucket::Api::Helper::ReposHelper

      def list(options = {})
        opts = options.clone
        opts.delete(:owner)

        list = get_path(path_to_list(options),
                        opts,
                        Tinybucket::Parser::ReposParser)

        inject_api_config(list)
      end
    end
  end
end
