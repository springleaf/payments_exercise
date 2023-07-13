FactoryBot.define do
    factory :payment do
      payment_date { DateTime.now }
    end
  end