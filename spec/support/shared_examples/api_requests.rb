shared_examples 'api GET request' do
  it 'return status 200' do
    send_get_request(path)
    expect(response.status.to_s).to match(/20[0-9]/)
  end

  it 'return json response' do
    send_get_request(path)
    expect(json_response).to eq(example_response)
  end
end

shared_examples 'api POST request' do
  it 'return status 201' do
    send_post_request(path, params)
    expect(response.status.to_s).to match(/20[0-9]/)
  end

  it 'return json response' do
    send_post_request(path, params)
    expect(json_response).to eq(example_response)
  end
end

shared_examples 'api wrong request' do
  it 'return status error' do
    request
    expect(response.status.to_s).to match(/4[0-9]+/)
  end

  it 'return json with error' do
    request
    expect(json_response['error']).to eq(error_message)
  end
end
