require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:loan) { Loan.create!(funded_amount: 10000) }

  it "is valid with a payment amount within the outstanding balance" do
    payment = Payment.new(loan: loan, payment_date: Date.today, amount: 4500)
    expect(payment).to be_valid
  end

  it "is invalid if the payment amount exceeds the outstanding balance" do
    
    Payment.create!(loan: loan, payment_date: Date.today, amount: 5000)
    Payment.create!(loan: loan, payment_date: Date.today, amount: 4000)
    Payment.create!(loan: loan, payment_date: Date.today, amount: 800)
    
    payment = Payment.new(loan: loan, payment_date: Date.today, amount: 300)
    expect(payment).not_to be_valid
    expect(payment.errors[:amount]).to include("exceeds the outstanding balance of the loan")
  end
end
