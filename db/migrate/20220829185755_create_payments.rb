class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.belongs_to :loan
      t.decimal :amount, precision: 8, scale: 2, default: 0.00, null: false
      t.timestamps
    end
  end
end
