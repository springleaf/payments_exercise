# == Schema Information
#
# Table name: payments
#
#  id           :integer          not null, primary key
#  amount       :decimal(, )
#  payment_date :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  loan_id      :integer
#
# Indexes
#
#  index_payments_on_loan_id  (loan_id)
#
class Payment < ActiveRecord::Base
  belongs_to :loan
  validates :payment_date, :amount, presence: true
end
