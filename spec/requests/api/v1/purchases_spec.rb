require 'rails_helper'

describe 'Purchases requests', type: :request do
  include Dry::Monads::Result::Mixin
  let!(:user) { create :user }

  describe 'POST purchases' do
    context 'purchase completed successfull' do
      before do
        expect(PurchaseContentService).to receive(:call).with(kind_of(User), params[:purchase]).and_return(Success(purchase))
      end
      let(:content_id) { create(:movie).id }
      let(:content_type) { 'Movie' }
      let(:path) { "purchases"}
      let(:params) do
        {
          user_id: user.id,
          purchase: {
            'content_id' => content_id.to_s,
            'content_type' => content_type.to_s,
            'quality' => 'sd'
          }
        }
      end
      let(:purchase) { build_stubbed :purchase, content_id: content_id, content_type: content_type, user: user, quality: 'sd'}
      let(:example_response) do
        {
          'purchase' => {
            'id' => purchase.id,
            'user_id' => purchase.user_id,
            'content_id' => purchase.content_id,
            'content_type' => purchase.content_type,
            'quality' => purchase.quality,
            'price' => purchase.price.to_s,
            'available_until' => purchase.available_until.to_i,
            'created_at' => purchase.created_at.to_i
          }
        }
      end
      it_behaves_like 'api POST request'
    end

    context 'purchase completed with errors' do
      before do
        expect(PurchaseContentService).to receive(:call).with(kind_of(User), params[:purchase]).and_return(Failure(error_message))
      end
      let(:path) { "purchases"}
      let(:params) do
        {
          user_id: user.id,
          purchase: {
            'content_id' => '1',
            'content_type' => 'Movie',
            'quality' => 'sd'
          }
        }
      end
      let(:request) { send_post_request(path, params) }
      let(:error_message) { 'content not found' }

      it_behaves_like 'api wrong request'
    end
  end
end