require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'associations' do
    it 'belongs to loan' do
      loan = Loan.create!(funded_amount: 100.0)
      payment = Payment.create!(loan: loan, amount: 50, payment_date: Date.today)
      expect(payment.loan).to eq(loan)
    end
  end

  describe 'validations' do
    it 'validates presence of amount' do
      payment = Payment.new(amount: nil)
      expect(payment.valid?).to be false
    end

    it 'validates numericality of amount' do
      payment = Payment.new(amount: -10)
      expect(payment.valid?).to be false
    end

    it 'validates presence of payment_date' do
      payment = Payment.new(payment_date: nil)
      expect(payment.valid?).to be false
    end
  end
end