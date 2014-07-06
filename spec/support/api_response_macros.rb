module ApiResponseMacros
  def stub_apiresponse(method, path)
    stub_request(method, 'https://bitbucket.org/api/2.0' + path)
      .to_return(
        status: 200,
        body: fixture_json(method, path),
        headers: {
          content_type: 'application/json'
        }
      )
  end

  private

  def fixture_json(method, path)
    path = 'spec/fixtures/' + method.to_s.downcase + path.gsub('/','_') + '.json'
    File.read(path)
  end
end
