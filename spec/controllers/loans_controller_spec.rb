require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  let!(:loan) { Loan.create!(funded_amount: 100.0) }

  describe '#index' do
    it 'responds with a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    it 'returns a specific loan' do
      get :show, params: { id: loan.id }

      json_response = JSON.parse(response.body)
      expect(json_response['funded_amount']).to eq(loan.funded_amount.to_s)
    end
  end
end