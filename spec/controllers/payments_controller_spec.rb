require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  let(:loan) {create(:loan)}
  describe '#index' do
    let!(:payments) { 3.times { create(:payment, loan: loan)} }
    let!(:payment_for_different_loan) { create(:payment) }
    before(:each) { get :index, params: { loan_id: loan.id } }
    it 'responds with a 200' do
      expect(response).to have_http_status(:ok)
    end

    it "has the correct count of payments" do
      expect(json.count).to eq(3)
    end

    context "when the loan is not found" do
      it "has error message not_found" do
        get :index, params: { loan_id: 10000 }

        expect(json['errors']).to include("not_found")
      end
    end
  end

  describe '#show' do
    let!(:payment) { create(:payment, loan: loan) }
    it 'responds with a 200' do
      get :show, params: { loan_id: loan.id, id: payment.id }

      expect(response).to have_http_status(:ok)
    end

    context "when the loan is not found" do
      it "has error message not_found" do
        get :show, params: { loan_id: 10000, id: payment.id }

        expect(json['errors']).to include("not_found")
      end
    end
  end

  describe '#create' do
    def post_create(loan)
      post :create, params: { 
        loan_id: loan.id,
        payment: {
          amount: 300.0,
          payment_date: Time.zone.now
        }
      }
    end
    before(:each) { post_create(loan) }
    it 'responds with a 201' do
      expect(response).to have_http_status(:created)
    end

    context "when a payment can't be create" do
      let(:loan) { create(:loan, funded_amount: 200.0) }
      it "responds with a 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "show the correct errors" do
        expect(json['errors']).to include("Amount can't exceed outstanding balance")
      end

      context "when the loan is not found" do
        it "has error message not_found" do
          loan.id = 10000
          post_create(loan)

          expect(json['errors']).to include("not_found")
        end
      end
    end
  end
end
