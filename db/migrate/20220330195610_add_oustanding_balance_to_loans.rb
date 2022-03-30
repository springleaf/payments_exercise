class AddOustandingBalanceToLoans < ActiveRecord::Migration[5.2]
  def change
    add_column :loans, :total_payments, :decimal, precision: 10, scale: 2, null: false, default: 0
  end
end
