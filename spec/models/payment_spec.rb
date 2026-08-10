require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:loan) { Loan.create!(funded_amount: 100.0) }

  it "is thread-safe" do
    payment1 = Payment.new(loan: loan, date: Date.today, amount: 60.0)
    payment2 = Payment.new(loan: loan, date: Date.today, amount: 60.0)

    thread1 = Thread.new { payment1.save }
    thread2 = Thread.new { payment2.save }

    thread1.join
    thread2.join

    loan.reload
    expect(loan.outstanding_balance).to eq(40.0)
    expect(loan.payments.count).to eq(1)
  end
end
