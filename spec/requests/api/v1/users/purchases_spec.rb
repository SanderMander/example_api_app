require 'rails_helper'

describe 'Users purchases requests', type: :request do
  let(:user) { create :user }

  it_behaves_like 'api POST request' do
    describe 'users/:id/purchases' do
      let(:path) { "users/#{user.id}/purchases"}
      let(:params) do
        {
          content_id: content_id,
          content_type: content_type,
          quality: 'sd'
        }
      end

      context 'purchase movie' do
        let(:content_id) { create :movie }
        let(:content_type) { 'movie' }

        it 'purchase movie' do
          expect do
            send_request
          end.to change(Purchase, :count).by(1)
        end

        it 'render purchase json' do
          expect(json_response).to eq({
            'content_id' => content_id,
            'content_type' => content_type,
            'quality' => 'sd'
          })
        end
      end
      
      context 'purchase season' do
        let(:content_id) { create :season }
        let(:content_type) { 'season'}

        it 'purchase season' do
          expect do
            send_request
          end.to change(Purchase, :count).by(1)
        end

        it 'render purchase json' do
          expect(json_response).to eq({
            'content_id' => content_id,
            'content_type' => content_type,
            'quality' => 'sd'
          })
        end
      end
    end
  end
end