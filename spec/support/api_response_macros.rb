module ApiResponseMacros
  def stub_apiresponse(method, path, options = {})
    response_headers = { content_type: 'application/json' }.merge(options)

    ext =
      case response_headers[:content_type]
      when 'plain/text' then; 'txt'
      else                    'json'
      end

    stub_request(method, api_path(path))
      .to_return(
        status: (options[:status_code] || 200),
        body: (options[:message] || fixture_json(method, path, ext)),
        headers: response_headers)
  end

  def stub_enum_response(method, path)
    response_headers = { content_type: 'application/json' }

    first_page_json = fixture_json(method, path, 'json')

    # stub for first page
    stub_request(method, api_path(path))
      .to_return(
        status: 200,
        body: first_page_json,
        headers: response_headers)

    # stub for second(last) page
    next_url = JSON.parse(first_page_json)['next'] || api_path(path, page: 2)
    stub_request(method, next_url)
      .to_return(
        status: 200,
        body: last_page_json(api_path(path, page: 1)),
        headers: response_headers)
  end

  private

  def api_path(path, params = {})
    'https://api.bitbucket.org/2.0' + path + query_string(params)
  end

  def query_string(params)
    return '' if params.empty?

    '?' + params.each_pair.map do |k, v|
      URI.escape(k.to_s) + '=' + URI.escape(v.to_s)
    end.join('&')
  end

  def fixture_json(method, path, ext)
    parts = path.split('?')

    path = 'spec/fixtures' + parts[0]
    fname = method.to_s
    fname += '_' + parts[1].gsub(/[\/??&=]/, '_') if parts[1].present?
    fname += '.' + ext

    File.read(path + '/' + fname)
  end

  def last_page_json(prev)
    JSON.generate(
      size: 1,
      page: 2,
      pagelen: 0,
      next: nil,
      previous: prev,
      values: []
    )
  end
end
