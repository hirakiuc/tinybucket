module Tinybucket
  module Resource
    class Base
      include Tinybucket::Model::Concerns::ApiCallable

      protected

      def method_missing(method, *args)
        enum = enumerator
        return super unless enum.respond_to?(method)

        enum.send(method, *args) do |m|
          block_given? ? yield(m) : m
        end
      end

      def create_enumerator(api_client, method, *args, &block)
        iter = Tinybucket::Iterator.new(api_client, method, *args)
        Tinybucket::Enumerator.new(iter, block)
      end

      def inject_repo_keys(model, repo_keys)
        return model unless model.respond_to?(:repo_keys=)

        model.tap { |m| m.repo_keys = repo_keys }
      end
    end
  end
end
