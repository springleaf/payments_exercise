class Payment < ApplicationRecord
  belongs_to :loan

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :payment_date, presence: true
  validate :not_exceed_loan_balance

  private

  def not_exceed_loan_balance
    if loan && (loan.outstanding_balance - amount) < 0
      errors.add(:amount, "cannot exceed the outstanding loan balance")
    end
  end
end