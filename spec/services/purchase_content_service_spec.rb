require 'rails_helper'

shared_examples 'PurchaseContentService success call' do
  it 'create purchase' do
    expect do
      service_response
    end.to change(Purchase, :count).by(1)
  end

  it 'return purchase' do
    expect(service_response.value!).to be_kind_of(Purchase)
  end

  it 'set purchase available_until 3 days' do
    expect(service_response.value!.available_until.to_i).to eq(wait_period.from_now.to_i)
  end

  it 'enqueue expire job' do
    expect(ExpirePuchaseJob).to receive(:set).with(wait_until: wait_period).and_call_original
    service_response
  end
end

shared_examples 'PurchaseContentService failed call' do
  it 'not create purchase' do
    expect do
      service_response
    end.to_not change(Purchase, :count)
  end

  it 'return error message' do
    expect(service_response.failure).to eq(error_message)
  end

  it 'not enqueue expire job' do
    expect(ExpirePuchaseJob).to_not receive(:set)
    service_response
  end
end

describe PurchaseContentService, type: :service do
  let(:service_response) { described_class.call(user, params) }
  let(:user) { create(:user) }
  let(:wait_period) { 2.days }
  let(:params) do
    {
      'content_id' => content.id,
      'content_type' => content.class.name,
      'price' => price,
      'quality' => 'sd'
    }
  end

  context 'valid params' do
    let(:price) { described_class::CONTENT_PRICE }

    context 'movie' do
      let(:content) { create :movie }
      it_behaves_like 'PurchaseContentService success call'
    end

    context 'season' do
      let(:content) { create :season }
      it_behaves_like 'PurchaseContentService success call'
    end
  end

  context 'prices are not equal' do
    let(:price) { 1.99 }
    let(:content) { create :movie }
    let(:error_message) { :prices_are_not_equal }
    it_behaves_like 'PurchaseContentService failed call'
  end

  context 'content not found' do
    let(:price) { described_class::CONTENT_PRICE }
    let(:params) do
      {
        'content_id' => 2,
        'content_type' => 'Season',
        'price' => price,
        'quality' => 'sd'
      }
    end
    let(:error_message) { :content_not_found }
    it_behaves_like 'PurchaseContentService failed call'
  end

  context 'content have wrong type' do
    let(:price) { described_class::CONTENT_PRICE }
    let(:content) { create :episode }
    let(:params) do
      {
        'content_id' => content.id,
        'content_type' => content.class.name,
        'price' => price,
        'quality' => 'sd'
      }
    end
    let(:error_message) { :wrong_content_type }
    it_behaves_like 'PurchaseContentService failed call'
  end

  context 'content already was purchased' do
    let(:price) { described_class::CONTENT_PRICE }
    let(:params) do
      {
        'content_id' => content.id,
        'content_type' => content.class.name,
        'price' => price,
        'quality' => 'sd'
      }
    end
    let!(:content) { create :movie }
    let(:error_message) { :content_already_was_bought }
    before do
      Purchase.create(user: user, content: content, expired: false, quality: 'sd', price: price)
    end
    it_behaves_like 'PurchaseContentService failed call'
  end
end
