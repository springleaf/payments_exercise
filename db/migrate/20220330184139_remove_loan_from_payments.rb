class RemoveLoanFromPayments < ActiveRecord::Migration[5.2]
  def change
    remove_column :payments, :loan, :string
  end
end
