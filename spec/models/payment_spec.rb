require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:loan)    { build(:loan, funded_amount: 100.00) }
  let(:payment) { build(:payment, loan: loan, amount: 20.00) }

  subject       { payment }

  it { should validate_numericality_of(:amount).is_greater_than(0) }
  it { should validate_presence_of(:amount) }

  describe '#under_loan_balance' do
    context 'if payment is greater than balance' do
      let(:payment) { build(:payment, loan: loan, amount: 200.00)}

      it 'returns an error response message' do
        subject.validate
        expect(subject.errors[:amount]).to include("more than outstanding balance")
      end
    end

  end
end
