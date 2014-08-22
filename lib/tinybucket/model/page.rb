module Tinybucket
  module Model
    class Page
      # attr_reader :size, :page, :pagelen, :next, :previous
      attr_reader :attrs
      attr_reader :items
      attr_writer :next_proc

      def initialize(json, item_klass)
        @attrs = {}
        %w(size page pagelen next previous).each do |attr|
          @attrs[attr.intern] = json[attr]
        end

        @items = if json['values'].present? && json['values'].is_a?(Array)
                   json['values'].map { |hash| item_klass.new(hash) }
                 else
                   []
                 end
      end

      def size
        @attrs[:size]
      end

      def each(options = {})
        loop do
          start = (@attrs[:page] - 1) * @attrs[:pagelen]

          @items.each_with_index do |m, i|
            pos = start + i
            yield(m, pos)

            fail StopIteration if \
              (!options[:limit].nil? && pos == (options[:limit] - 1))
          end

          break unless next_page?

          load_next
        end

      rescue StopIteration
        return
      end

      private

      def next_page?
        @attrs[:next].present?
      end

      def load_next
        fail StopIteration if @attrs[:next].nil? || @next_proc.nil?

        list = @next_proc.call(@attrs[:page] + 1)

        fail StopIteration if list.items.size == 0

        @attrs = list.attrs
        @items = list.items
      end
    end
  end
end
