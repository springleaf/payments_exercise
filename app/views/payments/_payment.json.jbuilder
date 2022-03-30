json.extract! payment, :id, :date, :amount, :created_at, :updated_at
json.url payment_url(payment, format: :json)
