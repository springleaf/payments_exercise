# == Schema Information
#
# Table name: payments
#
#  id           :integer          not null, primary key
#  amount       :decimal(, )
#  payment_date :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  loan_id      :integer
#
# Indexes
#
#  index_payments_on_loan_id  (loan_id)
#
require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'validation' do
    it { expect(subject).to validate_presence_of(:payment_date) }
    it { expect(subject).to validate_presence_of(:amount) }
  end

  describe 'associations' do
    it { should belong_to(:loan).class_name('Loan')}
  end
end
