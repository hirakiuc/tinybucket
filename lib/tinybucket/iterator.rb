module Tinybucket
  # Iterator
  #
  # This iterator iterate items by sending request ot Bitbucket Cloud REST API.
  class Iterator
    # Constructor
    #
    # @param api_client [Tinybucket::Api::Base] an instance of Api Client class.
    # @param method [Symbol] method name to invoke api_client method.
    # @param args [Array<Object>] arguments to pass method call of
    #   api_client as arguments.
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

    # Get collection size.
    #
    # @note This method return {https://confluence.atlassian.com/bitbucket/version-2-423626329.html#Version2-Pagingthroughobjectcollections
    #   size attribute of object collection wrapper}.
    #   So this method may return nil.
    #
    # @see https://confluence.atlassian.com/bitbucket/version-2-423626329.html#Version2-Pagingthroughobjectcollections
    #   Paging through object collections
    #
    # @return [Fixnum, NillClas] collection size.
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
