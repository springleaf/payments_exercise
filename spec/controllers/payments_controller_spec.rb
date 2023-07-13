require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe 'POST #create' do
    xit 'create the payments for a given loan' do
      loan = FactoryBot.create(:loan, funded_amount: 1000)
      expect do
        post :create, params: { loan_id: loan.id, payments: [{ amount: 100, payment_date: Date.new},
                                            { amount: 200, payment_date: Date.new}]
        }
      end.to change { Payment.count }.by(2)
      expect(response.status).to eq(200)


      expect(respond.headers['Location']).to eq('')
      expect(flash[:success]).to eq('Successfully created payments amount for a given loan.')
    end
  end
end