require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  describe '#index' do
    let!(:loans) { 3.times { create(:loan)} }
    before(:each) { get :index }

    it 'responds with a 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all loans' do
      expect(json.count).to eq(3)
    end

    it 'displays the outstanding balance' do
      expect(json.first).to have_key('outstanding_balance')
    end
  end

  describe '#show' do
    let(:loan) { create(:loan, funded_amount: 100.0) }
    before(:each) { get :show, params: { id: loan.id } }

    it 'responds with a 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'displays the outstanding balance' do
      expect(json).to have_key('outstanding_balance')
    end

    context 'if the loan is not found' do
      let(:invalid_id) { 10000 }
      before(:each) { get :show, params: { id: invalid_id } }

      it 'responds with a 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'has error message' do
        expect(json['errors']).to include('not_found')
      end
    end
  end
end
