FactoryBot.define do
    factory :payment do
      payment_date { DateTime.now }
      # association :loan
    end
  end