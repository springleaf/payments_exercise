class Payment < ActiveRecord::Base
  belongs_to :loan
  validates_presence_of :amount
  validates_numericality_of :amount, greater_than: 0
  validate :under_loan_balance

  private

  def under_loan_balance
    if amount && amount > loan.outstanding_balance
      errors.add(:amount, 'more than outstanding balance')
    end
  end

end