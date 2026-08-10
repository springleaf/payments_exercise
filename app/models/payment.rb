class Payment < ActiveRecord::Base
  belongs_to :loan

  validates :payment_date, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :amount_does_not_exceed_outstanding_balance

  private

  def amount_does_not_exceed_outstanding_balance
    existing_total = loan.payments.where.not(id: self.id).sum(:amount)
    if loan && amount && (existing_total + amount > loan.funded_amount)
      errors.add(:amount, "exceeds the outstanding balance of the loan")
    end
  end
end
