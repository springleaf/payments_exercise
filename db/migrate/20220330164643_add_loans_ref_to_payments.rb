class ChangeLoanRefToPayments < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :loan
  end
end
