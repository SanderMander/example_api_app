module RequestHelpers
  def send_get_request(path)
    get "/api/v1/#{path}", headers: { 'HTTP_ACCEPT' => 'application/json' }
  end

  def send_post_request(path, params)
    post "/api/v1/#{path}", { params: params, headers: { 'HTTP_ACCEPT' => 'application/json' } }
  end

  def json_response
    JSON.parse(response.body)
  end
end
