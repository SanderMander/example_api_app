shared_examples 'api GET request' do
  
  it 'return status 200' do
    send_get_request(path)
    expect(response).to have_http_status(200)
  end 

  it 'return json response' do
    send_get_request(path)
    expect(json_response).to eq(example_response)
  end
end

shared_examples 'api wrong request' do
  
  it 'return status error' do
    send_get_request(path)
    expect(response).to have_http_status(422)
  end 

  it 'return json with error' do
    send_get_request(path)
    expect(json_response['error']).to eq(error_message)
  end
end
