require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let(:loan) { Loan.create!(funded_amount: 100.0) }
  let(:payment) { Payment.create!(loan: loan, date: Date.today, amount: 100.00) }

  describe "#index" do
    it "returns http success with payments" do
      payment
      get :index, params: { loan_id: loan.id }
      expect(response).to have_http_status(:success)
      expect(response.body).to include("100.0")
    end

    context "when loan is not found" do
      it "returns http not found" do
        get :index, params: { loan_id: 10000 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "#show" do
    it "returns http success with payment details" do
      payment
      get :show, params: { loan_id: loan.id, id: payment.id }
      expect(response).to have_http_status(:success)
      expect(response.body).to include("100.0")
    end
  end

  describe "#create" do
    it "add payment & returns http success" do
      expect do
        post :create, params: { loan_id: loan.id, payment: { date: Date.today, amount: 100.00 } }
        expect(response).to have_http_status(:success)
      end.to change { loan.payments.count }.by(1)
    end

    it "returns http unprocessable_entity when payment exeeds loan balance" do
      expect do
        post :create, params: { loan_id: loan.id, payment: { date: Date.today, amount: 1000.00 } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Payment amount exceeds loan balance")
      end.to_not change { loan.payments.count }
    end
  end
end
