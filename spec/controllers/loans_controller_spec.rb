require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  let!(:loan) { Loan.create!(funded_amount: 1000) }
  let!(:payment) { Payment.create!(loan: loan, payment_date: Date.today, amount: 200) }

  describe "GET #index" do
    it "returns loans with the outstanding balance included" do
      get :index, format: :json
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.first).to have_key("outstanding_balance")
      expect(json.first["outstanding_balance"].to_f).to eq(800.0)
    end
  end

  describe "GET #show" do
    context "with a valid id" do
      it "returns a loan with its outstanding balance" do
        get :show, params: { id: loan.id }, format: :json
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json).to have_key("outstanding_balance")
        expect(json["outstanding_balance"].to_f).to eq(800.0)
      end
    end

    context "with an invalid id" do
      it "returns a 404 not_found response" do
        get :show, params: { id: 0 }, format: :json
        expect(response).to have_http_status(:not_found)
        json = JSON.parse(response.body)
        expect(json["error"]).to eq("not_found")
      end
    end
  end
end
