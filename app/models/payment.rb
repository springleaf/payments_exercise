class Payment < ActiveRecord::Base
  belongs_to :loan
  validates_presence_of :amount
  validates_numericality_of :amount, greater_than: 0
  validate :under_loan_balance, unless: Proc.new { |p| p.amount.blank? }

  private

  def under_loan_balance
    if amount > loan.outstanding_balance
      errors.add(:amount, 'more than outstanding balance')
    end
  end

end