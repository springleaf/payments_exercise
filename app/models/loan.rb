class Loan < ApplicationRecord
  has_many :payments
  validates :funded_amount, presence: true

  def outstanding_balance
    funded_amount - payments_total
  end

  def payments_total
    payments.reload.inject(0.0) { |total, payment| total + payment.amount }
  end

  def as_json(options = {})
    super()
      .merge(options)
      .merge({
        outstanding_balance: self.outstanding_balance 
      })
  end
end
