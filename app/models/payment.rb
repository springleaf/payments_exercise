class Payment < ActiveRecord::Base
  belongs_to :loan
  validates :amount, :payment_date, presence: true
  validate :amount_does_not_exceed_outstanding_balance

  def amount_does_not_exceed_outstanding_balance
    return unless amount.present?

    if amount > loan.outstanding_balance
      errors.add(:amount, "can't exceed outstanding balance")
    end
  end
end
