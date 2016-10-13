module Tinybucket
  module Api
    # Hooks Api client
    #
    # @!attribute [rw] repo_owner
    #   @return [String] repository owner name.
    # @!attribute [rw] repo_slug
    #   @return [String] repository slug. (about {https://confluence.atlassian.com/bitbucket/repositories-endpoint-423626330.html#repositoriesEndpoint-Overview
    #     repo_slug})
    class HooksApi < BaseApi
      include Tinybucket::Api::Helper::HooksHelper

      attr_accessor :repo_owner, :repo_slug

      # Send 'GET a Hooks list for a repository' request
      #
      # @see https://confluence.atlassian.com/bitbucket/Hooks-or-Hook-resource-389775478.html#HooksorHookResource-GETaHookslistforarepositoryorcompareHooksacrossHooks
      #   GET a Hooks list for a repository
      #
      # @param options [Hash]
      # @return [Tinybucket::Model::Page]
      def list(options = {})
        get_path(
          path_to_list,
          options,
          Tinybucket::Parser::HooksParser
        )
      end

      # Send 'GET an individual Hook' request
      #
      # @see https://confluence.atlassian.com/bitbucket/Hooks-or-Hook-resource-389775478.html#HooksorHookResource-GETanindividualHook
      #   GET an individual Hook
      #
      # @param hook [String] A UUID for the Hook.
      # @param options [Hash]
      # @return [Tinybucket::Model::Hook]
      def find(hook, options = {})
        get_path(
          path_to_find(hook),
          options,
          Tinybucket::Parser::HookParser
        )
      end


      # Send 'POST a hook for a repository' request
      #
      # @param url [String]
      # @param events [Array]
      # @param description [String]
      # @param description [Boolean]
      # @param options [Hash]
      # @return [Tinybucket::Model::Hook]
      def post(url, events, description="", active=true, options={})
        post_path(
          path_to_post,
          options.merge({
            :url => url,
            :events => events,
            :description => description,
            :active => active
          }),
          Tinybucket::Parser::HookParser,
        )
      end

      # Send 'PUT a hook for a repository' request
      #
      # @param options [Hash] The attributes to update
      # @return [Tinybucket::Model::Hook]
      def update(hook, options={})
        put_path(
          path_to_put(hook),
          options)
        true
      end

      # Send 'DELETE a hook for a repository' request
      #
      # @param options [Hash] The attributes to update
      # @return [Boolean]
      def delete(hook, options={})
        delete_path(
          path_to_delete(hook),
          options)
        true
      end

    end
  end
end
