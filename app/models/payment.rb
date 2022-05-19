class Payment < ActiveRecord::Base

  validates_numericality_of :amount, on: :create
  belongs_to :loan

  after_validation :amount_less_than_loan, on: :create

  def amount_less_than_loan
    if amount >= loan.outstanding_payment
      errors.add(:amount, "should be less than loan funded amount")
    end
  end

end
