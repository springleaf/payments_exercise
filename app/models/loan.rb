class Loan < ActiveRecord::Base
	has_many :payments, dependent: :destroy

	def self.all_balance
		Loan.all.map{|loan| loan.to_h}
	end

	def outstanding_balance
		return funded_amount if payments.empty?
		funded_amount - payments.persisted.inject(0) {|ag,payments| ag + (payments&.amount || 0)}
	end

	def to_h
		attributes.merge({outstanding_balance: outstanding_balance})	
	end
end