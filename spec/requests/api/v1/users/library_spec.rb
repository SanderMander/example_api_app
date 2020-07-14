require 'rails_helper'

describe 'Users library requests', type: :request do
  let(:user) { create :user }

  it_behaves_like 'api GET request' do

    before do
      expect(UserLibraryRepo).to receive(:call).with(user.id, filter_type).and_return(repo_response)
    end

    let(:repo_response) do
      [
        build_stubbed(:season),
        build_stubbed(:movie)
      ]
    end

    describe 'users/:id/movies' do
      let(:path) { "users/#{user.id}/movies"}
      let(:filter_type) { 'movies' }

      it 'return json response' do
        expect(json_response).to eq(repo_response.to_json)
      end
    end

    describe 'users/:id/seasons' do
      let(:path) { "users/#{user.id}/seasons"}
      let(:filter_type) { 'seasons' }
      it 'return json response' do
        expect(json_response).to eq(repo_response.to_json)
      end
    end

    describe 'users/:id/remaining' do
      let(:path) { "users/#{user.id}/remaining"}
      let(:filter_type) { 'remaining' }
      it 'return json response' do
        expect(json_response).to eq(repo_response.to_json)
      end
    end

  end
end