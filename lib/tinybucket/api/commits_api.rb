module Tinybucket
  module Api
    class CommitsApi < BaseApi
      include Tinybucket::Api::Helper::CommitsHelper

      attr_accessor :repo_owner, :repo_slug

      def list(options = {})
        list = get_path(path_to_list,
                        options,
                        Tinybucket::Parser::CommitsParser)

        # pass @config to each repo as api_config
        list.each { |m| m.api_config = @config.dup }
        list
      end

      def find(revision, options = {})
        m = get_path(path_to_find(revision),
                     options,
                     Tinybucket::Parser::CommitParser)

        m.api_config = @config.dup if m
        m
      end
    end
  end
end
