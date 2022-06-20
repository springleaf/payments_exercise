class Payments < ActiveRecord::Migration[5.2]
  def change
  	create_table "payments", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "payment_date"
    t.integer "loan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_payments_on_loan_id"
    end
  end
end
