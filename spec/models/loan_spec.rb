require 'rails_helper'

RSpec.describe Loan, type: :model do
  describe "#create" do
    context "when missing funded amount" do
      it 'is not valid' do
        loan = build(:loan, funded_amount: nil)

        expect(loan).to_not be_valid
      end
    end
  end

  describe "#outstanding_balance" do
    let(:loan) { create(:loan) }
    let!(:payment) { create(:payment, loan: loan) }
    it "calulates the correct value" do
      expect(loan.outstanding_balance).to eq(loan.funded_amount - payment.amount)
    end
  end
end
