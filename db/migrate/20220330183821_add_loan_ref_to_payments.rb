class AddLoanRefToPayments < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :loan, foreign_key: true
  end
end
