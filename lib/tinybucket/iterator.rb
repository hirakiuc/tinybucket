module Tinybucket
  class Iterator
    def initialize(api_client, method, *args)
      @client = api_client
      @method = method
      @args = args

      @attrs = {}
      @values = []
      @pos = nil
    end

    def next
      next_value
    end

    def size
      load_next if next?
      @attrs[:size]
    end

    private

    def next_value
      load_next if next?

      @values.fetch(@pos).tap { @pos += 1 }
    rescue IndexError
      raise StopIteration
    end

    def next?
      @pos.nil? || (@values.size == @pos && @attrs[:next])
    end

    def load_next
      @pos = 0 if @pos.nil?

      page = @client.send(@method, *next_params)

      @attrs = page.attrs
      @values.concat(page.items)
    end

    def next_params
      params =
        if @attrs.empty?
          {}
        else
          unescaped_query = URI.unescape(URI.parse(@attrs[:next]).query)
          Hash[*unescaped_query.split(/&|=/)]
        end

      @args[-1].merge!(params)
      @args
    end
  end
end
