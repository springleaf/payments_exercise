FactoryBot.define do
  factory :loan do
    funded_amount { Faker::Number.decimal(l_digits: 2) }
  end
end
