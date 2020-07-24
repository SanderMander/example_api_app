require 'rails_helper'

describe 'Users library requests', type: :request do
  describe 'GET seasons' do
    let(:path) { 'seasons' }
    let!(:seasons) do
      [
        create(:season, created_at: 2.hours.ago),
        create(:season, created_at: 1.hours.ago)
      ]
    end
    before do
      create :episode, season: seasons[0]
      create :episode, season: seasons[1]
    end
    let(:example_response) do
      {
        'seasons' =>
          [
            {
              'title' => seasons[1].title,
              'plot' => seasons[1].plot,
              'number' => seasons[1].number,
              'episodes' => seasons[1].episodes.map do |e|
                {
                  'title' => e.title,
                  'plot' => e.plot,
                  'number' => e.number
                }
              end
            },
            {
              'title' => seasons[0].title,
              'plot' => seasons[0].plot,
              'number' => seasons[0].number,
              'episodes' => seasons[0].episodes.map do |e|
                {
                  'title' => e.title,
                  'plot' => e.plot,
                  'number' => e.number
                }
              end
            }
          ]
      }
    end

    it_behaves_like 'api GET request'
  end
end
