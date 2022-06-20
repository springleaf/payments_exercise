loan = Loan.create!(funded_amount: 500.0)
Payment.create!(amount: 100.0, payment_date: Date.today, loan_id: loan.id)
