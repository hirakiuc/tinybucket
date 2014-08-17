module Tinybucket
  module Model
    class Page
      include Enumerable
      attr_reader :size, :page, :pagelen, :next, :previous

      def initialize(json, item_klass)
        @size = json['size']
        @page = json['page']
        @pagelen = json['pagelen']
        @next = json['next']
        @previous = json['previous']

        @items = json['values'].map { |hash| item_klass.new(hash) }
      end

      def each
        @items.each do |item|
          yield item
        end
      end

      def [](pos)
        @items[pos]
      end
    end
  end
end
