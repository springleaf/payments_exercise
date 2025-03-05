class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :loan, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.date :payment_date, null: false

      t.timestamps
    end
  end
end