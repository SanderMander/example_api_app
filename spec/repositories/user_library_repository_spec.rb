require 'rails_helper'

describe UserLibraryRepository, type: :service do
  let(:service_call) { described_class.call(user.id, filter_type) }
  let(:user) { create :user }
  let(:results) { service_call.value![:results] }
  before do
    user_content.each do |content|
      create(:purchase, user: user, content: content, available_until: (content.created_at + 3.days))
    end
  end

  describe 'movies' do
    let(:filter_type) { 'movies' }
    context 'user content present' do
      let!(:user_content) do
        [
          create(:movie, created_at: 2.hours.ago),
          create(:movie, created_at: 1.hour.ago)
        ]
      end
   
      it 'return records ordered by created_at' do
        expect(results.first.id).to eq(user_content[1].id)
      end
    end
    context 'user content blank' do
      let!(:user_content){ [] }
  
      it 'return empty results' do
        expect(results).to eq([])
      end
    end

  end

  describe 'seasons' do
    let(:filter_type) { 'seasons' }
    context 'user content present' do
      let!(:user_content) do
        [
          create(:season, created_at: 2.hours.ago),
          create(:season, created_at: 1.hour.ago)
        ]
      end
  
      it 'return records ordered by created_at' do
        expect(results.first.id).to eq(user_content[1].id)
      end
    end

    context 'user content blank' do
      let!(:user_content){ [] }
  
      it 'return empty results' do
        expect(results).to eq([])
      end
    end
  end

  describe 'all' do
    let(:filter_type) { 'all' }

    context 'user content present' do
      let!(:user_content) do
        [
          create(:season, created_at: 2.hours.ago),
          create(:season, created_at: 1.hour.ago),
          create(:movie, created_at: 4.hours.ago),
          create(:movie, created_at: 3.hour.ago)
        ]
      end
      let(:user_movies) do
        user_content.select{|c| c.class.name == 'Movie'}
      end
      let(:user_seasons) do
        user_content.select{|c| c.class.name == 'Season'}
      end
  
      it 'return records ordered by created_at' do
        expect(results[:seasons].first.id).to eq(user_seasons[1].id)
      end
  
      it 'return records ordered by created_at' do
        expect(results[:movies].first.id).to eq(user_movies[1].id)
      end
    end
    
    context 'user content blank' do
      let!(:user_content){ [] }

      it 'return empty results' do
        expect(results[:seasons]).to eq([])
        expect(results[:movies]).to eq([])
      end
    end
  end

  describe 'remaining' do
    let(:filter_type) { 'remaining' }
    context 'user content present' do
      let!(:user_content) do
        [
          create(:season, created_at: 1.hour.ago),
          create(:season, created_at: 2.hours.ago),
          create(:movie, created_at: 3.hour.ago),
          create(:movie, created_at: 4.hours.ago)
        ]
      end

      let(:user_movies) do
        user_content.select{|c| c.class.name == 'Movie'}
      end
      let(:user_seasons) do
        user_content.select{|c| c.class.name == 'Season'}
      end
  
      it 'return records ordered by available_until' do
        expect(results[:seasons].first.id).to eq(user_seasons[1].id)
      end
  
      it 'return records ordered by available_until' do
        expect(results[:movies].first.id).to eq(user_movies[1].id)
      end
    end
    
    context 'user content blank' do
      let!(:user_content){ [] }

      it 'return empty results' do
        expect(results[:seasons]).to eq([])
        expect(results[:movies]).to eq([])
      end
    end
  end
end