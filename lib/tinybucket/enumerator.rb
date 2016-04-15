module Tinybucket
  class Enumerator < ::Enumerator
    # Constructor
    #
    # This method create a enumerator to enumerate each items of iterator.
    #
    # @note This method return Lazy Enumerator if run on ruby 2.0.0 later.
    #
    # @param iterator [Tinybucket::Iterator] iterator instance.
    # @param block [Proc] a proc object to handle each item.
    def initialize(iterator, block)
      @iterator = iterator
      @block = block

      super() do |y|
        loop do
          v = @iterator.next
          m = @block ? @block.call(v) : v
          y.yield(m)
        end
      end

      lazy if lazy_enumerable?
    end

    # Get collection size.
    #
    # @see Tinybucket::Iterator#size
    #
    # @return [Fixnum, NillClass] collection size.
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
