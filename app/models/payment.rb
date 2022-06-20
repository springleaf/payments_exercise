class Payment < ActiveRecord::Base
 belongs_to :loan 
 validates :amount, presence: true
 validates :payment_date, presence: true
 validate :amount_not_greater_than_outstading_balance_amount

 scope :persisted, -> { where "id IS NOT NULL" }

 private

 def amount_not_greater_than_outstading_balance_amount
 	return errors.add(:loan, "must be associated") if !loan
 	return errors.add(:amount, "amount should be grater than 0") if amount <= 0
 	return true if amount <= loan.outstanding_balance
 	errors.add(:amount,"amount can't be greater than outstanding loan balance")
 end
end
