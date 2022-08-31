require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let(:loan) { create(:loan, funded_amount: funded_amount) }
  let(:funded_amount) { 200.00 }
  let(:payment) { create(:payment, loan: loan, amount: 50.00) }

  describe '#index' do
    it 'responds with a 200' do
      get :index, params: { loan_id: loan.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    it 'responds with a 200' do
      get :show, params: { loan_id: loan.id, id: payment.id }
      expect(response).to have_http_status(:ok)
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :show, params: { loan_id: 1000, id: 10000 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#create' do
    it 'responds with a 201' do
      post :create, params: { loan_id: loan.id, "payment": { "amount": "20.00" }  }
      expect(response).to have_http_status(:created)
    end

    context 'if the payment is greater than loan' do
      let(:funded_amount) { 10.00 }

      it 'responds with 422' do
        post :create, params: { loan_id: loan.id, "payment": { "amount": "20.00" }  }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
