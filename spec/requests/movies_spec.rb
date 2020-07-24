require 'rails_helper'

describe 'Users library requests', type: :request do
  describe 'GET movies' do
    let(:path) { 'movies' }
    let!(:movies) do
      [
        create(:movie, created_at: 2.hours.ago),
        create(:movie, created_at: 1.hours.ago)
      ]
    end
    let(:example_response) do
      {
        'movies' => [
          {
            'title' => movies[1].title,
            'plot' => movies[1].plot
          },
          {
            'title' => movies[0].title,
            'plot' => movies[0].plot
          }
        ]
      }
    end

    it_behaves_like 'api GET request'
  end
end
