require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let!(:loan) { Loan.create!(funded_amount: 1200) }
  let!(:payment) { Payment.create!(loan: loan, payment_date: Date.today, amount: 500) }

  describe "GET #index" do
    it "returns a list of payments for a loan" do
      get :index, params: { loan_id: loan.id }, format: :json
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.size).to eq(1)
    end
  end

  describe "GET #show" do
    it "returns a specific payment" do
      get :show, params: { loan_id: loan.id, id: payment.id }, format: :json
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(payment.id)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new payment" do
        post :create, params: { loan_id: loan.id, payment: { payment_date: '2025-03-13', amount: 500 } }, format: :json
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json["amount"].to_f).to eq(500.0)
      end
    end

    context "with invalid attributes" do
      it "returns errors when payment exceeds the outstanding balance" do
        post :create, params: { loan_id: loan.id, payment: { payment_date: '2025-03-13', amount: 900 } }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)
        expect(json["errors"]).to include("Amount exceeds the outstanding balance of the loan")
      end
    end
  end
end
