require 'rails_helper'

describe 'Users library requests', type: :request do
  include Dry::Monads::Result::Mixin
  let(:user) { create :user }

  describe 'success response' do
    before do
      expect(UserLibraryRepository).to receive(:call).with(user.id, filter_type).and_return(Success(repo_response))
    end
    describe 'GET users/:id/movies' do
      let(:path) { "users/#{user.id}/movies"}
      let(:filter_type) { 'movies' }
      let(:repo_response) do
        {
          type: 'movies',
          results:[
            build_stubbed(:movie),
            build_stubbed(:movie)
          ]
        }
      end
  
      let(:example_response) do
        {
          'movies' => repo_response[:results].map{|m| {'title' => m.title, 'plot' => m.plot}}
        }
      end
  
      it_behaves_like 'api GET request'
    end
  
    describe 'GET users/:id/seasons' do
      let(:path) { "users/#{user.id}/seasons"}
      let(:filter_type) { 'seasons' }
      let(:repo_response) do
        {
          type: 'seasons',
          results:[
            create(:season),
            create(:season)
          ]
        }
      end
      before do
        repo_response[:results].each do |season|
          create_list :episode, 2, season: season
        end
      end
  
      let(:example_response) do
        {
          'seasons' => repo_response[:results].map do |s| 
            {
              'title' => s.title, 
              'plot' => s.plot, 
              'number' => s.number,
              'episodes' => s.episodes.map do |e|
                {
                  'title' => e.title,
                  'plot' => e.plot,
                  'number' => e.number
                }
              end
            }
          end
        }
      end
  
      it_behaves_like 'api GET request'
    end
  
    describe 'GET users/:id/remaining' do
      let(:path) { "users/#{user.id}/remaining"}
      let(:filter_type) { 'remaining' }
      let(:repo_response) do
        {
          type: 'remaining',
          results:
          {
            movies: [
              build_stubbed(:movie),
              build_stubbed(:movie)
            ],
            seasons: [
              build_stubbed(:season),
              build_stubbed(:season)
            ]
          }
        }
      end
  
      let(:example_response) do
        {
          'movies' => repo_response[:results][:movies].map{|m| {'title' => m.title, 'plot' => m.plot}},
          'seasons' => repo_response[:results][:seasons].map{|s| {'title' => s.title, 'plot' => s.plot, 'number' => s.number}}
        }
      end
  
      it_behaves_like 'api GET request'
    end
    describe 'GET users/:id/all' do
      let(:path) { "users/#{user.id}/all"}
      let(:filter_type) { 'all' }
      let(:repo_response) do
        {
          type: 'all',
          results:
          {
            movies: [
              build_stubbed(:movie),
              build_stubbed(:movie)
            ],
            seasons: [
              build_stubbed(:season),
              build_stubbed(:season)
            ]
          }
        }
      end
  
      let(:example_response) do
        {
          'movies' => repo_response[:results][:movies].map{|m| {'title' => m.title, 'plot' => m.plot}},
          'seasons' => repo_response[:results][:seasons].map{|s| {'title' => s.title, 'plot' => s.plot, 'number' => s.number}}
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
    let(:request) { send_get_request(path) }
    it_behaves_like 'api wrong request'
  end
end