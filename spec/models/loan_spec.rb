require 'rails_helper'

RSpec.describe Loan, type: :model do
  it { should validate_numericality_of(:funded_amount).is_greater_than(0) }
  it { should validate_presence_of(:funded_amount) }

  describe '#outstanding_balance' do
    it 'subtracts payments from funded amount' do
      loan = build(:loan, funded_amount: 100.0)
      loan.payments.build(amount: 50.0)

      expect(loan.outstanding_balance).to eq(50.0)
    end
  end
end