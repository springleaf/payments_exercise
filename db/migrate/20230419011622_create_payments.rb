class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.decimal :amount, precision: 8, scale: 2
      t.datetime :payment_date
      t.references :loan, foreign_key: true

      t.timestamps
    end
  end
end
