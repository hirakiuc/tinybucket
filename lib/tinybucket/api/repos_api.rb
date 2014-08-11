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

        # pass @config to each repo as api_config
        list.each { |repo| repo.api_config = @config.dup }
        list
      end
    end
  end
end
