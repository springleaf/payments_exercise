FactoryBot.define do
  factory :payment do
    association :loan, factory: :loan
    amount { Faker::Number.decimal(l_digits: 2) }
  end
end
