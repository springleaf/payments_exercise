class Loan < ActiveRecord::Base

  validates_numericality_of :funded_amount
  has_many :payments

  def outstanding_payment
    funded_amount - payments.sum(:amount)
  end

end
