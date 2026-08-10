require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let!(:loan) { Loan.create!(funded_amount: 100.0) }

  describe '#index' do
    it 'returns all payments for a loan' do
      Payment.create!(loan: loan, amount: 20, payment_date: Date.today)
      Payment.create!(loan: loan, amount: 30, payment_date: Date.today)

      get :index, params: { loan_id: loan.id }

      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(2)
    end
  end

  describe '#show' do
    it 'returns a specific payment' do
      payment = Payment.create!(loan: loan, amount: 25, payment_date: Date.today)

      get :show, params: { loan_id: loan.id, id: payment.id }

      json_response = JSON.parse(response.body)
      expect(json_response['amount']).to eq(payment.amount.to_s)
    end
  end
end