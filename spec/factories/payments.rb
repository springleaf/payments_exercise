FactoryBot.define do
  factory :payment, class: Payment do
    amount { 200.0 }
    payment_date { Time.zone.now }
    loan
  end
end
