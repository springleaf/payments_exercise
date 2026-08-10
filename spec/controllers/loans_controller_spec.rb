require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  let(:loan) { Loan.create!(funded_amount: 100.0) }

  describe '#index' do
    it 'responds with a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'includes oustanding balance in the response' do
      loan # create loan
      get :index
      json_response = JSON.parse(response.body)
      expect(json_response.first['outstanding_balance'].to_f).to be 100.0
    end
  end

  describe '#show' do
    it 'responds with a 200' do
      get :show, params: { id: loan.id }
      expect(response).to have_http_status(:ok)
    end

    it 'includes oustanding balance in the response' do
      get :show, params: { id: loan.id }
      json_response = JSON.parse(response.body)
      expect(json_response['outstanding_balance'].to_f).to be 100.0
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :show, params: { id: 10000 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
