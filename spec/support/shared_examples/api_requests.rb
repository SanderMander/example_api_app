shared_examples 'api GET request' do
  let(:send_request) { get "/api/v1/#{path}" }
  let(:json_response) { JSON.parse(response.body) }
  it 'return status 200' do
    send_request
    expect(response).to have_http_status(200)
  end 
end

shared_examples 'api POST request' do
  let(:send_request) { post "/api/v1/#{path}", params }
  let(:json_response) { JSON.parse(response.body) }
  it 'return status 201' do
    send_request
    expect(response).to have_http_status(200)
  end 
end