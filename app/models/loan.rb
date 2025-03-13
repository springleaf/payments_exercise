class Loan < ActiveRecord::Base
  has_many :payments

  # Calculates the outstanding balance: funded_amount minus total payments made
  def outstanding_balance
    funded_amount - payments.sum(:amount)
  end
end
