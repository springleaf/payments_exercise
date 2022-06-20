class Payment < ActiveRecord::Base
 belongs_to :loan 
 validates :amount, presence: true
 validates :payment_date, presence: true
 validate :amount_not_greater_than_outstading_balance_amount

 def payment_creation(params)
 	params[:payment_date] = Time.at(params[:payment_date])
 	super
 end

 private

 def amount_not_greater_than_outstading_balance_amount
 	return errors.add(:loan, "must be associated") if !loan
 	return true if amount <= loan.outstanding_balance 
 	errors.add(:amount,"amount can't be than outstanding loan balance ")
 end

end
