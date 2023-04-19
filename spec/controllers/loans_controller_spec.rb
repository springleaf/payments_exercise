require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  describe '#index' do
    let!(:loans) { 3.times { create(:loan)} }
    it 'responds with a 200' do
      get :index

      expect(response).to have_http_status(:ok)
    end

    it 'returns all loans' do
      get :index

      expect(json.count).to eq(3)
    end
  end

  describe '#show' do
    let(:loan) { create(:loan, funded_amount: 100.0) }

    it 'responds with a 200' do
      get :show, params: { id: loan.id }

      expect(response).to have_http_status(:ok)
    end

    it 'displays the outstanding balance' do
      get :show, params: { id: loan.id }

      expect(json).to have_key('outstanding_balance')
    end

    context 'if the loan is not found' do
      let(:invalid_id) { 10000 }
      it 'responds with a 404' do
        get :show, params: { id: invalid_id }

        expect(response).to have_http_status(:not_found)
      end

      it 'has error message' do
        get :show, params: { id: invalid_id }

        expect(json['errors']).to include('not_found')
      end
    end
  end
end
