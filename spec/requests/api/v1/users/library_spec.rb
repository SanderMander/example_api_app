require 'rails_helper'

describe 'Users library requests', type: :request do
  include Dry::Monads::Result::Mixin
  let(:user) { create :user }

  describe 'success response' do
    before do
      expect(UserLibraryRepository).to receive(:call).with(user.id, filter_type).and_return(Success(repo_response))
    end
    describe 'users/:id/movies' do
      let(:path) { "users/#{user.id}/movies"}
      let(:filter_type) { 'movies' }
      let(:repo_response) do
        [
          build_stubbed(:movie),
          build_stubbed(:movie)
        ]
      end
  
      let(:example_response) do
        {
          'movies' => repo_response.map{|m| {'title' => m.title, 'plot' => m.plot}}
        }
      end
  
      it_behaves_like 'api GET request'
    end
  
    describe 'users/:id/seasons' do
      let(:path) { "users/#{user.id}/seasons"}
      let(:filter_type) { 'seasons' }
      let(:repo_response) do
        [
          build_stubbed(:season),
          build_stubbed(:season)
        ]
      end
  
      let(:example_response) do
        {
          'seasons' => repo_response.map{|s| {'title' => s.title, 'plot' => s.plot, 'number' => s.number}}
        }
      end
  
      it_behaves_like 'api GET request'
    end
  
    describe 'users/:id/remaining' do
      let(:path) { "users/#{user.id}/remaining"}
      let(:filter_type) { 'remaining' }
      let(:repo_response) do
        {
          movies: [
            build_stubbed(:movie),
            build_stubbed(:movie)
          ],
          seasons: [
            build_stubbed(:season),
            build_stubbed(:season)
          ],
        }
      end
  
      let(:example_response) do
        {
          'movies' => repo_response[:movies].map{|m| {'title' => m.title, 'plot' => m.plot}},
          'seasons' => repo_response[:seasons].map{|s| {'title' => s.title, 'plot' => s.plot, 'number' => s.number}}
        }
      end
  
      it_behaves_like 'api GET request'
    end
  end

  describe 'error response' do
    before do
      expect(UserLibraryRepository).to receive(:call).with(user.id, anything).and_return(Failure(error_message))
    end
    let(:path) { "users/#{user.id}/movies"}
    let(:error_message) { 'operation not permitted' }

    it_behaves_like 'api wrong request'
  end
end