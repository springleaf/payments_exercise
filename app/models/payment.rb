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
class Payment < ActiveRecord::Base
  belongs_to :loan
  validates :payment_date, :amount, presence: true

  validate :payment_amount_valid

  def payment_amount_valid
    return unless amount.present?

    if amount > loan.outstanding_balance
      errors.add(:amount, "cannot exceed the outstanding balance.")
    end
  end
end
