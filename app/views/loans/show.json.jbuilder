json.(@loan, :id, :funded_amount, :outstanding_balance, :created_at, :updated_at)
json.payments @loan.payments, :amount, :created_at