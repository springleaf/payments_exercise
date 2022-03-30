class Payment < ActiveRecord::Base
  belongs_to :loan
  validates :amount, presence: true
  validate :valid_payment


  # Make sure payment does not exceed outstanding balance for loan
  def valid_payment
    loan = Loan.find (loan_id)
    if amount > (loan.funded_amount - loan.total_payments)
      errors.add(:amount, "Can't be greater than #{loan.outstanding_balance}")
    end
  end
end
