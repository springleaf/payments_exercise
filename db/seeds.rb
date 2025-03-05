loan = Loan.create(funded_amount: 100.0)
loan.payments.create(amount: 20.0, payment_date: Date.today)
loan.payments.create(amount: 30.0, payment_date: Date.today)