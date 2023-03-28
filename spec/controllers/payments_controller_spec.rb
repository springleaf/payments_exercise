require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#index' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }
    it 'responds with a 200' do
      get :index, params: { loan_id: loan.id}
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }
    let(:payment) {Payment.create!(amount: 50.0, loan_id: loan.id, payment_date: Date.today)}

    context 'if the payment is found' do
      it 'responds with a 200' do
        get :show, params: { loan_id: loan.id, id: payment.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'if the payment is not found' do
      it 'responds with a 404' do
        get :show, params: { loan_id: loan.id, id: 10000 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#create' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    context 'with valid params' do
      it 'adds a payment if outstanding balance greater than payment amount' do
        expect(loan.payments.count).to eq 0
        post :create, params: { loan_id: loan.id, payment: { amount: 50.0, payment_date: Date.today-5.days} }
        expect(loan.payments.count).to eq 1
        result= JSON.parse(response.body).deep_symbolize_keys
        expect(result[:amount]).to eq "50.0"
        expect(result[:payment_date].to_datetime).to eq (Date.today-5.days).to_datetime
      end

      it 'if payment date is not passed it defaults to todays date' do
        expect(loan.payments.count).to eq 0
        post :create, params: { loan_id: loan.id, payment: {amount: 50.0} }
        expect(loan.payments.count).to eq 1
        result= JSON.parse(response.body).deep_symbolize_keys
        expect(result[:payment_date].to_datetime.utc.to_s).to eq DateTime.now.utc.to_s
      end

      it 'returns error if outstanding balance is less than payment amount' do
        expect(loan.payments.count).to eq 0
        post :create, params: { loan_id: loan.id, payment: { amount: 150.0, payment_date: Date.today-5.days} }
        expect(loan.payments.count).to eq 0
        result= JSON.parse(response.body).deep_symbolize_keys
        expect(result).to eq ({:amount=>["amount can't be greater than outstanding loan balance"]})
      end

      it 'returns error if payment amount is zero' do
        expect(loan.payments.count).to eq 0
        post :create, params: { loan_id: loan.id, payment: { amount: 0.0, payment_date: Date.today-5.days} }
        expect(loan.payments.count).to eq 0
        result= JSON.parse(response.body).deep_symbolize_keys
        expect(result).to eq ({:amount=>["amount should be grater than 0"]})
      end
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        post :create, params: { loan_id: 10000 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end