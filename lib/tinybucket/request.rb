module Tinybucket
  module Request
    def get_path(path, params = {}, parser = nil, options = {})
      request(:get, path, params, parser, options)
    end

    def patch_path(path, params = {}, parser = nil, options = {})
      request(:patch, path, params, parser, options)
    end

    def post_path(path, params = {}, parser = nil, options = {})
      request(:post, path, params, parser, options)
    end

    def put_path(path, params = {}, parser = nil, options = {})
      request(:put, path, params, parser, options)
    end

    def delete_path(path, params = {}, parser = nil, options = {})
      request(:delete, path, params, parser, options)
    end

    private

    def request(method, path, params, parser, options)
      conn = connection(options, parser)

      path = (conn.path_prefix + path).gsub(%r{//}, '/') \
        if conn.path_prefix != '/'

      response = conn.send(method) do |request|
        case method.intern
        when :get, :delete
          request.body = params.delete('data') if params.key?('data')
          request.url(path, params)
        when :post, :put, :patch
          request.path = path
          request.body = extract_data_from_params(params) unless params.empty?
        else
          fail ArgumentError, 'unknown http method: ' + method
        end
      end

      response.body
    end

    def extract_data_from_params(params)
      if params.key?('data') && !params['data'].nil?
        params['data']
      else
        params
      end
    end
  end
end
