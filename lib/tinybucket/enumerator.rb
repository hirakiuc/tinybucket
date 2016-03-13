module Tinybucket
  class Enumerator < ::Enumerator
    def initialize(iterator, block)
      @iterator = iterator

      super() do |y|
        loop do
          m = y.yield(@iterator.next)
          m = block.call(m) if block
          m
        end
      end

      lazy if lazy_enumerable?
    end

    def size
      @iterator.size
    end

    private

    def lazy_enumerable?
      ruby_major_version >= 2
    end

    def ruby_major_version
      RUBY_VERSION.split('.')[0].to_i
    end
  end
end
