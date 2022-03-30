class AddLoansRefToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :loan, :reference
  end
end
