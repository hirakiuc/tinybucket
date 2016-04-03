module Tinybucket
  module Resource
    module Commit
      class Base < Tinybucket::Resource::Base
        def initialize(commit, options)
          @commit = commit
          @args = [options]
        end
      end
    end
  end
end
