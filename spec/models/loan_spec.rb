require 'rails_helper'

RSpec.describe Loan, type: :model do
  describe 'validation' do
    it { expect(subject).to validate_presence_of(:funded_amount) }
  end

  describe 'associations' do
    it { should have_many(:payments).class_name('Payment')}
  end

  describe 'outstanding balance for a loan' do
    it 'returns balance - fund_amount minus all payments amounts' do
        loan = FactoryBot.create(:loan, funded_amount: 1000)

        payment1 = FactoryBot.create(:payment, loan: loan, amount: 200)
        payment2 = FactoryBot.create(:payment, loan: loan, amount: 300)
        payment3 = FactoryBot.create(:payment, loan: loan, amount: 100)

        expected_balance = loan.funded_amount - (payment1.amount + payment2.amount + payment3.amount)
        actual_balance = loan.outstanding_balance

        expect(actual_balance).to eq(expected_balance)
    end
  end
end
