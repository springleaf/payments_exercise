require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let!(:loan) { FactoryBot.create(:loan, funded_amount: 1000) }
  describe 'POST #create' do
    it 'create the payments for a given loan' do
      expect do
        post :create, params: { loan_id: loan.id, payment: { amount: 100, payment_date: Date.new} }
      end.to change { Payment.count }.by(1)
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)["success"]).to eq('Successfully created payments amount for a given loan.')
    end

    it 'return error if payment amount exceeds outstanding balance' do
      post :create, params: { loan_id: loan.id, payment: { amount: 1100, payment_date: Date.new } }
      expect(response.status).to eq(422)
      p JSON.parse(response.body)
      expect(JSON.parse(response.body)["errors"]).to eq(['Amount cannot exceed the outstanding balance.'])
    end
  end
end