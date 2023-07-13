# == Schema Information
#
# Table name: loans
#
#  id            :integer          not null, primary key
#  funded_amount :decimal(8, 2)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Loan < ActiveRecord::Base
  has_many :payments, dependent: :destroy
  validates_presence_of :funded_amount

  def outstanding_balance
    funded_amount - payments.sum(:amount)
  end
end
