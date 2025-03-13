class Payment < ActiveRecord::Base
  belongs_to :loan

  validates :payment_date, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :amount_does_not_exceed_outstanding_balance

  private

  def amount_does_not_exceed_outstanding_balance
    # Use the loan's outstanding_balance (funded_amount minus sum of payments)
    if loan && amount && amount > loan.outstanding_balance
      errors.add(:amount, "exceeds the outstanding balance of the loan")
    end
  end
end
