require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe "#create" do
    let(:loan) { create(:loan) }
    context "when missing" do
      context "amount" do
        it "is not valid" do
          payment = build(:payment, loan: loan, amount: nil)

          expect(payment).to_not be_valid
          expect(payment.errors.messages[:amount]).to include("can't be blank")
        end
      end

      context "payment_date" do
        it "is not valid" do
          payment = build(:payment, loan: loan, payment_date: nil)

          expect(payment).to_not be_valid
          expect(payment.errors.messages[:payment_date]).to include("can't be blank")
        end
      end
    end

    context "when payment amount exceeds loan funded amount" do
      it "does not create new payment" do
        payment = build(:payment, amount: 3000.0, loan: loan)

        expect(payment).to_not be_valid
        expect(payment.errors.messages[:amount]).to include("can't exceed outstanding balance")
      end
    end
  end
end
