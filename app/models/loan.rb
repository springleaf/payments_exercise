class Loan < ActiveRecord::Base
  has_many :payments, dependent: :destroy

  validates_presence_of :funded_amount
  validates_numericality_of :funded_amount, greater_than: 0

  def outstanding_balance
    funded_amount - payments.sum(&:amount)
  end
end
